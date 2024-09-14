from datetime import date

from django.db.models import Avg, Count, Max, Subquery, OuterRef
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from common.models import OTPAuthentication, AppUser
from common.utils import send_otp
from ml_models.model import get_restaurant_sentiment
from tourspot.models import Booking
from tourspot.serializers import BookingSerializer
from usersapp.models import Users
from usersapp.serializers import UserSerializer
from .models import MenuItem, Restaurant, Review, Reservation
from .serializers import *
from rest_framework.pagination import PageNumberPagination


# Create your views here.
@api_view(['POST'])
@csrf_exempt
def add_menu(request):
    serializer = MenuItemSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def edit_menu(request):
    # print(request.data)
    update_request_fields = request.data
    try:
        menu_item = MenuItem.objects.get(pk=update_request_fields['id'])
    except MenuItem.DoesNotExist:
        return Response("Menu item does not exist", status=status.HTTP_404_NOT_FOUND)

    for key, value in update_request_fields.items():
        setattr(menu_item, key, value)
        # menu_item
    menu_item.save()
    return Response("Updated successfully", status=status.HTTP_200_OK)


@api_view(['POST'])
def view_menu(request):
    try:
        res_manager = AppUser.objects.get(email=request.data['email'])
        restaurant = Restaurant.objects.get(user=res_manager)
        menu_item_list = MenuItem.objects.filter(restaurant=restaurant)
        menu_item_list_serializer = MenuItemSerializer(menu_item_list, many=True)
        return Response(menu_item_list_serializer.data, status=status.HTTP_200_OK)
    except Restaurant.DoesNotExist:
        return Response(menu_item_list_serializer.errors, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
@csrf_exempt
def add_restaurant(request):
    serializer = RestaurantSerializer(data=request.data)
    if serializer.is_valid():
        rest = serializer.save()
        email = serializer.validated_data.get('user').get('email')
        otp = send_otp(email)
        OTPAuthentication.objects.create(app_user=rest.user, otp=otp)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def restaurant_details(request, restaurant_id):
    try:
        restaurant = Restaurant.objects.get(pk=restaurant_id)
        restaurant_serializer = RestaurantSerializer(restaurant)
        if restaurant_serializer:
            return Response(restaurant_serializer.data, status=status.HTTP_200_OK)
        return Response(restaurant_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except Restaurant.DoesNotExist:
        return Response("Restaurant does not exist", status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
def edit_restaurant(request, restaurant_id):
    # print(request.data)
    update_request_fields = request.data
    try:
        restaurant = Restaurant.objects.get(pk=restaurant_id)
    except Restaurant.DoesNotExist:
        return Response("Restaurant does not exist", status=status.HTTP_404_NOT_FOUND)

    for key, value in update_request_fields.items():
        if hasattr(restaurant, key):
            setattr(restaurant, key, value)
        else:
            setattr(restaurant.user, key, value)

        # restaurant
    restaurant.user.save()
    restaurant.save()
    return Response("Updated successfully", status=status.HTTP_200_OK)


# @api_view(['GET'])
# def recommended_restaurants(request, email):
#     user = Users.objects.get(email=email)
#     recommended_restaurants = Restaurant.objects.filter(user=user)


@api_view(['POST'])
def add_restaurant_review(request):
    if request.method == 'POST':
        review = request.data['review']
        email = request.data['email']
        rating = request.data['rating']
        restaurant_id = request.data['restaurant_id']
        prediction = get_restaurant_sentiment(review)
        if prediction:
            user = AppUser.objects.get(email=email)
            customer = Users.objects.get(user=user)
            restaurant = Restaurant.objects.get(pk=restaurant_id)
            review = Review.objects.create(user=customer, restaurant=restaurant, review=review, rating=rating)
            serializer = ReviewSerializer(review)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response("Fake review", status=status.HTTP_200_OK)

    else:
        return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def get_restaurant_reviews(request, restaurant_id):
    ratings = {"1": 0, "2": 0, "3": 0, "4": 0, "5": 0}
    reviews = Review.objects.filter(restaurant_id=restaurant_id)
    for review in reviews:
        ratings[str(review.rating)] += 1

    aggregate_data = reviews.aggregate(average_rating=Avg('rating'), total_reviews=Count('id'))
    average_rating = aggregate_data['average_rating']
    total_reviews = aggregate_data['total_reviews']

    serializer = ReviewSerializer(reviews, many=True)
    response = {
        "ratings": ratings,
        "reviews": serializer.data,
        "avg_rating": average_rating,
        "total_reviews": total_reviews
    }
    return Response(response, status=status.HTTP_200_OK)


@api_view(['POST'])
@csrf_exempt
def add_reservation(request):
    try:
        user = Users.objects.get(id=request.data['user_id'])
        restaurant = Restaurant.objects.get(id=request.data['restaurant_id'])
        reservation = Reservation.objects.create(
            user=user,
            date=request.data['date'],
            start_time=request.data['start_time'],
            end_time=request.data['end_time'],
            reservation_type=request.data['reservation_type'],
            number_of_people=request.data['number_of_people'],
            restaurant=restaurant, status="pending"
        )
        serializer = ReservationSerializer(reservation)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    except:
        return Response("Error occured during reservation", status=status.HTTP_400_BAD_REQUEST)


@api_view(["GET"])
def get_top_restaurants(request):
    review = Review.objects.all()
    restaurant_ratings = review.values('restaurant').annotate(avg_rating=Avg('rating'))
    top_restaurants = restaurant_ratings.order_by('-avg_rating')[:3]
    top_restaurant_ids = [r['restaurant'] for r in top_restaurants]

    restaurants = Restaurant.objects.filter(id__in=top_restaurant_ids).annotate(
        average_rating=Subquery(
            Review.objects.filter(restaurant=OuterRef('pk')).values('restaurant').annotate(
                avg_rating=Avg('rating')
            ).values('avg_rating')
        )
    ).order_by('-average_rating')

    serializer = RestaurantAndAvgRating(restaurants, many=True)
    if serializer.data:
        return Response(serializer.data, status.HTTP_200_OK)
    else:
        return Response("Error in backend", status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def accept_reservation(request):
    try:
        user = Users.objects.get(id=request.data['user_id'])
        restaurant = Restaurant.objects.get(id=request.data['restaurant_id'])

        reservation = Reservation.objects.get(user=user,
                                              restaurant=restaurant,
                                              date=request.data['date'],
                                              start_time=request.data['start_time'],
                                              status="pending")

        setattr(reservation, 'status', "accepted")
        setattr(reservation, 'message', request.data['message'])
        reservation.save()
        return Response("Reservation Accepted", status=status.HTTP_200_OK)
    except:
        return Response("Error occurred during reservation processing", status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def reject_reservation(request):
    try:
        user = Users.objects.get(id=request.data['user_id'])
        restaurant = Restaurant.objects.get(id=request.data['restaurant_id'])

        reservation = Reservation.objects.get(user=user,
                                              restaurant=restaurant,
                                              date=request.data['date'],
                                              start_time=request.data['start_time'],
                                              status="pending")

        setattr(reservation, 'status', "rejected")
        setattr(reservation, 'message', request.data['message'])
        reservation.save()
        return Response("Reservation Rejected", status=status.HTTP_200_OK)
    except:
        return Response("Error occurred during reservation processing", status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def view_restaurant(request):
    try:
        restaurant_list = Restaurant.objects.filter()
        paginator = StandardResultsSetPagination()
        paginated_restaurants = paginator.paginate_queryset(restaurant_list, request)
        # restaurant_list_serializer = ShowRestaurantSerializer(paginated_restaurants, many=True)
        restaurant_list_serializer = RestaurantSerializer(paginated_restaurants, many=True)

        response_data = {
            "count": restaurant_list.count(),
            "page_size": StandardResultsSetPagination.page_size,
            "results": restaurant_list_serializer.data
        }

        return Response(response_data, status=status.HTTP_200_OK)
    except Restaurant.DoesNotExist:
        return Response(restaurant_list_serializer.errors, status=status.HTTP_404_NOT_FOUND)


@api_view(['GET'])
def visiting_history(request, user_id):
    try:
        today = date.today()
        reservations = Reservation.objects.filter(user_id=user_id, status="accepted", date__lt=today)
        bookings = Booking.objects.filter(user_id=user_id, date__lt=today, status="accepted")
        reservationSerializer = ReservationSerializer(reservations, many=True)
        bookingSerializer = BookingSerializer(bookings, many=True)
        response = {
            "restaurant": reservationSerializer.data,
            "tour-spot": bookingSerializer.data
        }
        return Response(response, status=status.HTTP_200_OK)
    except Users.DoesNotExist:
        return Response({"error": "user not found"}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['POST'])
def get_reservation_details(request):
    try:
        res_manager = AppUser.objects.get(email=request.data['email'])
        res = Restaurant.objects.get(user=res_manager)
        # res = Restaurant.objects.get(id=restaurant_id)
        reservations = Reservation.objects.filter(restaurant=res, status='pending')

        reservation_serializer = ReservationSerializer(reservations, many=True)
        if reservation_serializer:
            return Response(reservation_serializer.data, status=status.HTTP_200_OK)
        return Response(reservation_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except Restaurant.DoesNotExist:
        return Response("Restaurant does not exist", status=status.HTTP_404_NOT_FOUND)
    except Reservation.DoesNotExist:
        return Response("Reservation is empty", status=status.HTTP_204_NO_CONTENT)

from django.db.models import Avg, Count, Max, Subquery, OuterRef
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from ml_models.model import get_restaurant_sentiment
from usersapp.models import Users
from usersapp.serializers import UserSerializer
from .models import MenuItem, Restaurant, Review, Reservation
from .serializers import MenuItemSerializer, ReviewSerializer, RestaurantAndAvgRating
from .serializers import RestaurantSerializer
from .serializers import ReservationSerializer


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

@api_view(['GET'])
def view_menu(request, restaurant_id):
    try:
        restaurant = Restaurant.objects.get(pk=restaurant_id)
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
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def restaurant_details(request, restaurant_id):
    try:
        restaurant = Restaurant.objects.get(pk=restaurant_id)
        restaurant_serializer = RestaurantSerializer(restaurant)
        return Response(restaurant_serializer.data, status=status.HTTP_200_OK)
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
        setattr(restaurant, key, value)
        # restaurant
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
            customer = Users.objects.get(email=email)
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
    ratings ={"1": 0, "2": 0, "3": 0, "4": 0, "5": 0}
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
        reservation = Reservation.objects.create(user=user, date=request.data['date'], start_time=request.data['start_time'], end_time=request.data['end_time'], reservation_type=request.data['reservation_type'], number_of_people=request.data['number_of_people'], restaurant=restaurant, status="pending")
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
    user = Users.objects.get(id=request.data['user_id'])
    restaurant = Restaurant.objects.get(id=request.data['restaurant_id'])
    reservation = Reservation.objects.get(user=user, restaurant=restaurant)
    setattr(reservation, 'status', "accepted")
    setattr(reservation, 'message', request.data['message'])
    try:
        return Response("Reservation Accepted", status=status.HTTP_201_CREATED)
    except:
        return Response("Error occured during reservation processing", status=status.HTTP_400_BAD_REQUEST)

import datetime
from collections import defaultdict

from django.contrib.auth.hashers import make_password
from django.db.models import Avg, Count, Subquery, OuterRef
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.http import JsonResponse

from common.models import OTPAuthentication, AppUser
from common.serializers import AppUserSerializer
from common.utils import send_otp
from ml_models.model import get_dayTourSpot_sentiment
from tourspot.models import Tourspot, Booking, Review
from tourspot.serializers import TourspotSerializer, BookingSerializer, TourSpotReviewSerializer, \
    DayTourSpotAndAvgRating, StandardResultsSetPagination
from usersapp.models import Users
from datetime import date

from usersapp.serializers import UserSerializer


# Create your views here.
@api_view(['POST'])
@csrf_exempt
def add_manager(request):
    serializer = TourspotSerializer(data=request.data)
    if serializer.is_valid():
        #     password = serializer.validated_data.get('password')
        #     hashed_password = make_password(password)

        tour = serializer.save()
        email = serializer.validated_data.get('user').get('email')
        otp = send_otp(email)
        OTPAuthentication.objects.create(app_user=tour.user, otp=otp)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def view_tourspot_list(request):
    tourspots = Tourspot.objects.all()
    paginator = StandardResultsSetPagination()
    paginated_tourspots = paginator.paginate_queryset(tourspots, request)
    tourspot_serializer = TourspotSerializer(paginated_tourspots, many=True)
    # tourspot_list = list(tourspots.values())

    response_data = {
        "count": tourspots.count(),
        "page_size": StandardResultsSetPagination.page_size,
        "results": tourspot_serializer.data
    }
    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
def view_tourspot_detail(request, id):
    try:
        tourspot = Tourspot.objects.get(pk=id)
        # tourspot_data = {
        #     'id': tourspot.id,
        #     'name': tourspot.name,
        #     'manager_name': tourspot.manager_name,
        #     'contact': tourspot.contact,
        #     'email': tourspot.email,
        #     'opening_time': tourspot.opening_time,
        #     'closing_time': tourspot.closing_time,
        #     'description': tourspot.description,
        #     'address': tourspot.address,
        #     'password': tourspot.password,
        #     'entry_fee': tourspot.entry_fee,
        #     'wifi': tourspot.wifi,
        #     'parking': tourspot.parking,
        #     'food': tourspot.food,
        #     'pool': tourspot.pool,
        #     'other_services': tourspot.other_services,
        # }
        tourspot_data = TourspotSerializer(tourspot).data
        return Response(tourspot_data, status=status.HTTP_200_OK)
    except Tourspot.DoesNotExist:
        return Response({'error': 'Tourspot not found'}, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
@csrf_exempt
def add_booking(request):
    try:
        user = Users.objects.get(user_id=request.data['user_id'])
        tourspot = Tourspot.objects.get(id=request.data['tourspot_id'])
        booking = Booking.objects.create(user=user, date=request.data['date'], subtotal=request.data['subtotal'],
                                         number_of_people=request.data['number_of_people'], tourspot=tourspot,
                                         status="pending")
        serializer = BookingSerializer(booking)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    except:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # serializer = BookingSerializer(data=request.data)
    # if serializer.is_valid():
    #     serializer.save()
    #     return Response(serializer.data, status=status.HTTP_201_CREATED)
    # return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def accept_booking(request):
    try:
        booking = Booking.objects.get(id=request.data['booking_id'])
        setattr(booking, 'status', "accepted")
        setattr(booking, 'message', request.data['message'])
        booking.save()
        return Response("Tourspot Booking Accepted", status=status.HTTP_200_OK)
    except:
        return Response("Error occurred during booking process", status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def reject_booking(request):
    try:
        booking = Booking.objects.get(id=request.data['booking_id'])
        setattr(booking, 'status', "rejected")
        setattr(booking, 'message', request.data['message'])
        booking.save()
        return Response("Tourspot Booking Rejected", status=status.HTTP_200_OK)
    except:
        return Response("Error occurred during booking process", status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def view_booking(request, user_id):
    if request.method == 'GET':
        today = date.today()
        bookings = Booking.objects.filter(user_id=user_id, date__gt=today, status__in=["pending", "accepted"])
        booking_serializer = BookingSerializer(bookings, many=True)
        return Response(booking_serializer.data, status=status.HTTP_200_OK)
    return Response("Error occurred during booking process", status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def view_pending_booking(request, tourspot_id):
    if request.method == 'GET':
        today = date.today()
        bookings = Booking.objects.filter(tourspot_id=tourspot_id, date__gte=today, status__in=["pending"])
        booking_serializer = BookingSerializer(bookings, many=True)
        return Response(booking_serializer.data, status=status.HTTP_200_OK)
    return Response(BookingSerializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def view_booking_manager(request, tourspot_id):
    if request.method == 'GET':
        bookings = Booking.objects.filter(tourspot_id=tourspot_id, status__in=["accepted"])
        booking_serializer = BookingSerializer(bookings, many=True)
        return Response(booking_serializer.data, status=status.HTTP_200_OK)
    return Response(BookingSerializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def add_dayTour_review(request):
    if request.method == 'POST':
        review = request.data['review']
        email = request.data['email']
        rating = request.data['rating']
        dayTourSpot_id = request.data['dayTourSpot_id']
        prediction = get_dayTourSpot_sentiment(review)
        if prediction:
            user = AppUser.objects.get(email=email)
            customer = Users.objects.get(user=user)
            dayTour = Tourspot.objects.get(pk=dayTourSpot_id)
            review = Review.objects.create(user=customer, tourSpot=dayTour, rating=rating, review=review)
            serializer = TourSpotReviewSerializer(review)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response("Fake review", status=status.HTTP_200_OK)

    else:
        return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def get_dayTour_reviews(request, tourSpot_id):
    ratings = {"1": 0, "2": 0, "3": 0, "4": 0, "5": 0}
    reviews = Review.objects.filter(tourSpot_id=tourSpot_id)
    for review in reviews:
        ratings[str(review.rating)] += 1

    aggregate_data = reviews.aggregate(average_rating=Avg('rating'), total_reviews=Count('id'))
    average_rating = aggregate_data['average_rating']
    total_reviews = aggregate_data['total_reviews']

    serializer = TourSpotReviewSerializer(reviews, many=True)
    response = {
        "ratings": ratings,
        "reviews": serializer.data,
        "avg_rating": average_rating,
        "total_reviews": total_reviews
    }
    return Response(response, status=status.HTTP_200_OK)


@api_view(["GET"])
def get_top_dayTourSpot(request):
    review = Review.objects.all()
    dayTourSpot_ratings = review.values('tourSpot').annotate(avg_rating=Avg('rating'))

    if dayTourSpot_ratings.exists():
        top_dayTourSpot = dayTourSpot_ratings.order_by('-avg_rating')[:3]
        top_dayTourSpot_ids = [r['tourSpot'] for r in top_dayTourSpot]
    else:
        top_dayTourSpot_ids = Tourspot.objects.values_list('id', flat=True)[:3]

    dayTourSpots = Tourspot.objects.filter(id__in=top_dayTourSpot_ids).annotate(
        average_rating=Subquery(
            Review.objects.filter(tourSpot=OuterRef('pk')).values('tourSpot').annotate(
                avg_rating=Avg('rating')
            ).values('avg_rating')
        )
    ).order_by('-average_rating')

    serializer = DayTourSpotAndAvgRating(dayTourSpots, many=True)
    if serializer.data:
        return Response(serializer.data, status.HTTP_200_OK)
    else:
        return Response("Error in backend", status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def edit_tourspot(request, tourspot_id):
    # print(request.data)
    update_request_fields = request.data
    try:
        tourspot = Tourspot.objects.get(pk=tourspot_id)
    except Tourspot.DoesNotExist:
        return Response("Tourspot does not exist", status=status.HTTP_404_NOT_FOUND)

    for key, value in update_request_fields.items():
        if hasattr(tourspot, key):
            setattr(tourspot, key, value)
        else:
            setattr(tourspot.user, key, value)

        # restaurant
    tourspot.user.save()
    tourspot.save()
    return Response("Updated successfully", status=status.HTTP_200_OK)


@api_view(['GET'])
def tourSpot_selling_info(request, tourSpot_id):
    try:
        today = timezone.now()
        first_day_of_current_month = today.replace(day=1)
        first_day_of_previous_month = (first_day_of_current_month - datetime.timedelta(days=1)).replace(day=1)
        last_day_of_previous_month = first_day_of_current_month - datetime.timedelta(days=1)

        current_month_bookings = Booking.objects.filter(
            tourspot_id=tourSpot_id,
            date__gte=first_day_of_current_month
        )

        previous_month_bookings = Booking.objects.filter(
            tourspot_id=tourSpot_id,
            date__gte=first_day_of_previous_month,
            date__lte=last_day_of_previous_month
        )

        total_customers_current = set(booking.user.id for booking in current_month_bookings)
        total_orders_current = current_month_bookings.count()
        total_revenue_current = sum(booking.subtotal for booking in current_month_bookings)

        total_customers_previous = set(booking.user.id for booking in previous_month_bookings)
        total_orders_previous = previous_month_bookings.count()
        total_revenue_previous = sum(booking.subtotal for booking in previous_month_bookings)

        def calculate_percentage_change(current, previous):
            if previous == 0:
                return 100 if current > 0 else 0
            return ((current - previous) / previous) * 100

        customer_change_percentage = calculate_percentage_change(
            len(total_customers_current), len(total_customers_previous)
        )
        order_change_percentage = calculate_percentage_change(
            total_orders_current, total_orders_previous
        )
        revenue_change_percentage = calculate_percentage_change(
            total_revenue_current, total_revenue_previous
        )

        start_of_last_week = today - datetime.timedelta(days=6)
        last_week_bookings = Booking.objects.filter(
            tourspot_id=tourSpot_id,
            date__gte=start_of_last_week,
            date__lte=today
        )

        last_week_dates = [(today - datetime.timedelta(days=i)).strftime('%Y-%m-%d') for i in range(7)]
        daywise_customer_count = {date: 0 for date in last_week_dates}
        for booking in last_week_bookings:
            day = booking.date.strftime('%Y-%m-%d')
            daywise_customer_count[day] += 1

        response_data = {
            'total_customers': len(total_customers_current),
            'total_orders': total_orders_current,
            'total_revenue': total_revenue_current,
            'customer_change_percentage': customer_change_percentage,
            'order_change_percentage': order_change_percentage,
            'revenue_change_percentage': revenue_change_percentage,
            'daywise_customer_count': daywise_customer_count
        }

        return Response(response_data, status=status.HTTP_200_OK)

    except Booking.DoesNotExist:
        return Response("Booking does not exist", status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def get_top_customers(request, tourSpot_id):
    try:
        bookings = (Booking.objects.filter(tourspot_id=tourSpot_id).values('user_id').annotate(booking_count=Count('id'))
                    .order_by('-booking_count'))[:5]
        for user in bookings:
            customer = Users.objects.get(id=user['user_id'])
            customerSerializer = UserSerializer(customer)
            user['customer_name'] = customerSerializer.data['name']
        return Response(bookings, status=status.HTTP_200_OK)

    except Booking.DoesNotExist:
        return Response("Booking does not exist", status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST)


import datetime

from django.contrib.auth.hashers import make_password
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.http import JsonResponse

from common.models import OTPAuthentication, AppUser
from common.utils import send_otp
from ml_models.model import get_dayTourSpot_sentiment
from tourspot.models import Tourspot, Booking, Review
from tourspot.serializers import TourspotSerializer, BookingSerializer, TourSpotReviewSerializer
from usersapp.models import Users
from datetime import date


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
    tourspot_serializer = TourspotSerializer(tourspots, many=True)
    # tourspot_list = list(tourspots.values())
    return Response(tourspot_serializer.data, status=status.HTTP_200_OK)


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
        user = Users.objects.get(id=request.data['user_id'])
        tourspot = Tourspot.objects.get(id=request.data['tourspot_id'])
        booking = Booking.objects.create(user=user, date=request.data['date'], subtotal=request.data['subtotal'],
                                         number_of_people=request.data['number_of_people'], tourspot=tourspot,
                                         status="pending")
        serializer = BookingSerializer(booking)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    except:
        return Response("Error occured during booking", status=status.HTTP_400_BAD_REQUEST)

    serializer = BookingSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def accept_booking(request):
    try:
        user = Users.objects.get(id=request.data['user_id'])
        tourspot = Tourspot.objects.get(id=request.data['tourspot_id'])
        booking = Booking.objects.get(user=user, tourspot=tourspot, date=request.data['date'])
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
        user = Users.objects.get(id=request.data['user_id'])
        tourspot = Tourspot.objects.get(id=request.data['tourspot_id'])
        booking = Booking.objects.get(user=user, tourspot=tourspot, date=request.data['date'])
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

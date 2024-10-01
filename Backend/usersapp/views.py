from django.contrib.auth.hashers import check_password
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from restaurant.serializers import RestaurantSerializer
from tourspot.serializers import TourspotSerializer
from .serializers import *
from rest_framework_simplejwt.tokens import RefreshToken
from common.models import OTPAuthentication

from common.utils import send_otp

from restaurant.models import Restaurant
from tourspot.models import Tourspot


@api_view(['POST'])
@csrf_exempt
def register(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.save()
        email = serializer.validated_data.get('user').get('email')
        otp = send_otp(email)
        OTPAuthentication.objects.create(app_user=user.user, otp=otp)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def login(request):
    data = request.data
    email = data.get('email')
    password = data.get('password')
    # print(password)

    try:
        customer = AppUser.objects.get(email=email)
        # user = Users.objects.get(user=customer)
        # print(type(user))
        # print(customer)
        if customer is not None and check_password(password, customer.password):
            # serializer = UserSerializer(customer)
            serializer = AppUserSerializer(customer)
            manager_id = serializer.data.get('id')

            refresh = RefreshToken.for_user(customer)
            token = {
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            }

            spot_id = None
            spot_name = None
            if serializer.data.get('user_type') == 'tour_manager':
                tourspot = Tourspot.objects.get(user_id=manager_id)
                serializer = TourspotSerializer(tourspot)
                spot_id = tourspot.id
                spot_name = serializer.data['tourspot_name']

            elif serializer.data.get('user_type') == 'res_manager':
                restaurant = Restaurant.objects.get(user_id=manager_id)
                serializer = RestaurantSerializer(restaurant)
                spot_id = restaurant.id
                spot_name = serializer.data['restaurant_name']

            response_data = {
                'user': serializer.data,
                'tokens': token,
                'spot_id': spot_id,
                'spot_name': spot_name
            }

            return Response(response_data, status=status.HTTP_200_OK)
        else:
            return Response({"detail": "Invalid credentials"}, status=status.HTTP_400_BAD_REQUEST)
    except AppUser.DoesNotExist:
        return Response({"detail": "User not found"}, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
def get_user_details(request):
    try:
        customer = AppUser.objects.get(email=request.data['email'])
        user = Users.objects.get(user=customer)
        serializer = UserSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except AppUser.DoesNotExist:
        return Response("User not found", status=status.HTTP_404_NOT_FOUND)
    except Users.DoesNotExist:
        return Response("User not found", status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST)


@csrf_exempt
@api_view(['POST'])
def update_user_details(request):
    try:
        tag = request.data.get('tag')
        info = request.data.get('info')
        user = AppUser.objects.get(email=request.data.get('email'))
        customer = Users.objects.get(user=user)

        if hasattr(user, tag):
            setattr(user, tag, info)
            user.save()
        else:
            setattr(customer, tag, info)
            customer.save()

        serializer = UserSerializer(customer)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def view_favorite(request, user_id):
    try:
        user = Users.objects.get(user_id=user_id)
        favorite_list = Favorite.objects.filter(user=user)
        favorite_list_serializer = FavoriteSerializer(favorite_list, many=True)
        return Response(favorite_list_serializer.data, status=status.HTTP_200_OK)
    except user.DoesNotExist:
        return Response(favorite_list_serializer.errors, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
@csrf_exempt
def add_to_favorite(request):
    user = Users.objects.get(user_id=request.data['user_id'])
    restaurant = Restaurant.objects.get(pk=request.data['restaurant_id'])
    object_data = {"user": user.pk, "restaurant": restaurant.pk}
    serializer = FavoriteSerializer(data=object_data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def remove_from_favorite(request):
    try:
        user = Users.objects.get(user_id=request.data['user_id'])
        favorite = Favorite.objects.get(user=user, restaurant=request.data['restaurant_id'])
        favorite.delete()
        return Response('Restaurant removed from Favorite', status=status.HTTP_200_OK)
    except favorite.DoesNotExist:
        return Response(favorite.errors, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
def get_manager_info(request):
    try:
        customer = AppUser.objects.get(email=request.data['email'])
        serializer = AppUserSerializer(customer)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except AppUser.DoesNotExist:
        return Response("User not found", status=status.HTTP_404_NOT_FOUND)
    except Users.DoesNotExist:
        return Response("User not found", status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

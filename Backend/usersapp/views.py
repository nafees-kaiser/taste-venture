from django.contrib.auth.hashers import check_password
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import *
from rest_framework_simplejwt.tokens import RefreshToken
from common.models import OTPAuthentication

from common.utils import send_otp

from restaurant.models import Restaurant


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
        if customer is not None and check_password(password, customer.password):
            # serializer = UserSerializer(customer)
            serializer = AppUserSerializer(customer)

            refresh = RefreshToken.for_user(customer)
            token = {
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            }
            response_data = {
                'user': serializer.data,
                'tokens': token,
            }
            return Response(response_data, status=status.HTTP_200_OK)
        else:
            return Response({"detail": "Invalid credentials"}, status=status.HTTP_400_BAD_REQUEST)
    except AppUser.DoesNotExist:
        return Response({"detail": "User not found"}, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
def get_user_details(request):
    email = request.data.get('email')
    customer = AppUser.objects.get(email=email)
    user = Users.objects.get(user=customer)
    serializer = UserSerializer(user)
    if serializer.data:
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@csrf_exempt
@api_view(['POST'])
def update_user_details(request):
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
    if serializer.data:
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def view_favorite(request, user_id):
    try:
        user = Users.objects.get(pk=user_id)
        favorite_list = Favorite.objects.filter(user=user)
        favorite_list_serializer = FavoriteSerializer(favorite_list, many=True)
        return Response(favorite_list_serializer.data, status=status.HTTP_200_OK)
    except user.DoesNotExist:
        return Response(favorite_list_serializer.errors, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
@csrf_exempt
def add_to_favorite(request):
    user = Users.objects.get(pk=request.data['user_id'])
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
        favorite = Favorite.objects.get(user=request.data['user_id'], restaurant=request.data['restaurant_id'])
        favorite.delete()
        return Response('Restaurant removed from Favorite', status=status.HTTP_200_OK)
    except favorite.DoesNotExist:
        return Response(favorite.errors, status=status.HTTP_404_NOT_FOUND)

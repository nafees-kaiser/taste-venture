import email
import random
from django.utils import timezone

from django.contrib.auth.hashers import check_password, make_password
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import *
from .serializers import *
from rest_framework_simplejwt.tokens import RefreshToken

from .utils import send_otp


@api_view(['POST'])
@csrf_exempt
def register(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        password = serializer.validated_data.get('password')
        email = serializer.validated_data.get('email')
        hashed_password = make_password(password)

        user = serializer.save(password=hashed_password)
        otp = send_otp(email)
        OTPAuthentication.objects.create(user=user, otp=otp)
        # added_user = UsersDetailSerializer(user, many=False)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def login(request):
    data = request.data
    email = data.get('email')
    password = data.get('password')
    # print(password)

    try:
        user = Users.objects.get(email=email)
        # print(type(user))
        if user is not None and check_password(password, user.password):
            serializer = UserSerializer(user)

            refresh = RefreshToken.for_user(user)
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
    except Users.DoesNotExist:
        return Response({"detail": "User not found"}, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
@csrf_exempt
def verify_otp(request):
    OTP_serializer = OTPSerializer(data=request.data)
    if OTP_serializer.is_valid():
        otp = OTP_serializer.validated_data.get('otp')
        email = OTP_serializer.validated_data.get('email')
        # print(email)
        try:
            user = Users.objects.get(email=email)
            gen_otp = OTPAuthentication.objects.get(user=user, otp=otp)

            if (timezone.now() - gen_otp.created_at).seconds > 30000:
                gen_otp.delete()
                return Response("OTP expired", status=status.HTTP_400_BAD_REQUEST)
            elif otp != gen_otp.otp:
                # user.delete()
                gen_otp.delete()
                return Response("Invalid OTP", status=status.HTTP_400_BAD_REQUEST)
            gen_otp.delete()
            return Response("OTP verified", status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response("User not found", status=status.HTTP_404_NOT_FOUND)
    return Response(OTP_serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def update_password(request):
    password = request.data.get('password')
    email = request.data.get('email')
    user = Users.objects.get(email=email)
    try:
        password = make_password(password)
        user.password = password
        user.save()
        return Response("Password updated successfully", status=status.HTTP_200_OK)
    except Users.DoesNotExist:
        return Response("User not found", status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
def get_user_details(request):
    email = request.data.get('email')
    user = Users.objects.get(email=email)
    serializer = UserSerializer(user)
    if serializer.data:
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@csrf_exempt
@api_view(['POST'])
def update_user_details(request):
    tag = request.data.get('tag')
    info = request.data.get('info')
    user = Users.objects.get(email=request.data.get('email'))
    setattr(user, tag, info)
    user.save()
    serializer = UserSerializer(user)
    if serializer.data:
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def verify_email(request):
    try:
        email = request.data.get('email')
        user = Users.objects.get(email=email)
        otp = send_otp(email)
        OTPAuthentication.objects.create(user=user, otp=otp)
        return Response("Email verified", status=status.HTTP_200_OK)
    except Users.DoesNotExist:
        return Response("Email is not registered. Please try again", status=status.HTTP_404_NOT_FOUND)


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
    serializer = FavoriteSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
@csrf_exempt
def remove_from_favorite(request):
    try:
        favorite = Favorite.objects.get(user=request.data['user'], restaurant=request.data['restaurant'])
        favorite.delete()
        return Response('Restaurant removed from Favorite', status=status.HTTP_200_OK)
    except favorite.DoesNotExist:
        return Response(favorite.errors, status=status.HTTP_404_NOT_FOUND)
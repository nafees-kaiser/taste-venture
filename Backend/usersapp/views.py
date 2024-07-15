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
    print(password)


    try:
        user = Users.objects.get(email=email)
        print(type(user))
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
    # email = 'oyonafees2001@gmail.com'
    # send_otp(email)
    # return Response("All okay", status=status.HTTP_200_OK)
    OTP_serializer = OTPSerializer(data=request.data)
    if OTP_serializer.is_valid():
        otp = OTP_serializer.validated_data.get('otp')
        email = OTP_serializer.validated_data.get('email')
        print(email)
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
    except User.DoesNotExist:
        return Response("User not found", status=status.HTTP_404_NOT_FOUND)
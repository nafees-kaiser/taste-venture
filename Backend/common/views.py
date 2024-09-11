from django.utils import timezone
from django.contrib.auth.hashers import make_password
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import *
from .serializers import *
from common.utils import send_otp


@api_view(['POST'])
@csrf_exempt
def verify_otp(request):
    otp_serializer = OTPSerializer(data=request.data)
    if otp_serializer.is_valid():
        otp = otp_serializer.validated_data.get('otp')
        email = otp_serializer.validated_data.get('email')
        # print(email)
        try:
            app_user = AppUser.objects.get(email=email)
            gen_otp = OTPAuthentication.objects.get(app_user=app_user, otp=otp)

            if (timezone.now() - gen_otp.created_at).seconds > 30000:
                gen_otp.delete()
                return Response("OTP expired", status=status.HTTP_400_BAD_REQUEST)
            elif otp != gen_otp.otp:
                # user.delete()
                gen_otp.delete()
                return Response("Invalid OTP", status=status.HTTP_400_BAD_REQUEST)
            gen_otp.delete()
            return Response("OTP verified", status=status.HTTP_200_OK)
        except AppUser.DoesNotExist:
            return Response("User not found", status=status.HTTP_404_NOT_FOUND)
    return Response(otp_serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def update_password(request):
    password = request.data.get('password')
    email = request.data.get('email')
    user = AppUser.objects.get(email=email)
    try:
        password = make_password(password)
        user.password = password
        user.save()
        return Response("Password updated successfully", status=status.HTTP_200_OK)
    except AppUser.DoesNotExist:
        return Response("User not found", status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
@csrf_exempt
def verify_email(request):
    try:
        email = request.data.get('email')
        app_user = AppUser.objects.get(email=email)
        otp = send_otp(email)
        OTPAuthentication.objects.create(app_user=app_user, otp=otp)
        return Response("Email verified", status=status.HTTP_200_OK)
    except AppUser.DoesNotExist:
        return Response("Email is not registered. Please try again", status=status.HTTP_404_NOT_FOUND)

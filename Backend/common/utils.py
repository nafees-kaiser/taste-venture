import random
from django.core.mail import send_mail
from django.conf import settings
from .models import AppUser


def generate_otp(upper: int, lower: int):
    return random.randint(upper, lower)


def send_otp(email):
    otp = generate_otp(100000, 999999)
    send_mail(
        'Email Verification OTP',
        f'Your OTP for email verification is: {otp}',
        settings.EMAIL_HOST_USER,
        [email],
        fail_silently=False,
    )
    return otp


def add_user(data, user_type):
    user = {
        'name': data.pop('name'),
        'email': data.pop('email'),
        'password': data.pop('password'),
        'address': data.pop('address'),
        'contact': data.pop('contact'),
        'user_type': user_type
    }
    data['user'] = user
    return data


def represent_user(data):
    return {
        "name": data.name,
        "email": data.email,
        "address": data.address,
        "contact": data.contact,
        "user_type": data.user_type,
    }


def create_common_user(user):
    app_user = AppUser.objects.create(**user)
    app_user.set_password(user['password'])
    app_user.save()
    return app_user

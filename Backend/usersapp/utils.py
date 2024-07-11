import random
from django.core.mail import send_mail
from django.conf import settings

def generate_otp(upper:int, lower:int):
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
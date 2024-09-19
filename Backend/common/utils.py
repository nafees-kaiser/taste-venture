import random
from django.core.mail import send_mail
from django.conf import settings
from django.http import QueryDict
from collections import defaultdict

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


def convert_query_dict_to_dict(query_dict):
    # return query_dict.dict()
    # data = dict(data)
    data = {}
    menu_items = defaultdict(dict)
    for key, value in query_dict.items():
        if key.startswith('menu'):
            # Extract the index and the actual key (e.g., menu[0][name] -> index 0, key 'name')
            menu_index = key.split('[')[1].split(']')[0]
            menu_key = key.split('[')[2].split(']')[0]

            # Add menu item to the defaultdict
            menu_items[int(menu_index)][menu_key] = value
        else:
            # Add normal fields to the main data dictionary
            data[key] = value

    # Convert defaultdict to a list of dictionaries
    data['menu_item'] = [menu_items[i] for i in sorted(menu_items)]

    return data

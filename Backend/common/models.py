from django.contrib.auth.models import AbstractUser
from django.db import models


class AppUser(AbstractUser):
    USER_TYPE_CHOICES = (
        ('customer', 'Customer'),
        ('res_manager', 'Restaurant Manager'),
        ('tour_manager', 'Tour Spot Manager'),
    )

    name = models.CharField(max_length=200)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=500)
    address = models.CharField(max_length=500)
    contact = models.CharField(max_length=500)
    user_type = models.CharField(choices=USER_TYPE_CHOICES, max_length=200)
    username = models.CharField(max_length=200, default=None, null=True, blank=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    def __str__(self):
        return f'{self.name}, {self.email}'

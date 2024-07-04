from django.db import models
from django.db import models


class Users(models.Model):
    full_name = models.CharField(max_length=200)
    contact = models.CharField(max_length=200, unique=True)
    email = models.EmailField(unique=True)
    dob = models.CharField(max_length=200)
    address = models.CharField(max_length=200)
    gender = models.CharField(max_length=50)
    married = models.CharField(max_length=50)
    password = models.CharField(max_length=50)

    def __str__(self):
        return self.full_name

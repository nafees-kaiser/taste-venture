from django.db import models
# from Backend import settings
from django.conf import settings


class Users(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    dob = models.CharField(max_length=200)
    gender = models.CharField(max_length=50)
    married = models.CharField(max_length=50)

    REQUIRED_FIELDS = []

    def __str__(self):
        return f'{self.dob}, {self.gender}, {self.married}, {self.user}'


class OTPAuthentication(models.Model):
    user = models.ForeignKey(Users, on_delete=models.CASCADE)
    otp = models.CharField(max_length=200)
    created_at = models.DateTimeField(auto_now_add=True)

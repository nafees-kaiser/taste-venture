from django.db import models
from django.conf import settings
from usersapp.models import Users


# Create your models here.
class Tourspot(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, null=True, blank=True)

    tourspot_name = models.CharField(max_length=200, null=True, blank=True)
    opening_time = models.CharField(max_length=70)
    closing_time = models.CharField(max_length=70)
    description = models.TextField()
    entry_fee = models.CharField(max_length=50)
    wifi = models.CharField(max_length=50)
    parking = models.CharField(max_length=50)
    food = models.CharField(max_length=50)
    pool = models.CharField(max_length=50)
    other_services = models.TextField()

    REQUIRED_FIELDS = []

    def __str__(self):
        return f'{self.id} -> {self.tourspot_name}'


class Booking(models.Model):
    user = models.ForeignKey(Users, on_delete=models.CASCADE, default=None)
    date = models.DateField()
    number_of_people = models.IntegerField()
    subtotal = models.IntegerField()
    message = models.TextField()
    tourspot = models.ForeignKey(Tourspot, on_delete=models.CASCADE, default=None)
    status = models.TextField(default="pending")

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['user', 'tourspot', 'date'], name='unique_tourspot_booking')
        ]


class Review(models.Model):
    user = models.ForeignKey(Users, on_delete=models.CASCADE, related_name='dayTour_user')
    rating = models.IntegerField()
    review = models.TextField()
    date = models.DateTimeField(auto_now_add=True)
    tourSpot = models.ForeignKey(Tourspot, related_name='dayTour_reviews', on_delete=models.CASCADE)

    def __str__(self):
        return f'{self.user.id} -> {self.review}'

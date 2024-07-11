from django.db import models

# Create your models here.
class Tourspot(models.Model):
    name = models.CharField(max_length=200)
    manager_name = models.CharField(max_length=200)
    contact = models.CharField(max_length=200, unique=True)
    email = models.EmailField(unique=True)
    opening_time = models.CharField(max_length=70)
    closing_time = models.CharField(max_length=70)
    description = models.TextField()
    address = models.CharField(max_length=200)
    password = models.CharField(max_length=200)
    entry_fee = models.CharField(max_length=50)
    wifi = models.CharField(max_length=50)
    parking = models.CharField(max_length=50)
    food = models.CharField(max_length=50)
    pool = models.CharField(max_length=50)
    other_services = models.TextField()



    def __str__(self):
        return self.name
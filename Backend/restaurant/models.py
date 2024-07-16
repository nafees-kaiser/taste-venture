from django.db import models
from usersapp.models import Users

from usersapp.models import Users


# Create your models here.

class Restaurant(models.Model):
    name = models.CharField(max_length=70)
    email = models.EmailField(max_length=70)
    password = models.CharField(max_length=200)
    address = models.CharField(max_length=70)
    phone = models.CharField(max_length=20)
    cuisine = models.CharField(max_length=70)
    food_type = models.CharField(max_length=70)
    opening_time = models.CharField(max_length=70)
    closing_time = models.CharField(max_length=70)
    description = models.TextField()
    # menuList = models.ForeignKey(MenuItem)
    
    def __str__(self):
        return f'{self.id} -> {self.name}'
    

class MenuItem(models.Model):
    name = models.CharField(max_length=200)
    cuisine = models.CharField(max_length=200)
    food_type = models.CharField(max_length=200)
    ingredients = models.CharField(max_length=200)
    description = models.TextField()
    category = models.CharField(max_length=80)
    size = models.CharField(max_length=20)
    price = models.CharField(max_length=10)
    # image = models.ImageField(upload_to='images/')
    restaurant = models.ForeignKey('Restaurant' , on_delete=models.CASCADE, default=None, null=True, blank=True, related_name='menu_item')

    def __str__(self):
        return f'{self.id} -> {self.name}'




class Cuisine(models.Model):
    French = 'FN', 'French'
    Italian = 'IT', 'Italian'
    Mexican = 'MX', 'Mexican'
    American = 'AM', 'American'
    Asian = 'AS', 'Asian'
    Chinese = 'CH', 'Chinese'
    Indian = 'IN', 'Indian'
    Japanese = 'JP', 'Japanese'
    Korean = 'KR', 'Korean'
    Thai = 'TH', 'Thai'
    Western = 'WS', 'Western'
    Vietnamese = 'VT', 'Vietnamese'
    

class FoodType(models.Model):
    Dessert = 'DS', 'Dessert'
    Appetizer = 'AP', 'Appetizer'
    MainCourse = 'MC', 'Main Course'
    Salad = 'SL', 'Salad'
    Soup = 'SP', 'Soup'
    Beverage = 'BV', 'Beverage'
    Drink = 'DR', 'Drink'
    Dessert = 'DS', 'Dessert'
    Healthy = 'HL', 'Healthy'
    Sweet = 'SW', 'Sweet'
    Spicy = 'SP', 'Spicy'
    Savory = 'SV', 'Savory'
    Sour = 'SR', 'Sour'
    FastFood = 'FF', 'Fast Food'

    
    
class Reservation(models.Model):
    user = models.ForeignKey(Users, on_delete=models.CASCADE)
    date = models.DateField()
    start_time = models.TimeField()
    end_time = models.TimeField()
    reservation_type = models.BooleanField() # True = Full-restaurant, False = Custom
    number_of_people = models.IntegerField() # if reservation_type = False, then this field is required
    message = models.TextField()
    restaurant = models.ForeignKey('Restaurant', on_delete=models.CASCADE, default=None, blank=True)


class Review(models.Model):
    user = models.ForeignKey(Users, on_delete=models.CASCADE)
    rating = models.IntegerField()
    review = models.TextField()
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.user.id} -> {self.review}'
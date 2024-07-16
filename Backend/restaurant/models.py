from django.db import models

# Create your models here.


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
    menu = models.ForeignKey('Menu', on_delete=models.CASCADE, default=None, null=True, blank=True)

    def __str__(self):
        return f'{self.id} -> {self.name}'


class Menu(models.Model):
    name = models.CharField(max_length=200)
    restaurant_name = models.OneToOneField('Restaurant', on_delete=models.CASCADE, default=None, null=True, blank=True)

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


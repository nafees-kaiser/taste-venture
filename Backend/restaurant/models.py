from django.db import models

# Create your models here.


class MenuItem(models.Model):
    name = models.CharField(max_length=200)
    cuisine = models.CharField(max_length=200)
    food_type = models.CharField(max_length=200)
    ingredients = models.CharField(max_length=200)
    description = models.TextField(max_length=1000)
    category = models.CharField(max_length=80)
    size = models.CharField(max_length=20)
    price = models.CharField(max_length=10)
    # image = models.ImageField(upload_to='images/')
    # menu = models.ForeignKey('Menu', on_delete=models.CASCADE)

    def __str__(self):
        return f'{self.id} -> {self.name}'


# class Menu(models.Model):
#     name = models.CharField(max_length=200)



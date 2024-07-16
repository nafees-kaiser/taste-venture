from rest_framework import serializers
from .models import MenuItem
from .models import Restaurant


class MenuItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuItem
        fields = '__all__'

        
        
class RestaurantSerializer(serializers.ModelSerializer):
    menu_item = MenuItemSerializer(many=True)
    class Meta:
        model = Restaurant
        fields = '__all__'
        
    def create(self, validated_data):
        menu_item_list = validated_data.pop('menu_item')
        restaurant = Restaurant.objects.create(**validated_data)
        for menu_item in menu_item_list:
            MenuItem.objects.create(restaurant=restaurant, **menu_item)
            return restaurant
        
        #return MenuItem.objects.create(**validated_data)

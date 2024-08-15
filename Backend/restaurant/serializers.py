from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination

from usersapp.serializers import UserSerializer
from .models import MenuItem, Review
from .models import Restaurant
from .models import Reservation
from usersapp.models import Favorite



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

class ShowRestaurantSerializer(serializers.ModelSerializer):
    #is_favorite = serializers.SerializerMethodField()
    
    class Meta:
        model = Restaurant
        fields = [
            'id',
            'name',
            'email',
            'address',
            'phone',
            'cuisine',
            'food_type',
            'opening_time',
            'closing_time',
            'description',
            'rating',
            #'is_favorite'
            ]
        #exclude = ['password', 'menu_item']
    
    # def get_is_favorite(self, obj):
    #     user = self.context['request'].user
    #     return Favorite.objects.filter(user=user, restaurant=obj).exists()
    


class ReviewSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = Review
        fields = '__all__'


class ReservationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reservation
        fields = '__all__'


class RestaurantAndAvgRating(serializers.ModelSerializer):
    average_rating = serializers.SerializerMethodField()

    class Meta:
        model = Restaurant
        fields = ['id', 'name', 'address', 'average_rating']

    def get_average_rating(self, obj):
        return format(obj.average_rating, '.2f')


class StandardResultsSetPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 10000
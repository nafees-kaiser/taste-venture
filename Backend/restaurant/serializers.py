from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from common.serializers import AppUserSerializer
from common.utils import add_user, represent_user, create_common_user
from usersapp.serializers import UserSerializer

from .models import *

from usersapp.models import Favorite



class MenuItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuItem
        fields = '__all__'


class RestaurantSerializer(serializers.ModelSerializer):
    menu_item = MenuItemSerializer(many=True)
    user = AppUserSerializer()

    class Meta:
        model = Restaurant
        fields = '__all__'
        extra_kwargs = {'rating': {'read_only': True}}

    def to_internal_value(self, data):
        new_data = add_user(data, 'res_manager')
        return super().to_internal_value(new_data)

    def create(self, validated_data):
        user = validated_data.pop('user')
        app_user = create_common_user(user)
        menu_item_list = validated_data.pop('menu_item')
        restaurant = Restaurant.objects.create(user=app_user, **validated_data)
        for menu_item in menu_item_list:
            MenuItem.objects.create(restaurant=restaurant, **menu_item)
        return restaurant

        # return MenuItem.objects.create(**validated_data)

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        user_representation = represent_user(instance.user)
        representation.update(user_representation)
        representation.pop('user')
        return representation


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

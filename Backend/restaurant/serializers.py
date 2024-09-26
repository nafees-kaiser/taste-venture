from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination

from common.models import AppUser
from common.serializers import AppUserSerializer
from common.utils import *
from usersapp.serializers import UserSerializer

from .models import *

from usersapp.models import Favorite


class MenuItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuItem
        fields = '__all__'

    def to_internal_value(self, data):
        if 'email' in data:
            email = data.pop('email')
            email = email[0]
            res_manager = AppUser.objects.get(email=email)
            rest = Restaurant.objects.get(user=res_manager)
            data['restaurant'] = rest.id
        return super().to_internal_value(data)


class RestaurantSerializer(serializers.ModelSerializer):
    menu_item = MenuItemSerializer(many=True)
    user = AppUserSerializer()
    # favorite = serializers.SerializerMethodField()

    class Meta:
        model = Restaurant
        fields = '__all__'
        extra_kwargs = {'rating': {'read_only': True}}

    # def get_favorite(self, obj):
    #     id = self.context.get('user_id')
    #     user = Users.objects.get(user_id=id)
    #     return Favorite.objects.filter(user=user, restaurant=obj).exists()

    def to_internal_value(self, data):
        if isinstance(data, QueryDict):
            data = convert_query_dict_to_dict(data)
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
    menu_item = MenuItemSerializer(many=True)
    user = AppUserSerializer()
    favorite = serializers.SerializerMethodField()
    
    class Meta:
        model = Restaurant
        fields = '__all__'
        extra_kwargs = {'rating': {'read_only': True}}

    def get_favorite(self, obj):
        id = self.context.get('user_id')
        user = Users.objects.get(user_id=id)
        return Favorite.objects.filter(user=user, restaurant=obj).exists()

    def to_internal_value(self, data):
        if isinstance(data, QueryDict):
            data = convert_query_dict_to_dict(data)
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


class ReviewSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = Review
        fields = '__all__'


class ReservationSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True, allow_null=True)
    restaurant = RestaurantSerializer(read_only=True, allow_null=True)

    class Meta:
        model = Reservation
        fields = '__all__'


class RestaurantAndAvgRating(serializers.ModelSerializer):
    average_rating = serializers.SerializerMethodField()
    address = serializers.SerializerMethodField()

    class Meta:
        model = Restaurant
        fields = ['id', 'restaurant_name', 'address', 'average_rating', 'image']

    def get_average_rating(self, obj):
        average_rating = obj.average_rating if obj.average_rating is not None else 0.00
        return format(average_rating, '.2f')

    def get_address(self, obj):
        return obj.user.address if obj.user and hasattr(obj.user, 'address') else None


class StandardResultsSetPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 10000

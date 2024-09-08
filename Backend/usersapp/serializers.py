from rest_framework import serializers

from common.serializers import AppUserSerializer
from .models import *
from common.models import AppUser


class UserSerializer(serializers.ModelSerializer):
    user = AppUserSerializer()

    class Meta:
        model = Users
        fields = '__all__'

    def create(self, validated_data):
        user = validated_data.pop('user')
        app_user = AppUser.objects.create(**user)
        app_user.set_password(user['password'])
        app_user.save()
        customer = Users.objects.create(user=app_user, **validated_data)
        return customer

    def to_internal_value(self, data):
        user = {
            'name': data.pop('name'),
            'email': data.pop('email'),
            'password': data.pop('password'),
            'address': data.pop('address'),
            'contact': data.pop('contact'),
            'user_type': 'customer'
        }
        data['user'] = user
        return super().to_internal_value(data)

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        user_representation = {
            "name": instance.user.name,
            "email": instance.user.email,
            "address": instance.user.address,
            "contact": instance.user.contact,
            "user_type": instance.user.user_type,
        }

        representation.update(user_representation)
        representation.pop('user')
        return representation
    
    
class FavoriteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Favorite
        fields = '__all__'

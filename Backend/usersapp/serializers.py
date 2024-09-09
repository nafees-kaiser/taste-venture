from rest_framework import serializers

from common.serializers import AppUserSerializer
from .models import *
from common.models import AppUser
from common.utils import *


class UserSerializer(serializers.ModelSerializer):
    user = AppUserSerializer()

    class Meta:
        model = Users
        fields = '__all__'

    def create(self, validated_data):
        user = validated_data.pop('user')
        app_user = create_common_user(user)
        customer = Users.objects.create(user=app_user, **validated_data)
        return customer

    def to_internal_value(self, data):
        new_data = add_user(data, 'customer')
        return super().to_internal_value(new_data)

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        user_representation = represent_user(instance.user)
        representation.update(user_representation)
        representation.pop('user')
        return representation
    
    
class FavoriteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Favorite
        fields = '__all__'

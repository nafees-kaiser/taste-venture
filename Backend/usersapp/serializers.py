from rest_framework import serializers

from common.serializers import AppUserSerializer
from .models import *
from common.models import AppUser


class UserSerializer(serializers.ModelSerializer):
    # name = serializers.CharField()
    # email = serializers.EmailField()
    # password = serializers.CharField(write_only=True)
    # address = serializers.CharField()
    # contact = serializers.CharField()
    class Meta:
        model = Users
        fields = '__all__'
        # read_only_fields = ('id',)
        # extra_kwargs = {'user': {'read_only': True}}

    # def create(self, validated_data):
    # #     # print(validated_data)
    # #     name = validated_data.pop('name')
    # #     email = validated_data.pop('email')
    # #     password = validated_data.pop('password')
    # #     address = validated_data.pop('address')
    # #     contact = validated_data.pop('contact')
    #     user = validated_data.pop('user')
    # #     app_user = AppUser.objects.create(**user)
    # #     app_user.set_password(user['password'])
    # #     app_user.save()
    # #     customer = Users.objects.create(user=app_user, **validated_data)
    # #     user = AppUser.objects.create(name=name, email=email, password=password, contact=contact, address=address, user_type='customer')
    # #     user.set_password(password)
    # #     user.save()
    #     customer = Users.objects.create(user=user, **validated_data)
    #     return customer
    #
    # def to_internal_value(self, data):
    #     # print(data)
    #     # name = data.pop('name')
    #     # email = data.pop('email')
    #     # password = data.pop('password')
    #     user = {
    #         'name': data.pop('name'),
    #         'email': data.pop('email'),
    #         'password': data.pop('password'),
    #         'address': data.pop('address'),
    #         'contact': data.pop('contact'),
    #     }
    #     app_user = AppUser.objects.create( user_type='customer', **user)
    #     app_user.set_password(user['password'])
    #     app_user.save()
    #     data['user'] = app_user
    #     return super().to_internal_value(data)

    # def to_representation(self, instance):
    #     representation = super().to_representation(instance)
    #     user_representation = {
    #         "name": instance.user.name,
    #         "email": instance.user.email,
    #         "address": instance.user.address,
    #         "contact": instance.user.contact,
    #         "user_type": instance.user.user_type,
    #     }
    #
    #     representation.update(user_representation)
    #     # user_representation = representation.pop('user')
    #     return representation


class OTPSerializer(serializers.Serializer):
    email = serializers.EmailField()
    otp = serializers.CharField()

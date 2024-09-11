from rest_framework import serializers

from common.models import AppUser


class AppUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppUser
        fields = '__all__'
        extra_kwargs = {'password': {'write_only': True}}


class OTPSerializer(serializers.Serializer):
    email = serializers.EmailField()
    otp = serializers.CharField()

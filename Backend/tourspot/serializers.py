from rest_framework import serializers

from common.serializers import AppUserSerializer
from common.utils import *
from .models import Tourspot, Booking, Review


class TourspotSerializer(serializers.ModelSerializer):
    user = AppUserSerializer()

    class Meta:
        model = Tourspot
        fields = '__all__'

    def to_internal_value(self, data):
        new_data = add_user(data, 'tour_manager')
        return super().to_internal_value(new_data)

    def create(self, validated_data):
        user = validated_data.pop('user')
        app_user = create_common_user(user)
        tour_spot = Tourspot.objects.create(user=app_user, **validated_data)
        return tour_spot

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        user_representation = represent_user(instance.user)
        representation.update(user_representation)
        representation.pop('user')
        return representation


class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = '__all__'


class TourSpotReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = '__all__'

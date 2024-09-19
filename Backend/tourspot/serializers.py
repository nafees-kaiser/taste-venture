from rest_framework import serializers

from common.serializers import AppUserSerializer
from common.utils import *
from usersapp.serializers import UserSerializer
from .models import Tourspot, Booking, Review


class TourspotSerializer(serializers.ModelSerializer):
    user = AppUserSerializer()

    class Meta:
        model = Tourspot
        fields = '__all__'

    def to_internal_value(self, data):
        if isinstance(data, QueryDict):
            data = data.dict()
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
    user = UserSerializer(read_only=True, allow_null=True)
    tourspot = TourspotSerializer(read_only=True, allow_null=True)
    class Meta:
        model = Booking
        fields = '__all__'


class TourSpotReviewSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = Review
        fields = '__all__'


class DayTourSpotAndAvgRating(serializers.ModelSerializer):
    average_rating = serializers.SerializerMethodField()
    address = serializers.SerializerMethodField()

    class Meta:
        model = Tourspot
        fields = ['id', 'tourspot_name', 'address', 'average_rating', 'image']

    def get_average_rating(self, obj):
        average_rating = obj.average_rating if obj.average_rating is not None else 0.00
        return format(average_rating, '.2f')

    def get_address(self, obj):
        return obj.user.address if obj.user and hasattr(obj.user, 'address') else None

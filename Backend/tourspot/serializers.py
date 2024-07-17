from rest_framework import serializers
from .models import Tourspot, Booking


class TourspotSerializer(serializers.ModelSerializer):

    class Meta:
        model = Tourspot
        fields = '__all__'


class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = '__all__'
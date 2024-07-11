from rest_framework import serializers
from .models import Tourspot


class TourspotSerializer(serializers.ModelSerializer):

    class Meta:
        model = Tourspot
        fields = '__all__'

from django.contrib.auth.hashers import make_password
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from tourspot.models import Tourspot
from tourspot.serializers import  TourspotSerializer

# Create your views here.
@api_view(['POST'])
@csrf_exempt
def add_manager(request):
    serializer = TourspotSerializer(data=request.data)
    if serializer.is_valid():
        password = serializer.validated_data.get('password')
        hashed_password = make_password(password)

        serializer.save(password=hashed_password)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
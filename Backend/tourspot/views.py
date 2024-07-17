from django.contrib.auth.hashers import make_password
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.http import JsonResponse

from tourspot.models import Tourspot
from tourspot.serializers import TourspotSerializer, BookingSerializer


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

@api_view(['GET'])
def view_tourspot_list(request):
    tourspots = Tourspot.objects.all()
    tourspot_list = list(tourspots.values())
    return Response(tourspot_list, status=status.HTTP_200_OK)

@api_view(['GET'])
def view_tourspot_detail(request, id):
    try:
        tourspot = Tourspot.objects.get(pk=id)
        tourspot_data = {
            'id': tourspot.id,
            'name': tourspot.name,
            'manager_name': tourspot.manager_name,
            'contact': tourspot.contact,
            'email': tourspot.email,
            'opening_time': tourspot.opening_time,
            'closing_time': tourspot.closing_time,
            'description': tourspot.description,
            'address': tourspot.address,
            'password': tourspot.password,
            'entry_fee': tourspot.entry_fee,
            'wifi': tourspot.wifi,
            'parking': tourspot.parking,
            'food': tourspot.food,
            'pool': tourspot.pool,
            'other_services': tourspot.other_services,
        }
        return Response(tourspot_data, status=status.HTTP_200_OK)
    except Tourspot.DoesNotExist:
        return Response({'error': 'Tourspot not found'}, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
@csrf_exempt
def add_booking(request):
    serializer = BookingSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .models import MenuItem
from .serializers import MenuItemSerializer
from .serializers import RestaurantSerializer


# Create your views here.
@api_view(['POST'])
@csrf_exempt
def add_menu(request):
    serializer = MenuItemSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@csrf_exempt
def edit_menu(request):
    # print(request.data)
    update_request_fields = request.data
    try:
        menu_item = MenuItem.objects.get(pk=update_request_fields['id'])
    except MenuItem.DoesNotExist:
        return Response("Menu item does not exist", status=status.HTTP_404_NOT_FOUND)

    for key, value in update_request_fields.items():
        setattr(menu_item, key, value)
        # menu_item
    menu_item.save()
    return Response("Updated successfully", status=status.HTTP_200_OK)


@api_view(['POST'])
@csrf_exempt
def add_restaurant(request):
    serializer = RestaurantSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


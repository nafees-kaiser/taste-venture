from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.http import JsonResponse

from usersapp.models import Users
from usersapp.serializers import UserSerializer

@api_view(['GET', 'POST'])
# Create your views here.
def users_list(request):
    if request.method == 'GET':
        users = Users.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        print(request.data)
        serializer = UserSerializer(data=request.data)
        print(serializer.is_valid())
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        print(serializer.errors)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["GET"])   # http://localhost:8000/users/profile/rahman@gmail.com/
def get_user_details(request, email):
    if request.method == 'GET':
        users = Users.objects.get(email=email)
        data = {
            "name": users.full_name,
            "email": users.email,
            "contact": users.contact,
            "address": users.address,
            "dob": users.dob,
            "gender": users.gender,
            "married": users.married,

        }
        return JsonResponse({"user": data})

    
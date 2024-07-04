from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

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
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    
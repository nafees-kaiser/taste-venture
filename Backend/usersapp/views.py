from django.contrib.auth.hashers import check_password, make_password
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from usersapp.models import Users
from usersapp.serializers import UserSerializer
from rest_framework_simplejwt.tokens import RefreshToken


@api_view(['POST'])
@csrf_exempt
def users_list(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        password = serializer.validated_data.get('password')
        hashed_password = make_password(password)

        serializer.save(password=hashed_password)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def login(request):
    data = request.data
    email = data.get('email')
    password = data.get('password')
    print(password)


    try:
        user = Users.objects.get(email=email)
        print(type(user))
        if user is not None and check_password(password, user.password):
            serializer = UserSerializer(user)

            refresh = RefreshToken.for_user(user)
            token = {
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            }

            response_data = {
                'user': serializer.data,
                'tokens': token,
            }
            return Response(response_data, status=status.HTTP_200_OK)
        else:
            return Response({"detail": "Invalid credentials"}, status=status.HTTP_400_BAD_REQUEST)
    except Users.DoesNotExist:
        return Response({"detail": "User not found"}, status=status.HTTP_404_NOT_FOUND)

from django.shortcuts import render
from rest_framework import generics, status, views, viewsets, permissions
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from rest_framework_simplejwt.tokens import RefreshToken
from .serializers import UserRegistrationSerializer, UserSerializer,\
    UserProfileUpdateSerializer, LocationSerializer, LocationReviewSerializer #, ActivityReviewSerializer
from .models import User, Location, LocationReview #, ActivityReview

class UserRegistrationView(generics.CreateAPIView):
    queryset = User.objects.all()
    permission_classes = (AllowAny,)
    serializer_class = UserRegistrationSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        return Response(
            {"message": "User registered successfully. Please log in.", "user": UserSerializer(user).data},
            status=status.HTTP_201_CREATED
        )


class CustomTokenObtainPairView(TokenObtainPairView):
    def post(self, request, *args, **kwargs):
        response = super().post(request, *args, **kwargs)
        if response.status_code == 200:
            user = User.objects.get(username=request.data['username'])
            response.data['user'] = UserSerializer(user).data
        return response

class LogoutView(views.APIView):
    permission_classes = (IsAuthenticated,)

    def post(self, request):
        try:
            refresh_token = request.data["refresh"]
            token = RefreshToken(refresh_token)
            token.blacklist()
            return Response({"message": "Successfully logged out."}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({"error": "Logout failed.", "details": str(e)}, status=status.HTTP_400_BAD_REQUEST)

class UserProfileView(generics.RetrieveUpdateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = (IsAuthenticated,)

    def get_object(self):
        return self.request.user

    def get_serializer_class(self):
        if self.request.method == 'PUT' or self.request.method == 'PATCH':
            return UserProfileUpdateSerializer
        return UserSerializer


class LocationViewSet(viewsets.ModelViewSet): # viewset implementa o CRUD automaticamente
    queryset = Location.objects.all()  # Define o conjunto de dados base
    serializer_class = LocationSerializer # Especifica o serializer que esta view usará
    permission_classes = [permissions.IsAuthenticatedOrReadOnly] # Exemplo de permissão
    # IsAuthenticatedOrReadOnly: Qualquer um pode ler, mas apenas usuários autenticados podem escrever.

class LocationReviewViewSet(viewsets.ModelViewSet):
    queryset = LocationReview.objects.all()
    serializer_class = LocationReviewSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    #salva automaticamente o usuário logado como o autor na review
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

# descomentar qnd model Activity for implementado
# class ActivityReviewViewSet(viewsets.ModelViewSet):
#     queryset = ActivityReview.objects.all()
#     serializer_class = ActivityReviewSerializer
#     permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    # # salva automaticamente o usuário logado como o autor na review
    # def perform_create(self, serializer):
    #     serializer.save(user=self.request.user)
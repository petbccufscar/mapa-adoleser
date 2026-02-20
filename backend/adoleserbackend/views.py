from django.shortcuts import render
from rest_framework import generics, status, views, viewsets, permissions
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.generics import GenericAPIView



from .serializers import UserRegistrationSerializer, UserSerializer, UserProfileUpdateSerializer, CategorySerializer, InstanceSerializer, ActivitySerializer, InstanceReviewSerializer, ChangePasswordSerializer,PasswordResetRequestSerializer, PasswordResetSerializer, ActivityReviewSerializer


from .models import User, Instance,  InstanceReview, Category, Activity, ActivityReview
from .utils import set_password_reset_code, send_password_reset_email, is_reset_code_valid, clear_reset_code


from .permissions import IsAdminOrSuperOrReadOnly, IsOwnerOrSuperOrReadOnly
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

class UserProfileView(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = (IsAuthenticated,)

    def get_object(self):
        return self.request.user

    def get_serializer_class(self):
        if self.request.method == 'PUT' or self.request.method == 'PATCH':
            return UserProfileUpdateSerializer
        return UserSerializer


class InstanceViewSet(viewsets.ModelViewSet): # viewset implementa o CRUD automaticamente
    queryset = Instance.objects.all()  # Define o conjunto de dados base
    serializer_class = InstanceSerializer # Especifica o serializer que esta view usará
    permission_classes = [IsAdminOrSuperOrReadOnly, IsOwnerOrSuperOrReadOnly] # Exemplo de permissão

    def perform_create(self, serializer):
        serializer.save(created_by=self.request.user)

class ActivityViewSet(viewsets.ModelViewSet):
    queryset = Activity.objects.all()
    serializer_class = ActivitySerializer
    permission_classes = [IsAdminOrSuperOrReadOnly, IsOwnerOrSuperOrReadOnly]


    def perform_create(self, serializer):
        serializer.save(created_by=self.request.user)  # Define o usuário logado como autor da atividade



class ChangePasswordView(generics.UpdateAPIView):
    serializer_class = ChangePasswordSerializer
    model = User
    permission_classes = (permissions.IsAuthenticated, )

    def get_object(self):
        return self.request.user

    def update(self, request, *args, **kwargs):
        self.object = self.get_object()
        serializer = self.get_serializer( instance=self.object, data=request.data, context={'request': request})

        if serializer.is_valid():
            self.perform_update(serializer)
            return Response({"detail": "Senha atualizada com sucesso."}, status=status.HTTP_200_OK)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class PasswordResetRequestView(GenericAPIView):
    permission_classes = [AllowAny]
    serializer_class = PasswordResetRequestSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(
            {"message": "Se o email existir, você receberá um código de recuperação."},
            status=status.HTTP_200_OK
        )


class PasswordResetConfirmView(GenericAPIView):
    permission_classes = [AllowAny]
    serializer_class = PasswordResetSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(
            {"message": "Senha redefinida com sucesso."},
            status=status.HTTP_200_OK
        )

class InstanceReviewViewSet(viewsets.ModelViewSet):
    queryset = InstanceReview.objects.all()
    serializer_class = InstanceReviewSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly, IsOwnerOrSuperOrReadOnly]

    #salva automaticamente o usuário logado como o autor na review
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

# descomentar qnd model Activity for implementado
class ActivityReviewViewSet(viewsets.ModelViewSet):
    queryset = ActivityReview.objects.all()
    serializer_class = ActivityReviewSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly, IsOwnerOrSuperOrReadOnly]

    # # salva automaticamente o usuário logado como o autor na review
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class CategoryListView(generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

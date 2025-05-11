from django.urls import path
from .views import (
    UserRegistrationView,
    LogoutView,
    UserProfileView,
    CustomTokenObtainPairView
)
from rest_framework_simplejwt.views import (
    TokenRefreshView,
)

urlpatterns = [
    path('register/', UserRegistrationView.as_view(), name='user_register'),
    path('login/', CustomTokenObtainPairView.as_view(), name='token_obtain_pair'), # Login
    path('login/refresh/', TokenRefreshView.as_view(), name='token_refresh'),    # Refresh token
    path('logout/', LogoutView.as_view(), name='user_logout'),
    path('profile/', UserProfileView.as_view(), name='user_profile'),
]
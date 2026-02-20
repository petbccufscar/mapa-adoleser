from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    UserRegistrationView,
    LogoutView,
    UserProfileView,
    CustomTokenObtainPairView,
    InstanceViewSet,
    ChangePasswordView,
    PasswordResetRequestView,
    PasswordResetConfirmView,
    ActivityViewSet,
    InstanceReviewViewSet,
    ActivityReviewViewSet,
    CategoryListView
)
from rest_framework_simplejwt.views import (
    TokenRefreshView,
)

router = DefaultRouter()  # chama os cruds para url de locations
router.register(r'instances', InstanceViewSet, basename='instance')
router.register(r'instance-reviews',InstanceReviewViewSet, basename='instancereview')
router.register(r'activity-reviews',ActivityReviewViewSet, basename='activityreview')
router.register(r'activities', ActivityViewSet, basename='activity')

urlpatterns = [
    path('register/', UserRegistrationView.as_view(), name='user_register'),
    path('login/', CustomTokenObtainPairView.as_view(), name='token_obtain_pair'), # Login
    path('login/refresh/', TokenRefreshView.as_view(), name='token_refresh'),    # Refresh token
    path('logout/', LogoutView.as_view(), name='user_logout'),
    path('profile/', UserProfileView.as_view(), name='user_profile'),
    path('categories/', CategoryListView.as_view(), name='category-list'),
    path('password-change/', ChangePasswordView.as_view(), name='password_change'),

    
    # Recuperação de senha
    path('password-reset/request/', PasswordResetRequestView.as_view(), name='password_reset_request'),
    path('password-reset/confirm/', PasswordResetConfirmView.as_view(), name='password_reset_confirm'),

    path('', include(router.urls)) # api/locations/ e api/locations-reviews/ e...
]
from rest_framework import serializers
from django.contrib.auth import get_user_model
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError as DjangoValidationError
from .models import User

UserModel = get_user_model()

class UserRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True, label="Confirm password")
    email = serializers.EmailField(required=True)
    name = serializers.CharField(required=True)

    class Meta:
        model = UserModel
        fields = ('username', 'email', 'password', 'password2', 'name', 'birth_date')
        extra_kwargs = {
            'birth_date': {'required': False}
        }

    def validate_email(self, value):
        if UserModel.objects.filter(email__iexact=value).exists():
            raise serializers.ValidationError("A user with that email already exists.")
        return value

    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Password fields didn't match."})
        return attrs

    def create(self, validated_data):
        user = UserModel.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            name=validated_data['name'],
            birth_date=validated_data.get('birth_date')
        )
        user.set_password(validated_data['password'])
        user.save()
        return user

class UserSerializer(serializers.ModelSerializer):
    """
    Serializer for displaying user information (read-only for most fields)
    """
    role = serializers.CharField(source='get_role_display', read_only=True)

    class Meta:
        model = UserModel
        fields = ('id', 'username', 'email', 'name', 'birth_date', 'role', 'date_joined', 'last_login')
        read_only_fields = ('id', 'role', 'date_joined', 'last_login')

class UserProfileUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserModel
        fields = ('email', 'name', 'birth_date')
        extra_kwargs = {
            'email': {'required': False},
            'name': {'required': False},
            'birth_date': {'required': False},
        }

    def validate_email(self, value):
        user = self.context['request'].user
        if UserModel.objects.filter(email__iexact=value).exclude(pk=user.pk).exists():
            raise serializers.ValidationError("This email is already in use by another account.")
        return value
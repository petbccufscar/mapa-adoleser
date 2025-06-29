from rest_framework import serializers
from django.contrib.auth import get_user_model
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError as DjangoValidationError
from .models import User, Location, LocationReview #, ActivityReview
from .utils import (
    set_password_reset_code,
    send_password_reset_email,
    is_reset_code_valid,
    clear_reset_code
)

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


class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['id', 'name', 'description', 'nota']

    def validate_nota(self, value):
        if value < 0 or value > 10:
            raise serializers.ValidationError("The grade needs to be between 0 and 10.")
        return value

class PasswordResetRequestSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)

    def validate_email(self, value):
        if not UserModel.objects.filter(email__iexact=value).exists():
            raise serializers.ValidationError("Não existe nenhum usuário com este email.")
        return value

    def create(self, validated_data):
        email = validated_data['email']
        user = UserModel.objects.get(email__iexact=email)
        code = set_password_reset_code(user)
        send_password_reset_email(user, code)
        return user


class PasswordResetSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)
    reset_code = serializers.CharField(max_length=6, required=True)
    new_password = serializers.CharField(
        write_only=True,
        required=True,
        validators=[validate_password]
    )
    confirm_password = serializers.CharField(write_only=True, required=True)

    def validate_email(self, value):
        if not UserModel.objects.filter(email__iexact=value).exists():
            raise serializers.ValidationError("Não existe nenhum usuário com este email.")
        return value

    def validate(self, attrs):
        if attrs['new_password'] != attrs['confirm_password']:
            raise serializers.ValidationError({
                'confirm_password': "As senhas não coincidem."
            })
        return attrs

    def create(self, validated_data):
        user = UserModel.objects.get(email__iexact=validated_data['email'])
        if not is_reset_code_valid(user, validated_data['reset_code']):
            raise serializers.ValidationError({'reset_code': 'Código inválido ou expirado.'})
        user.set_password(validated_data['new_password'])
        clear_reset_code(user)
        user.save()
        return user
      
class LocationReviewSerializer(serializers.ModelSerializer):
    #campo user não é enviado por POST, é pego diretamente pelo back (pela funcao implementada na view)
    user = serializers.PrimaryKeyRelatedField(read_only=True)
    class Meta:
        model = LocationReview
        fields = ['id', 'name', 'description', 'nota', 'user', 'location']

    def validate_nota(self, value):
        if not 0 <= value <= 10:
            raise serializers.ValidationError("The grade needs to be between 0 and 10.")
        return value

# descomentar quando model activity for implementado
# class ActivityReviewSerializer(serializers.ModelSerializer):
# #campo user não é enviado por POST, é pego diretamente pelo back (pela funcao implementada na view)
   # user = serializers.PrimaryKeyRelatedField(read_only=True)
#     class Meta:
#         model = ActivityReview
#         fields = ['id', 'name', 'description', 'nota', 'user', 'activity']

    # def validate_nota(self, value):
    #     if not 0 <= value <= 10:
    #         raise serializers.ValidationError("The grade needs to be between 0 and 10.")
    #     return value


from unittest.mock import patch
from django.test import TestCase
from django.urls import reverse
from .models import User

# Create your tests here.

# AUTENTICAÇÃO USUARIO
class UserLoginTest(TestCase):
    # CRIA USUARIO NO BANCO DE TESTES
    def setUp(self):
        self.user = User.objects.create_user(
            username= "teste",
            email = "teste@gmail.com",
            password = "12345678A@"
        )

    # REQUISIÇÃO DO USUARIO
    def test_login_success(self):
        url = reverse("token_obtain_pair")
        response = self.client.post(url, {
            "username": "teste",
            "password": "12345678A@"
        })

        # VERIFICA STATUS E TOKENS
        self.assertEqual(response.status_code, 200) 
        self.assertIn("acess", response.data) 
        self.assertIn("refresh", response.data)
        self.assertIn("user", response.data)
    
    # VERIFICA SENHA ERRADA
    def test_wrong_password(self):
        url = reverse("token_obtain_pair")
        response = self.client.post(url, {
            "username": "teste",
            "password": "errada",
        })
        # BLOQUEIO DO LOGIN
        self.assertEqual(response.status_code, 401)
    
    # VERIFICA USUARIO INEXISTENTE
    def test_noexistent_user(self):
        url = reverse("token_obtain_pair")
        response = self.client.post(url, {
            "username": "usuario_inexistente",
            "password": "qualquer_senha"
        })

        self.assertEqual(response.status_code, 401)

# TELA CADASTRO E PERFIL
class UserAccountTest(TestCase):
    # CRIA USUARIO
    def test_registration_sucess(self):
        self.assertEqual(User.objects.count(), 0)

        url = reverse("user-register")
        data = {
            "username": "teste",
            "email": "teste@gmail.com",
            "password": "12345678A@",
            "password2": "12345678A@",
            "nome": "test",
            "data_aniversario": "2000-02-02"
        }

        response = self.client.post(url, data, format='json')

        self.assertEqual(response.status_code, 201)
        self.assertEqual(User.objects.count(), 1)
        # VERIFICA DADOS 
        user = User.objects.get(username="teste")
        self.assertEqual(user.email, "teste@gmail.com")
        
    # ERRO CASO SENHAS NÃO COINCIDAM
    def test_registration_fails_if_passwords_mismatch(self):
        url = reverse("user-register")
        data = {
            "username": "teste",
            "email": "teste@gmail.com",
            "password": "12345678A@",
            "password2": "SENHA_INCORRETA",
        }

        response = self.client.post(url, data, format='json')

        self.assertEqual(response.status_code, 400)
        self.assertEqual(User.objects.count(), 0)
    
    # TESTE PERFIL AUTENTICADO
    def test_user_authenticated_user_can_view_profile(self):
        # USUARIO DE TESTE
        user = User.objects.create_user(username='logado', password='@A87654321')
        # FORÇA AUTENTICAÇÃO
        self.client.force_authenticate(user=user)
        # REQUISIÇÃO
        url = reverse("user-profile")
        response = self.client.get(url)
        # VERIFICA
        self.assertEqual(response.status_code, 200)

    # TESTE PERFIL NAO AUTENTICADO
    def test_user_profile_view_requires_auth(self):
        url = reverse("user-profile")
        response = self.client.get(url)

        self.assertEqual(response.status_code, 401)
    
# REGISTRO DE LOCAL
class LocalTestCase(TestCase):

    def setUp(self):
        self.url = reverse('instance')
    
    # ENDEREÇO VÁLIDO
    @patch('app.services.geocode_address')
    def test_create_location(self, mock_geocode):
        mock_geocode.return_value = (-22, 48.9)

        data = {
            "id": "1",
            "name": "Local Novo",
            "description": "Muito bonito aqui",
            "note": "5",
            "adress": "Rua 1234",
        }

        response = self.client.post(self.url, data, format='json')

        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.data['lat'], -22)
        self.assertEqual(response.data['long'], 48.9)

    # ENDEREÇO INVÁLIDO
    @patch('app.services.geocode_adress')
    def test_address_invalidation(self, mock_geocode):
        mock_geocode.return_value = None

        data = {
            "id": "1",
            "name": "Praça",
            "description": "Muito bonito aqui",
            "note": "5",
            "adress": "??",
        }

        response = self.client.post(self.url, data, format='json')
        self.assertEqual(response.status_code, 401)

    # LATITUDE INVÁLIDA
    def test_latitude_invalidation(self):
        data = {
            "id": "1",
            "name": "APAE",
            "description": "bonito",
            "note": "1",
            "latitude": 200,
            "longitude": -47.8
        }

        response = self.client.post(self.url, data, format='json')
        self.assertEqual(response.status_code, 401)
    
    # LONGITUDE INVÁLIDA
    def test_longitude_invalidation(self):
        data = {
            "id": "1",
            "name": "Local Novo",
            "description": "bonito",
            "note": "1",
            "latitude": 45,
            "longitude": -200
        }

        response = self.client.post(self.url, data, format='json')
        self.assertEqual(response.status_code, 401)

    # FALHA NA CONEXÃO DA API DE GEOLOCALIZAÇÃO
    @patch('app.services.geocode_adress')
    def test_API_invalidation(self, mock_geocode):
        mock_geocode.side_effect = Exception("Geocoding service down")

        data = {
            "id": "1",
            "name": "Local Novo",
            "description": "bonito",
            "adress": "Rua X"
        }

        response = self.client.post(self.url, data, format='json')
        self.assertEqual(response.status_code, 500)




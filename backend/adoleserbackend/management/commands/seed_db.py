import random
from django.core.management.base import BaseCommand
from django.utils import timezone
from datetime import timedelta
from adoleserbackend.models import User, Instance, Category, Activity, Role, Address

class Command(BaseCommand):
    help = 'Seed the database with test data for São Carlos - SP'

    def handle(self, *args, **kwargs):
        self.stdout.write("Starting database seeding...")
        
        # 1. Create a User
        user, created = User.objects.get_or_create(
            username='admin_seed',
            defaults={
                'name': 'Admin Seed',
                'email': 'admin@seed.com',
                'role': Role.ADMIN,
            }
        )
        if created:
            user.set_password('admin123')
            user.save()
            self.stdout.write(self.style.SUCCESS("Created admin_seed user"))

        # 2. Create Categories
        category_names = ['Esportes', 'Cultura', 'Lazer', 'Educação', 'Música', 'Artes']
        categories = {}
        for name in category_names:
            cat, cat_created = Category.objects.get_or_create(name=name)
            categories[name] = cat
            if cat_created:
                self.stdout.write(self.style.SUCCESS(f"Created category: {name}"))

        # 3. Create Instances (Locations in São Carlos)
        locations_data = [
            {
                'name': 'Parque Cônego Antônio Manzi (Kartódromo)',
                'description': 'Praça pública ampla com quadras esportivas e área para caminhada e lazer.',
                'address': 'Kártodromo - São Carlos, SP',
                'latitude': -22.0152,
                'longitude': -47.8872,
            },
            {
                'name': 'SESC São Carlos',
                'description': 'Centro de cultura, esporte e lazer com diversas atividades e eventos.',
                'address': 'Av. Comendador Alfredo Maffei, 700 - Jardim Gibertoni, São Carlos - SP',
                'latitude': -22.0195,
                'longitude': -47.8885,
            },
            {
                'name': 'UFSCar - Universidade Federal de São Carlos',
                'description': 'Campus da universidade com áreas abertas, lago, biblioteca e eventos abertos ao público.',
                'address': 'Rod. Washington Luís, s/n - Monjolinho, São Carlos - SP',
                'latitude': -21.9808,
                'longitude': -47.8804,
            },
            {
                'name': 'Teatro Municipal de São Carlos',
                'description': 'Espaço destinado a apresentações artísticas e culturais.',
                'address': 'R. Sete de Setembro, 1735 - Centro, São Carlos - SP',
                'latitude': -22.0163,
                'longitude': -47.8920,
            },
            {
                'name': 'Praça Voluntários da Pátria',
                'description': 'Praça central com coreto e bancos, próxima ao mercado municipal.',
                'address': 'Centro, São Carlos - SP',
                'latitude': -22.0177,
                'longitude': -47.8922,
            },
             {
                'name': 'Parque Ecológico de São Carlos',
                'description': 'Parque zoológico com foco na conservação de espécies sul-americanas.',
                'address': 'Estrada Municipal Fazenda Vau, S/N, São Carlos - SP',
                'latitude': -21.9961,
                'longitude': -47.8919,
            }
        ]

        instances = []
        for loc in locations_data:
            addr_instance, _ = Address.objects.get_or_create(
                cep='00000-000',
                street=loc['address'],
                number='S/N'
            )
            instance, loc_created = Instance.objects.get_or_create(
                name=loc['name'],
                defaults={
                    'description': loc['description'],
                    'address': addr_instance,
                    'latitude': loc['latitude'],
                    'longitude': loc['longitude'],
                    'created_by': user
                }
            )
            instances.append(instance)
            if loc_created:
                self.stdout.write(self.style.SUCCESS(f"Created instance: {loc['name']}"))

        # 4. Create Activities
        activities_data = [
            {
                'name': 'Futebol no Parque',
                'description': 'Partida amigável de futebol aberta ao público no final de semana.',
                'instance': instances[0], # Kartódromo
                'categories': [categories['Esportes'], categories['Lazer']],
                'delta_days': 1
            },
            {
                'name': 'Oficina de Teatro',
                'description': 'Aulas gratuitas de teatro para iniciantes com foco em expressão corporal.',
                'instance': instances[1], # SESC
                'categories': [categories['Artes'], categories['Cultura']],
                'delta_days': 2
            },
            {
                'name': 'Show de Rock Local',
                'description': 'Apresentação de bandas independentes de São Carlos na praça pública.',
                'instance': instances[4], # Praça Voluntários
                'categories': [categories['Música'], categories['Cultura']],
                'delta_days': 5
            },
            {
                'name': 'Feira de Ciências',
                'description': 'Exposição de projetos científicos dos alunos da universidade.',
                'instance': instances[2], # UFSCar
                'categories': [categories['Educação']],
                'delta_days': 3
            },
             {
                'name': 'Roda de Capoeira',
                'description': 'Encontro aberto de capoeiristas da região. Todos são bem vindos.',
                'instance': instances[0], # Kartódromo
                'categories': [categories['Esportes'], categories['Cultura']],
                'delta_days': 0
            },
            {
                'name': 'Trilha Guiada',
                'description': 'Trilha super legal para quem gosta da natureza e animais.',
                'instance': instances[5], # Parque Ecológico
                'categories': [categories['Lazer'], categories['Educação']],
                'delta_days': 4,
                'target_age': 10
            }
        ]

        for act in activities_data:
            horario = timezone.now() + timedelta(days=act['delta_days'])
            activity, act_created = Activity.objects.get_or_create(
                name=act['name'],
                defaults={
                    'description': act['description'],
                    'instance': act['instance'],
                    'horario': horario,
                    'created_by': user,
                    'contact_email': 'contato@saocarlos.exemplo.com',
                    'target_age': act.get('target_age', 12)  # Defaulting 12 if not customized
                }
            )
            if act_created:
                activity.categories.set(act['categories'])
                self.stdout.write(self.style.SUCCESS(f"Created activity: {act['name']}"))

        self.stdout.write(self.style.SUCCESS("Database seeding completed!"))

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/custom_card_atividade.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  // Lista de exemplo de atividades favoritas
  // Substitua pelos seus dados reais
  final List<Map<String, dynamic>> _favoritesActivities = const [
    {
      'imageUrl': 'assets/images/img1.jpg',
      'title': 'Centro Cultural UFSCar',
      'address': 'Rod. Washington Luís, km 235 - São Carlos',
      'description': 'Espaço cultural com exposições, teatro e atividades artísticas para todas as idades.',
      'rating': 4.5,
      'ratingQtd': 120,
    },
    {
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },
    {
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },
    {
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },
    {
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },
    {
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },
    {
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },
    {
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },
    {
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },{
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },{
      'imageUrl': 'assets/images/img2.jpg',
      'title': 'Parque Ecológico',
      'address': 'Av. Dr. Carlos Botelho, 1540 - São Carlos',
      'description': 'Área verde com trilhas, playground e espaços para atividades ao ar livre.',
      'rating': 4.8,
      'ratingQtd': 85,
    },


    // Adicione mais atividades conforme necessário
  ];

  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1200) {
      return 4; // Desktop large
    } else if (screenWidth >= 800) {
      return 2; // Tablet/Desktop small
    } else {
      return 1; // Mobile
    }
  }

  double _getChildAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 800) {
      return 0.75; // Mais quadrado em telas maiores
    } else {
      return 0.85; // Ligeiramente mais alto em mobile
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isLoggedIn = auth.isLoggedIn;

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: isLoggedIn)
          : null,
      body: _favoritesActivities.isEmpty
          ? _buildEmptyState(context)
          : _buildFavoritesList(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              AppTexts.favorites.none,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppTexts.favorites.addMore,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth < 600 ? 20.0 : 24.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título da seção
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  AppTexts.favorites.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Grid responsivo de favoritos
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: padding / 2,
                mainAxisSpacing: padding / 2,
                childAspectRatio: _getChildAspectRatio(context),
              ),
              itemCount: _favoritesActivities.length,
              itemBuilder: (context, index) {
                final activity = _favoritesActivities[index];
                return CustomCardAtividade(
                  imageUrl: activity['imageUrl'],
                  title: activity['title'],
                  address: activity['address'],
                  description: activity['description'],
                  rating: activity['rating'],
                  ratingQtd: activity['ratingQtd'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
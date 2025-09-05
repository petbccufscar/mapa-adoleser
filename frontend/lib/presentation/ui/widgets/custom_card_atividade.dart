import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/action_text.dart';

class CustomCardAtividade extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String address;
  final String description;
  final double rating;
  final int ratingQtd;

  const CustomCardAtividade({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.address,
    required this.description,
    required this.rating,
    required this.ratingQtd,
  });

  Future<void> _launchExternalUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: screenWidth < 600 ? 150 : 250, // Responsivo
                  fit: BoxFit.cover,
                ),
              ),

              // Conteúdo do card
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    // Rating
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      children: [
                        Text(
                          '$rating',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.textPrimary),
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors.textPrimary,
                          size: 15.0,
                        ),
                        Icon(
                          Icons.circle,
                          color: AppColors.inputBorder,
                          size: 5.0,
                        ),
                        Text(
                          '$ratingQtd avaliações',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.textTertiary),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Endereço + link
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            address,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          ' | ',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.link,
                          ),
                        ),
                        ActionText(
                          text: 'ver no mapa',
                          action: () {
                            _launchExternalUrl(
                              'https://www.google.com/maps/place/UFSCar+-+Universidade+Federal+de+S%C3%A3o+Carlos',
                            );
                          },
                          underlined: true,
                          color: AppColors.link,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Descrição
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: screenWidth < 400 ? 3 : 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

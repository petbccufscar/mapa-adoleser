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
              height: 120,
              fit: BoxFit.cover,
            ),
          ),

          // Conteúdo do card
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),
                // Espaço para rating
                Row(
                  children: [
                    Text(
                      '$rating',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.textPrimary,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: AppColors.inputBorder,
                      size: 5.0,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '$ratingQtd avaliações',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textTertiary),
                    )
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Text(
                      address,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                            'https://www.google.com/maps/place/UFSCar+-+Universidade+Federal+de+S%C3%A3o+Carlos/@-21.9840512,-47.8773248,14z/data=!4m6!3m5!1s0x94b870d8899b96c5:0x26db4c677a5af1d4!8m2!3d-21.9839942!4d-47.8815371!16zL20vMDNmZnRf?entry=ttu&g_ep=EgoyMDI1MDkwMi4wIKXMDSoASAFQAw%3D%3D');
                      },
                      underlined: true,
                      color: AppColors.link,
                    ),
                  ],
                ),
                // Endereço

                const SizedBox(height: 6),

                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),

                // Descrição
              ],
            ),
          ),
        ],
      ),
    );
  }
}

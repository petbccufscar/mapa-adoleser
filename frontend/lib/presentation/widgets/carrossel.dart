import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mapa_adoleser/presentation/pages/profile/profile_page.dart';

class Carrossel extends StatefulWidget {
  const Carrossel({super.key});

  @override
  State<Carrossel> createState() => _CarrosselState();
}

class _CarrosselState extends State<Carrossel> {
  int _currentIndex = 0;

  final List<String> imagePaths = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img5.png',
  ];

  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: imagePaths.length,
          carouselController: _controller,
          options: CarouselOptions(
            height: 500,
            viewportFraction: 1.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: SizedBox(
                width: 900,
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                  width: 900,
                  height: 500,
                ),
              ),
            );
          },
        ),
        // Bolinhas acima da imagem
        Positioned(
          top: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imagePaths.asMap().entries.map((entry) {
              return Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.purple
                      : const Color.fromRGBO(128, 128, 128, 0.7),
                ),
              );
            }).toList(),
          ),
        ),
        // Botão esquerdo
        Positioned(
          left: 10,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
            onPressed: () {
              _controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            },
          ),
        ),
        // Botão direito
        Positioned(
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30),
            onPressed: () {
              _controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            },
          ),
        ),
      ],
    );
  }
}

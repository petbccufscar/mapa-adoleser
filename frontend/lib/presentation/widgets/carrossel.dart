import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carrossel extends StatefulWidget {
  const Carrossel({super.key});

  @override
  State<Carrossel> createState() => _CarrosselState();
}

class _CarrosselState extends State<Carrossel> {
  int _currentIndex = 0;

  final List<String> imagePaths = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
    'assets/images/banner4.png',
    'assets/images/banner5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 500, // altura da imagem
            viewportFraction: 1.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: imagePaths.map((path) {
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                  width: 900, // largura da imagem
                  child: Image.asset(
                    path,
                    fit: BoxFit.cover,
                    width: 900,
                    height: 500,
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagePaths.asMap().entries.map((entry) {
            return Container(
              width: 12.0,
              height: 12.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key
                    ? Colors.purple // bolinha ativa
                    : Colors.grey,  // bolinhas inativas
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

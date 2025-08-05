import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  final List<String> imagePaths = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
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
              height: 450,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 3),
              autoPlayInterval: Duration(seconds: 10),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return GestureDetector(
                onTap: () {
                  log('CLICOU');
                },
                child:  Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imagePaths.asMap().entries.map((entry) {
                return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () => _controller.jumpToPage(entry.key),
                        child: Container(
                          width: 14.0,
                          height: 14.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key
                                ? AppColors.purple
                                : AppColors.backgroundSmoke,
                          ),
                        )));
              }).toList(),
            ),
          ),
          Positioned(
            left: 10,
            child: IconButton(
              visualDensity: VisualDensity.standard,
              icon: const Icon(Icons.chevron_left_rounded,
                  color: AppColors.iconLight, size: 30),
              onPressed: () {
                _controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
            ),
          ),
          Positioned(
            right: 10,
            child: IconButton(
              visualDensity: VisualDensity.standard,
              icon: const Icon(Icons.chevron_right_rounded,
                  color: AppColors.iconLight, size: 30),
              onPressed: () {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
            ),
          ),
        ],
    );
  }
}

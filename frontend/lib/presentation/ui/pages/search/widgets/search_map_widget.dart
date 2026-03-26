import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;
import 'package:mapa_adoleser/providers/activity_search_provider.dart';
import 'package:provider/provider.dart';
import 'package:mapa_adoleser/core/theme/app_colors.dart';
import 'package:geolocator/geolocator.dart';

class SearchMapWidget extends StatefulWidget {
  const SearchMapWidget({super.key});

  @override
  State<SearchMapWidget> createState() => _SearchMapWidgetState();
}

class _SearchMapWidgetState extends State<SearchMapWidget> {
  final MapController _mapController = MapController();
  LatLng? _userLocation;
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    
    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
      if (_isMapReady) {
        _mapController.move(_userLocation!, 14.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<ActivitySearchProvider>();
    final activities = searchProvider.activities;
    final selectedActivity = searchProvider.selectedActivity;

    final markers = activities.map((activity) {
      final isSelected = selectedActivity?.id == activity.id;
      return Marker(
        point: LatLng(activity.latitude, activity.longitude),
        width: isSelected ? 80 : 50,
        height: isSelected ? 80 : 50,
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            searchProvider.selectActivity(activity);
          },
          child: AnimatedScale(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            scale: isSelected ? 1.0 : 0.8,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: isSelected ? 8 : 4,
                  child: CustomPaint(
                    size: isSelected ? const Size(16, 12) : const Size(10, 8),
                    painter: _TrianglePainter(color: isSelected ? AppColors.pink : AppColors.purple),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: isSelected ? 18 : 10),
                  padding: EdgeInsets.all(isSelected ? 10 : 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.pink : AppColors.purple,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (isSelected ? AppColors.pink : AppColors.purple).withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                        spreadRadius: isSelected ? 4 : 0,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white,
                      width: isSelected ? 3 : 2,
                    ),
                  ),
                  child: Icon(
                    Icons.star_rounded,
                    color: Colors.white,
                    size: isSelected ? 28 : 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    // Add a marker for the user's location if available
    if (_userLocation != null) {
      markers.add(
        Marker(
          point: _userLocation!,
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: const LatLng(-22.0154, -47.8911),
            initialZoom: 13.0,
            onMapReady: () {
              _isMapReady = true;
              if (_userLocation != null) {
                _mapController.move(_userLocation!, 14.0);
              } else {
                // Force a micro-move to ensure tiles render on Web if position is denied
                _mapController.move(const LatLng(-22.0154, -47.8911), 13.00001);
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.mapaadoleser.app',
            ),
            MarkerLayer(markers: markers),
          ],
        ),
        if (_userLocation != null)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: 'locate_user',
              backgroundColor: AppColors.backgroundWhite,
              onPressed: () {
                _mapController.move(_userLocation!, 14.0);
              },
              child: const Icon(Icons.my_location_rounded, color: AppColors.purple),
            ),
          ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'dart:ui';

import 'package:flutter/material.dart';

class HorizontalArrowList extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double height;
  final double scrollStep;

  const HorizontalArrowList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.height = 120,
    this.scrollStep = 200,
  });

  @override
  State<HorizontalArrowList> createState() => _HorizontalArrowListState();
}

class _HorizontalArrowListState extends State<HorizontalArrowList> {
  late final ScrollController _controller;

  bool get _canScrollBack => _controller.hasClients && _controller.offset > 0;

  bool get _canScrollForward =>
      _controller.hasClients &&
      _controller.offset < _controller.position.maxScrollExtent;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()..addListener(() => setState(() {}));

    // força reavaliação depois do primeiro layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollBy(double offset) {
    if (!_controller.hasClients) return;

    _controller.animateTo(
      (_controller.offset + offset)
          .clamp(0.0, _controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  Widget _arrow({
    required IconData icon,
    required VoidCallback onTap,
    required Alignment alignment,
  }) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Material(
          color: Colors.black.withAlpha(10),
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: onTap,
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _edgeShadow({
    required Alignment alignment,
    required bool isLeft,
  }) {
    return IgnorePointer(
      child: Align(
        alignment: alignment,
        child: Container(
          width: 32,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
              end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
              colors: [
                Colors.black.withAlpha(15),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          // Lista horizontal
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: const {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.trackpad,
              },
            ),
            child: ListView.separated(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: widget.itemCount,
              itemBuilder: widget.itemBuilder,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
            ),
          ),

          // Sombra esquerda
          if (_canScrollBack)
            _edgeShadow(
              alignment: Alignment.centerLeft,
              isLeft: true,
            ),

          // Sombra direita
          if (_canScrollForward)
            _edgeShadow(
              alignment: Alignment.centerRight,
              isLeft: false,
            ),

          // Seta esquerda
          if (_canScrollBack)
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: _arrow(
                icon: Icons.chevron_left,
                alignment: Alignment.centerLeft,
                onTap: () => _scrollBy(-widget.scrollStep),
              ),
            ),

          // Seta direita
          if (_canScrollForward)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: _arrow(
                icon: Icons.chevron_right,
                alignment: Alignment.centerRight,
                onTap: () => _scrollBy(widget.scrollStep),
              ),
            ),
        ],
      ),
    );
  }
}

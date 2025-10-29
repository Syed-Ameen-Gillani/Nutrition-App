import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  static const route = '/photo';
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  final TransformationController _controller = TransformationController();
  TapDownDetails? _doubleTapDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   elevation: 0,
      // ),
      body: GestureDetector(
        onDoubleTapDown: (details) {
          _doubleTapDetails = details;
        },
        onDoubleTap: _handleDoubleTap,
        child: Center(
          child: InteractiveViewer(
            transformationController: _controller,
            minScale: 0.5,
            maxScale: 4.0,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
            ),
          ),
        ),
      ),
    );
  }

  void _handleDoubleTap() {
    if (_controller.value != Matrix4.identity()) {
      _controller.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      _controller.value = Matrix4.identity()
        ..translate(-position.dx * 1.5, -position.dy * 1.5)
        ..scale(3.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

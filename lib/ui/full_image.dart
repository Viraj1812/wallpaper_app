import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  const FullImage({required this.imageUrl, super.key});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: imageUrl,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

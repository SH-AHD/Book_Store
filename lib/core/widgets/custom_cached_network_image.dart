import 'package:bookia/core/widgets/shimmer/custom_shimmer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.url,
    this.width=double.infinity,
    this.height=100,  this.fit=BoxFit.cover, this.errorWidget,
    this.raduis=10,
  });

  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? errorWidget;
    final double raduis;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(raduis),
      child: CachedNetworkImage(
       imageUrl: url,
       width: width,
       height: height,
       fit: fit,
       progressIndicatorBuilder: (context, url, downloadProgress) => 
              errorWidget?? CustomShimmerWidget(width: width, height: height,
               borderRadius: 10,
               ),
       errorWidget: (context, url, error) => Icon(Icons.error),
    ),
    );
  }
}

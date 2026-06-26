import 'package:bookia/core/widgets/shimmer/custom_shimmer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.url,
    this.width = double.infinity,
    this.height = 100,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.raduis = 10,
    this.imgprof = false,
  });

  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? errorWidget;
  final double raduis;
  final bool imgprof;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(imgprof ? 0 : raduis),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        imageBuilder: imgprof == true
            ? (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : null,
        fit: fit,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            errorWidget ??
            CustomShimmerWidget(
              width: width,
              height: height,
              borderRadius: imgprof ? 40 : 10,
            ),
        errorWidget: (context, url, error) =>
            errorWidget ?? const Icon(Icons.error),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer/core/view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorSliderWidget extends StatelessWidget {
  final List<String> imgList;

  const VendorSliderWidget({
    Key? key, required this.imgList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map(
          (model) => CachedNetworkImage(
        imageUrl: model,
        fit: BoxFit.cover,
      ),
    ).toList();
    return CarouselSlider(
      items: imageSliders,
      carouselController: CarouselController(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
      ),
    );
  }
}

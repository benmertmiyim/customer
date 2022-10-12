import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer/core/view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BannerView bannerView = Provider.of<BannerView>(context);

    if (bannerView.bannerProcess == BannerProcess.idle) {
      final bannerList = bannerView.bannerList;
      if (bannerList != null) {
        final List<Widget> imageSliders = bannerList
            .map(
              (model) => CachedNetworkImage(
                imageUrl: model.bannerURL,
                fit: BoxFit.cover,
              ),
            )
            .toList();

        return CarouselSlider(
          items: imageSliders,
          carouselController: CarouselController(),
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
          ),
        );
      } else {
        return const Text("");
      }
    } else {
      return const AspectRatio(aspectRatio:16/9,child: Center(child: CircularProgressIndicator()));
    }
  }
}

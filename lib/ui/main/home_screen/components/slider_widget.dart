import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://i0.wp.com/www.cbot.ai/wp-content/uploads/2021/06/getir-2.png?w=1920&ssl=1',
  'https://cdn.getir.com/misc/611e55d33ea65bef40f9ba05_banner_tr_1629378026496.jpeg',
  ];

final List<Widget> imageSliders = imgList
    .map((item) => Image.network(item, fit: BoxFit.cover,),)
    .toList();

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Expanded(
        child: CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,

              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Positioned(
        bottom: 8,
        right: 0,
        left: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}

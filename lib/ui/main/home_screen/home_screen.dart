import 'package:customer/ui/main/home_screen/components/slider_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderWidget(),
      ],
    );
  }
}

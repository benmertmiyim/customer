import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/vendor_view.dart';
import 'package:customer/ui/main/home_screen/components/active_park.dart';
import 'package:customer/ui/main/home_screen/components/not_reted_widget.dart';
import 'package:customer/ui/main/home_screen/components/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    return ListView(
      primary: true,
      children: [
        const SliderWidget(),
        authView.activePark != null
            ? ActivePark(
                parkHistory: authView.activePark!,
              )
            : Container(),
        const NotRatedWidget(),
      ],
    );
  }
}

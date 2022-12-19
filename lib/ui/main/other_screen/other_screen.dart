import 'package:customer/ui/main/profile_screen/components/tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Others"),
      ),
      body: ListView(
        children: [
          TileWidget(title: "KVKK",onClick: (){},),
          TileWidget(title: "Privacy Policy",onClick: (){},),
          TileWidget(title: "User Agreement",onClick: (){},),
          const SizedBox(height: 16,),
          Column(children: [
            SvgPicture.asset(
              "assets/images/parkin_logo.svg",
              width: 128,
            ),
            const SizedBox(height: 8,),
            Text(
              "Version ${packageInfo.version}",
            ),
          ],),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final Function()? onClick;
  final String title;

  const TileWidget({Key? key, this.onClick, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(title),onTap: onClick,);
  }

}

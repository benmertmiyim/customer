import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final Function()? onClick;
  final String title;
  final String? subTitle;
  final bool isLogout;

  const TileWidget(
      {Key? key,
      this.onClick,
      required this.title,
      this.isLogout = false,
      this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      elevation: 2,
      child: ListTile(
        subtitle: subTitle != null ? Text("${subTitle!} ₺") : null,
        title: Text(
          title,
          style: TextStyle(
            color: isLogout
                ? Colors.red
                : (onClick != null ? Colors.black : Colors.black54),
          ),
        ),
        onTap: onClick,
        trailing: isLogout
            ? const Icon(Icons.logout)
            : onClick != null
                ? const Icon(Icons.arrow_forward_ios_outlined)
                : null,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final Function()? onClick;
  final String title;
  final bool isLogout;
  final bool isPhone;

  const TileWidget(
      {Key? key,
      this.onClick,
      required this.title,
      this.isLogout = false,
      this.isPhone = false,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      elevation: 2,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: isLogout
                ? Colors.red
                : (onClick != null ? Colors.black : Colors.black54),
          ),
        ),
        onTap: onClick,
        trailing: isLogout ? Icon(Icons.logout) : (onClick != null ? (isPhone ? Icon(Icons.error,color: Colors.red,):Icon(Icons.arrow_forward_ios)) : null),
      ),
    );
  }
}

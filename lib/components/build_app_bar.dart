import 'package:flutter/material.dart';
import 'package:todoalgoriza/util/routes.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    ),
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: Colors.black,
          height: 0.05,
        )),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        AppRoute.pop();
      },
    ),
  );
}

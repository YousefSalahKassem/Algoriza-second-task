import 'package:flutter/material.dart';
import 'package:todoalgoriza/styles/dimensions.dart';
import 'package:todoalgoriza/util/routes.dart';
import 'package:todoalgoriza/view/Schedule/screens/schedule_screen.dart';

AppBar getAppBar(BuildContext context) {
  return AppBar(
      elevation: 0,
      title: const Text(
        'Board',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.table_view_outlined),
          onPressed: () {
            AppRoute.push(const ScheduleScreen());
          },
        ),
      ],
      bottom: PreferredSize(
          preferredSize: Size(double.maxFinite, context.height10 * 7.1),
          child: Column(
            children: [
              const Divider(
                thickness: .6,
              ),
              TabBar(
                  isScrollable: false,
                  indicatorColor: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  indicatorWeight: 1,
                  labelColor: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  labelPadding: const EdgeInsets.all(.5),
                  unselectedLabelColor: Colors.grey,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Uncompleted',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                    Tab(
                      text: 'Favorites',
                    ),
                  ]),
              const Divider(
                thickness: .6,
              ),
            ],
          )));
}

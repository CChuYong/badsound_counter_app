import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/base_color.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenAwareSize(56.0, context)),
            child: TopBar()),
        body: Padding(
            padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
            child: Container(
              height: double.infinity,
              child: this.child,
            )),
        // bottomNavigationBar:
        // Container(
        //   decoration: BoxDecoration(
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.25),
        //         spreadRadius: 5,
        //         blurRadius: 300,
        //         offset: Offset(0, 0), // changes position of shadow
        //       ),
        //     ],
        //   ),
        //   child:  ClipRRect(
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(24.sp),
        //       topRight: Radius.circular(24.sp),
        //     ),
        //     child: BottomBar()
        //   ),
        // ),

        endDrawer: SideBar());
  }

  double screenAwareSize(double size, BuildContext context) {
    double drawingHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return size * drawingHeight / 650.0;
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            Icon(
              Icons.ac_unit,
              color: BaseColor.warmGray600,
              size: 18.sp,
            ),
            Text(
              '나쁜말 카운터',
              style: TextStyle(
                color: BaseColor.warmGray600,
                fontSize: 15.sp,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ));
  }
}

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 128.sp,
            child:  const DrawerHeader(
              decoration: BoxDecoration(
                color: BaseColor.warmGray700,
              ),
              child: Text('나쁜말 카운터'),
            ),
          ),

          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

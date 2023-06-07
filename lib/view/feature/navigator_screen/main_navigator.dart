import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../designsystem/theme/base_color.dart';

class MainNavigator extends StatefulWidget {
  final List<Widget> pages;
  final int defaultPageNumber;

  const MainNavigator(
      {super.key, required this.pages, required this.defaultPageNumber});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainNavigator> {
  late int _currentPageIndex = widget.defaultPageNumber;
  late Widget _currentPage = widget.pages[widget.defaultPageNumber];
  bool _incremental = false;

  final Duration animationDuration = const Duration(milliseconds: 50);

  void _movePage(int pageNumber) {
    setState(() {
      _incremental = pageNumber > _currentPageIndex;
      _currentPageIndex = pageNumber;
      _currentPage = widget.pages[pageNumber];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          child: AnimatedSwitcher(
              duration: animationDuration,
              child: _currentPage,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween(
                    begin: Offset(_incremental ? 1.0 : -1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(
                      parent: animation, curve: const Interval(0.0, 0.05))),
                  child: FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: const Interval(0.1, 1.0),
                    ),
                    child: child,
                  ),
                );
              })),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 300,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.sp),
              topRight: Radius.circular(24.sp),
            ),
            child: BottomBar(
              onNavButtonTap: (index) => {_movePage(index)},
              defaultPageNumber: widget.defaultPageNumber,
            )),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  final void Function(int)? onNavButtonTap;
  final int defaultPageNumber;

  const BottomBar(
      {super.key,
      required this.onNavButtonTap,
      required this.defaultPageNumber});

  @override
  State<StatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _currentPage = widget.defaultPageNumber;

  void _setPage(int index) {
    setState(() {
      _currentPage = index;
      widget.onNavButtonTap!(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: BaseColor.warmGray100,
      elevation: 24.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'calendar_page',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home_page',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'profile_page',
        )
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      unselectedIconTheme:
          IconThemeData(color: BaseColor.warmGray400, size: 25.sp),
      selectedIconTheme:
          IconThemeData(color: BaseColor.warmGray800, size: 25.sp),
      currentIndex: _currentPage,
      onTap: (number) => {
        _setPage(number)
        //  Navigator.push(context, MaterialPageRoute(builder: (ctx) => const ProfilePage()))
      },
    );
  }
}

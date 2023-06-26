import 'package:badsound_counter_app/presenter/feature/main_navigator_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../designsystem/theme/base_color.dart';

class MainNavigator extends StatefulWidget {
  final Duration animationDuration = const Duration(milliseconds: 50);
  final List<Widget> pages;

  const MainNavigator({super.key, required this.pages});

  Widget render(BuildContext context, MainNavigatorAction action,
      MainNavigatorState state) {
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          child: AnimatedSwitcher(
              duration: animationDuration,
              child: pages[state.pageNumber],
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween(
                    begin: Offset(state.incremental ? 1.0 : -1.0, 0.0),
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
        child: BottomBar(
          onNavButtonTap: (index) => {action.bottomBarTap(index)},
          defaultPageNumber: state.pageNumber,
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => MainNavigatorAction();
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
          icon: Icon(Icons.people_alt),
          label: 'social_page',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home_page',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'menu_page',
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
      onTap: (number) => {if (number != _currentPage) _setPage(number)},
    );
  }
}

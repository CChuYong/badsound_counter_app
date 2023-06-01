import 'package:badsound_counter_app/component/touchableopacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const warmGray900 = Color(0xff1C1917);
const warmGray800 = Color(0xff292524);
const warmGray700 = Color(0xff44403C);
const warmGray600 = Color(0xff57534E);
const warmGray500 = Color(0xff78716C);
const warmGray400 = Color(0xffA8A29E);
const warmGray300 = Color(0xffD6D3D1);
const warmGray200 = Color(0xffE7E5E4);
const warmGray100 = Color(0xffF5F5F4);
const warmGray50 = Color(0xffFAFAF9);
const defaultGreen = Color(0xff10B981);
const defaultRed = Color(0xffFF8282);

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
              child: Column(children: [
                MainPageStatBox(),
                SizedBox(height: 20.sp),
                Expanded(child: MainPageChatBox()),
              ]),
            )),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.sp),
            topRight: Radius.circular(24.sp),
          ),
          child: BottomNavigationBar(
            backgroundColor: warmGray100,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'asdf',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'asdf',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'asdf',
              )
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedIconTheme: IconThemeData(color: warmGray400, size: 25.sp),
            selectedIconTheme: IconThemeData(color: warmGray800, size: 25.sp),
            currentIndex: 1,
          ),
        ),
        endDrawer: SideBar());
  }

  double screenAwareSize(double size, BuildContext context) {
    double drawingHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return size * drawingHeight / 650.0;
  }
}

class MainPageChatBox extends StatelessWidget {
  const MainPageChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '나쁜말 방 목록',
            style: TextStyle(
              color: warmGray900,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 13.sp),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                MainPageChatBoxElements(),
                SizedBox(height: 13),
                MainPageChatBoxElements(),
                SizedBox(height: 13),
                MainPageChatBoxElements(),
                SizedBox(height: 13),
                MainPageChatBoxElements(),
                SizedBox(height: 13),
                MainPageChatBoxElements(),
                SizedBox(height: 13),
                MainPageChatBoxAddElements(),
              ],
            )),
          )
        ],
      ),
    );
  }
}

class MainPageChatBoxElements extends StatelessWidget {
  const MainPageChatBoxElements({super.key});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(child: Container(
      padding:
      EdgeInsets.only(top: 10.sp, bottom: 10.sp, left: 14.sp, right: 14.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.sp),
        color: warmGray100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 51.sp,
                height: 51.sp,
                decoration: BoxDecoration(
                  color: warmGray700,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '벤님과의 나쁜말',
                    style: TextStyle(
                      color: warmGray900,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 5.sp),
                  Text(
                    '+ 28,000원',
                    style: TextStyle(
                      color: defaultGreen,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '오후 10:39',
                style: TextStyle(
                  color: warmGray900,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 5.sp),
              Container(
                alignment: AlignmentDirectional.center,
                width: 14.sp,
                height: 14.sp,
                decoration: BoxDecoration(
                  color: defaultRed,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ), onTap: () => {

    })
      ;
  }
}

class MainPageChatBoxAddElements extends StatelessWidget {
  const MainPageChatBoxAddElements({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 14.sp, bottom: 14.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.sp),
        color: warmGray100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Icon(
              Icons.person_add,
              color: warmGray600,
              size: 14.sp,
            ),
            SizedBox(width: 5.sp),
            Text(
              '방 생성하기',
              style: TextStyle(
                color: warmGray600,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ])
        ],
      ),
    );
  }
}

class MainPageStatBox extends StatelessWidget {
  const MainPageStatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 20.sp, bottom: 20.sp, left: 23.sp, right: 23.sp),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.sp),
          color: warmGray100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: warmGray600,
                  size: 14.sp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '5월 2주차 합산',
                      style: TextStyle(
                        color: warmGray900,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    //SizedBox(height: 6),
                    Text(
                      '12,000 원',
                      style: TextStyle(
                        color: defaultGreen,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6),
                    Wrap(
                      spacing: 4.sp,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          color: warmGray400,
                          size: 10.sp,
                        ),
                        Text(
                          '5/8 ~ 5/14 사이의 내역이에요!',
                          style: TextStyle(
                            color: warmGray400,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: warmGray600,
                  size: 14.sp,
                )
              ],
            ),
            const SizedBox(height: 18),
            const Divider(
              color: warmGray200,
            ),
            SizedBox(height: 8),
            Padding(
                padding: EdgeInsets.only(left: 30.sp, right: 30.sp),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8.sp,
                          children: [
                            Icon(
                              Icons.list_alt_outlined,
                              color: warmGray400,
                              size: 13.sp,
                            ),
                            Text(
                              '내역 보기',
                              style: TextStyle(
                                color: warmGray400,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: const VerticalDivider(
                        color: warmGray200,
                      )),
                      Expanded(
                          child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.sp,
                        children: [
                          Icon(
                            Icons.insert_chart,
                            color: warmGray400,
                            size: 13.sp,
                          ),
                          Text(
                            '통계 보기',
                            style: TextStyle(
                              color: warmGray400,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ))
          ],
        ));
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
              color: warmGray600,
              size: 18.sp,
            ),
            Text(
              '나쁜말 카운터',
              style: TextStyle(
                color: warmGray600,
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
                color: warmGray700,
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<StatefulWidget> createState() => _MyHomePageState();
//
//
// }
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

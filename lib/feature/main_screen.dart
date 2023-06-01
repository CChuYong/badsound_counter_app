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

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenAwareSize(56.0, context)),
        child: TopBar()
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
            child: MainPageStatBox(),
          ),
          Text(
            'Hello, world!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Hello, world!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ]
      ),
        endDrawer: SideBar()
    );
  }

  double screenAwareSize(double size, BuildContext context) {
    double drawingHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return size * drawingHeight / 650.0;
  }

}

class MainPageStatBox extends StatelessWidget {
  const MainPageStatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.sp, bottom: 20.sp, left: 23.sp, right: 23.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.sp),
        color: warmGray100,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                ),
              ),
              //SizedBox(height: 6),
              Text(
                '13,000 원',
                style: TextStyle(
                  color: defaultGreen,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
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
                    '5/8 ~ 5/14 사이의 내역이에요',
                    style: TextStyle(
                      color: warmGray400,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              )

            ],
          ),
          SizedBox(height: 18),
          Divider(
            color: warmGray200,
          ),
          SizedBox(height: 8),
          Padding(
              padding: EdgeInsets.only(left: 30.sp, right: 30.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '내역 보기',
                    style: TextStyle(
                      color: warmGray400,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  VerticalDivider(
                    color: warmGray200,
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
              )
          )


        ],
      )

    );
  }
  
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
  //    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    centerTitle: false,
      title: Text(
        '나쁜말 카운터',
        style: TextStyle(
          color: Color(0xff10B981),
          fontSize: 13.sp,
          fontWeight: FontWeight.w900,
        ),
      )
    );
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
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
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

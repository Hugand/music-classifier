import 'package:flutter/material.dart';
import 'components/atoms/bottom_nav_item.dart';
import 'components/views/listen_view.dart';
import 'res/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birdy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CustomColors.black,
      ),
      home: const MyHomePage(title: 'Birdy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedMenuItem = 0;

  final List<Widget> _viewsComponents = <Widget>[
    const ListenView(),
    const Center(child: Text("History"))
  ];

  void _setSelectedMenuItem(int index) {
    setState(() {
      _selectedMenuItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.w800
          )),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: _viewsComponents.elementAt(_selectedMenuItem),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavItem.build('Listen', 'assets/img/headphones.png', _selectedMenuItem == 0),
          BottomNavItem.build('History', 'assets/img/history-icon.png', _selectedMenuItem == 0),
        ],
        currentIndex: _selectedMenuItem,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: _setSelectedMenuItem,
      ),
    );
  }
}

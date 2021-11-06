import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 50.0,
              height: MediaQuery.of(context).size.width - 50.0,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 6.0,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(600.0),
              ),
              child: MaterialButton(
                color: Colors.black,
                shape: const CircleBorder(),
                onPressed: () {},
                child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(70.0),
                      width: 100.0,
                      height: 100.0,
                      child: SvgPicture.asset(
                        'assets/img/music-alt.svg',
                        color: Colors.white,
                        semanticsLabel: 'A red up arrow'
                      )
                    ),
                  )
              )
            )
            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
                const AssetImage("assets/img/headphones.png"),
                color: _selectedMenuItem == 0 ? Colors.white : Colors.white54,
                size: 24,
            ),
            label: 'Listen',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                const AssetImage("assets/img/history-icon.png"),
                color: _selectedMenuItem == 1 ? Colors.white : Colors.white54,
                size: 24,
            ),
            label: 'History',
          ),
        ],
        currentIndex: _selectedMenuItem,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: _setSelectedMenuItem,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListenView extends StatefulWidget {
  const ListenView({Key? key}) : super(key: key);

  @override
  State<ListenView> createState() => _ListenViewState();
}

class _ListenViewState extends State<ListenView> {

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

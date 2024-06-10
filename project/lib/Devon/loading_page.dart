import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading_page extends StatelessWidget {
  const Loading_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Image.asset('assets/Loading.jpg', width: 400),
          SizedBox(
            height: 50,
          ),
          Container(
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Loading',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                  // color: Colors.purple,
                  height: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SpinKitThreeBounce(
                        color: Colors.black,
                        size: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SpinKitFadingCircle(
            color: Colors.black,
            size: 100.0,
          ),  
          SizedBox(
            height: 15,
          ),
          Text(
            "We're getting everything ready for you.",
            style: TextStyle(
                fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', width: 40),
              SizedBox(
                width: 5,
              ),
              Text(
                'Kelapa Muda',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Papyrus',
                    fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/Devon/history_page.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/jerry/setting.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  bool userFetched = false;

  late User userData;
  initPrefsAndGetUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('token'))
        throw Exception("You have to logged in first");
      String token = prefs.getString('token')!;
      setState(() {
        userData = User.fromJson(JwtDecoder.decode(token));
        userFetched = true;
        print("axis");
      });
    } catch (e) {
      print('error di profile');
      print(e);
    }
  }

  @override
  initState() {
    super.initState();
    initPrefsAndGetUserData();
  }

  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
    return !userFetched
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Profile Page',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              actions: <Widget>[
                // IconButton(
                //   icon: Icon(Icons.shopping_cart_outlined),
                //   onPressed: () {
                //     // Lakukan sesuatu saat ikon diklik
                //     print('Ikon diklik');
                //   },
                // ),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    // Lakukan sesuatu saat item dipilih
                    if (value == 'Settings') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingWidget()),
                      );
                    } else if (value == 'Maintenance') {
                      print('maintenace');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => maintenance_page()),
                      // );
                    } else if (value == 'Updating') {
                      print('updating');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => maintenance_page()),
                      // );
                    } else if (value == 'Loading') {
                      print('Loading');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => maintenance_page()),
                      // );
                    } else {
                      print('error');
                      //               Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => maintenance_page()),
                      // );
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      {'icon': Icons.settings, 'text': 'Settings'},
                      {'icon': Icons.build, 'text': 'Maintenance'},
                      {'icon': Icons.update, 'text': 'Updating'},
                      {'icon': Icons.refresh, 'text': 'Loading'},
                      {'icon': Icons.error, 'text': 'Error'},
                    ].map((choice) {
                      return PopupMenuItem<String>(
                        value: choice['text'] as String,
                        child: ListTile(
                          leading: Icon(choice['icon'] as IconData),
                          title: Text(choice['text'] as String),
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: body(context, userData),
            // bottomNavigationBar: ConvexAppBar(
            //     initialActiveIndex: _selectedIndex,
            //     color: Colors.white,
            //     backgroundColor: Colors.grey,
            //     items: [
            //       TabItem(icon: Icons.mail),
            //       TabItem(icon: Icons.history),
            //       TabItem(icon: Icons.person),
            //     ],
            //     onTap: (int index) {
            //       if (index == 0) {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => HomePage()),
            //         );
            //       } else if (index == 1) {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => HistoryPage()),
            //         );
            //       } else {
            //         // Navigator.push(
            //         //   context,
            //         //   MaterialPageRoute(builder: (context) => ProfilePageWidget()),
            //         // );
            //       }
            //     }),
          );
  }
}

body(BuildContext context, User? user) {
  final prov = Provider.of<Settings_provider>(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.grey,
                child: Center(
                  child: Text(
                    user!.name[0].toUpperCase(),
                    style: TextStyle(
                        color: prov.enableDarkMode == true
                            ? Colors.white
                            : Colors.black,
                        fontSize: 100),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: Text(
                'Nama : ${user.name}',
                style: TextStyle(
                  fontSize: 22,
                  color:
                      prov.enableDarkMode == true ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Role : ${user.role}',
                style: TextStyle(
                  fontSize: 20,
                  color:
                      prov.enableDarkMode == true ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 10),
            Text(
              'NIK :',
              style: TextStyle(
                fontSize: 22,
                color:
                    prov.enableDarkMode == true ? Colors.white : Colors.black,
              ),
            ),
            Text(
              user.nik,
              style: TextStyle(
                fontSize: 20,
                color:
                    prov.enableDarkMode == true ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 10),
            Text(
              'Nomor HP :',
              style: TextStyle(
                fontSize: 20,
                color:
                    prov.enableDarkMode == true ? Colors.white : Colors.black,
              ),
            ),
            Text(
              user.number,
              style: TextStyle(
                fontSize: 20,
                color:
                    prov.enableDarkMode == true ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
      Spacer(),
    ],
  );
}

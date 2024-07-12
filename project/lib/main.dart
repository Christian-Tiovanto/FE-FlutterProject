import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/Devon/dashboard.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/Devon/error_page.dart';
import 'package:project/Devon/filepicker.dart';
import 'package:project/Devon/history_page.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/Devon/dashboard.dart';
import 'package:project/Devon/loading_page.dart';
import 'package:project/Devon/maintenance_page.dart';
import 'package:project/Devon/testing.dart';
import 'package:project/Devon/updating_page.dart';
import 'package:project/Devon/user_detail_screen.dart';
import 'package:project/hadron/login_screen.dart';
import 'package:project/hadron/loginpage.dart';
import 'package:project/hadron/welcome_screen.dart';
import 'package:project/jerry/create-user.dart';
import 'package:project/jerry/user.dart';
import 'package:project/jerrywijaya/profile.dart';
import 'package:project/services/user_services.dart';
import 'package:project/tian/PengajuanSurat.dart';
import 'package:project/tian/PengajuanSuratWidget/searchUserWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/jerrywijaya/walkthrough.dart';

void main() async {
  try {
    print("tes letter service");
    await LetterService().getUserLetter();
  } catch (e) {
    print('e');
    print(e);
  }
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.containsKey("token");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => Settings_provider(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserListProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => MailValue(),
    ),
  ], child: MyApp(isLoggedIn: isLoggedIn)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
    return MaterialApp(
      initialRoute: isLoggedIn ? "/HomeScreen" : "/",
      routes: {
        "/": (context) => const Login_screen(),
        "/HomeScreen": (context) => Dashboard_screen()
      },
      debugShowCheckedModeBanner: false,
      theme: prov.enableDarkMode == true ? prov.dark : prov.light,
    );
  }
}

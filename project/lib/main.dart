import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/Devon/dashboard.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/Devon/dashboard.dart';
import 'package:project/hadron/login_screen.dart';
import 'package:project/hadron/loginpage.dart';
import 'package:project/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
    return MaterialApp(
      initialRoute: isLoggedIn ? "/HomeScreen" : "/",
      routes: {
        "/": (context) => WelcomePage(),
        "/HomeScreen": (context) => Dashboard_screen()
      },
      debugShowCheckedModeBanner: false,
      theme: prov.enableDarkMode == true ? prov.dark : prov.light,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/Devon/dashboard.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/hadron/loginpage.dart';
import 'package:project/jerry/user.dart';
import 'package:project/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  try {
    await LetterService().getUserLetter();
  } catch (e) {}
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  bool isLoggedIn = false;
  bool isSuperAdmin = false;
  if (token != null) {
    try {
      isLoggedIn = token.isNotEmpty;
      isSuperAdmin = JwtDecoder.decode(token)['role'] == 'super_admin';
    } catch (_) {}
  }
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Settings_provider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MailValue(),
        ),
      ],
      child: MyApp(
        isLoggedIn: isLoggedIn,
        isSuperAdmin: isSuperAdmin,
      )));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool isSuperAdmin;
  const MyApp({super.key, required this.isLoggedIn, this.isSuperAdmin = false});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
    return MaterialApp(
      initialRoute: isLoggedIn ? "/HomeScreen" : "/",
      routes: {
        "/": (context) => WelcomePage(
              enabled: !isLoggedIn,
            ),
        "/HomeScreen": (context) =>
            isSuperAdmin ? UserPage() : Dashboard_screen()
      },
      debugShowCheckedModeBanner: false,
      theme: prov.enableDarkMode == true ? prov.dark : prov.light,
    );
  }
}

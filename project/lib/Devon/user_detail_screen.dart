import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/Devon/providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// import 'package:scrappingwebsite/login_screen.dart';
// import 'package:scrappingwebsite/user_provider.dart';

class UserDetail_screen extends StatefulWidget {
  final int index;
  UserDetail_screen({super.key, required this.index});
  // UserDetail_screen({Key? key, required this.index}) : super(key: key);

  @override
  State<UserDetail_screen> createState() => _UserDetail_screenState();
}

class _UserDetail_screenState extends State<UserDetail_screen> {
  String dropdown = "";
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final userListProvider = Provider.of<UserListProvider>(context);
    final prov = Provider.of<Settings_provider>(context);

    final userList = userListProvider.users;
    final _passwordController =
        TextEditingController(text: userList[widget.index].password);
    // final _confirmpasswordController = TextEditingController();

    final _usernameController =
        TextEditingController(text: userList[widget.index].name);
    final _nikController =
        TextEditingController(text: userList[widget.index].nik);
    final _numberController =
        TextEditingController(text: userList[widget.index].number);
    String? dropdownValue;
    String niksebelum = userList[widget.index].nik;

    void updateUserData(String nik, String updatedName, String updatedNik,
        String updatedRole, int updatedPhoneNum, String updatedPas) async {
      final apiUrl =
          'http://192.168.1.146:3000/api/v1/users/updateUserData'; // Ganti dengan URL API update data user Anda

      try {
        final response = await http.patch(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'nik': nik,
            'updatedName': updatedName,
            'updatedNik': updatedNik,
            'updatedRole': updatedRole,
            'updatedPhoneNum': updatedPhoneNum,
            'updatedPas': updatedPas,
          }),
        );

        if (response.statusCode == 200) {
          print('User updated successfully!');
        } else if (response.statusCode == 404) {
          print(jsonDecode(
              response.body)['message']); // Cetak pesan error dari server
        } else {
          throw Exception('Failed to update user');
        }
      } catch (e) {
        print('Error: $e');
        throw Exception('Server error');
      }
    }

    if (dropdown.isEmpty) {
      dropdown = userList[widget.index].role;
    }

    // Variabel untuk menyimpan nilai dropdown
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
        backgroundColor: Color(0xFFFF9900),
      ),
      body: Column(
        children: [
          Container(
            // color: Colors.blue,
            decoration: BoxDecoration(
              color: Color(0xFFFF9900),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(150),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFFB03A), // Warna bayangan
                  spreadRadius: 15, // Jangkauan bayangan
                  // blurRadius: 10, // Jarak blur bayangan
                  // offset: Offset(4, 4), // Offset bayangan (x, y)
                ),
              ],
            ),
            width: double.infinity,
            height: 20,
            child: Text(''),
          ),
          SizedBox(
            height: 25,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: Center(
              child: Text(
                userList[widget.index].name[0].toUpperCase(),
                style: TextStyle(
                    color: prov.enableDarkMode == true
                        ? Colors.white
                        : Colors.black,
                    fontSize: 80),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Name',
                prefixIcon: Icon(Icons.person), // Ikon di depan TextField
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _nikController,
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'NIK',
                prefixIcon: Icon(Icons.vpn_key), // Ikon di depan TextField
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          // Container(
          //   width: 300,
          //   child: TextField(
          //     controller: _roleController,
          //     decoration: InputDecoration(
          //       // labelText: 'Password',
          //       hintText: 'Role',
          //       prefixIcon:
          //           Icon(Icons.business_center), // Ikon di depan TextField
          //     ),
          //   ),
          // ),
          Container(
            width: 310,
            height: 55,
            // padding: EdgeInsets.all(0),

            // color: Colors.red,
            child: DropdownButton<String>(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),

              value: dropdownValue,
              hint: Row(
                children: [
                  SizedBox(
                    width: 3,
                  ),
                  Icon(
                    Icons.business_center,
                    color: prov.enableDarkMode == true
                        ? Colors.white
                        : Colors.black,
                  ), // Icon di sebelah kiri hint text
                  SizedBox(width: 10),
                  // Spasi antara ikon dan teks
                  dropdown.isEmpty
                      ? Text(
                          'Select a Role',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Text(dropdown)
                ],
              ), // Hint text
              icon: dropdown.isEmpty
                  ? Icon(
                      Icons.arrow_drop_down,
                      color: prov.enableDarkMode == true
                          ? Colors.white
                          : Colors.black,
                    )
                  : Icon(
                      Icons.arrow_drop_down,
                      color: prov.enableDarkMode == true
                          ? Colors.white
                          : Colors.black,
                    ),
// Icon di sebelah kanan
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color:
                      prov.enableDarkMode == true ? Colors.white : Colors.black,
                  fontSize: 16),
              underline: Container(
                height: 1,
                color:
                    prov.enableDarkMode == true ? Colors.white : Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  dropdown = newValue!;
                });
                print(newValue);
              },
              items: <String>['Direktur', 'Manager', 'SPV', 'Karyawan']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _numberController,
              // obscureText: true, // Hide password input
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Number',
                prefixIcon: Icon(Icons.phone), // Ikon di depan TextField
                // suffixIcon: Icon(Icons.check),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _passwordController,
              obscureText: _obscureText, // Hide password input
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock), // Ikon di depan TextField
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText = _obscureText ? false : true;
                      });
                    },
                    child: Icon(Icons.remove_red_eye)),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Color(0xFFCACACA),
              backgroundColor: Colors.orange,
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27.10)),
              minimumSize: Size(200, 45),
              shadowColor: Colors.black,
            ),
            onPressed: () {
              // if (_usernameController.text.isEmpty ||
              //     _nikController.text.isEmpty ||
              //     dropdown.isEmpty ||
              //     _numberController.text.isEmpty ||
              //     _passwordController.text.isEmpty) {
              //   // Show dialog for empty username
              //   String errorMessage = "";
              //   if (_usernameController.text.isEmpty) {
              //     errorMessage = 'Username is required.';
              //   } else if (_nikController.text.isEmpty) {
              //     errorMessage = 'NIK is required.';
              //   } else if (dropdown.isEmpty) {
              //     errorMessage = 'Role is required.';
              //   } else if (_numberController.text.isEmpty) {
              //     errorMessage = 'Number is required.';
              //   } else if (_passwordController.text.isEmpty) {
              //     errorMessage = 'Password is required.';
              //   }
              //   AwesomeDialog(
              //     context: context,
              //     animType: AnimType.scale,
              //     dialogType: DialogType.error,
              //     body: Center(
              //       child: Text(
              //         errorMessage,
              //         style: TextStyle(
              //           fontStyle: FontStyle.italic,
              //           color: prov.enableDarkMode == true
              //               ? Colors.white
              //               : Colors.black,
              //         ),
              //       ),
              //     ),
              //     title: 'This is Ignored',
              //     desc: 'This is also Ignored',
              //     btnOkColor: Colors.red,
              //     btnOkOnPress: () {},
              //   ).show();

              //   return;
              // }

              // AwesomeDialog(
              //   context: context,
              //   animType: AnimType.scale,
              //   dialogType: DialogType.error,
              //   body: Center(
              //     child: Text(
              //       'Confirm Password Is Incorrect',
              //       style: TextStyle(fontStyle: FontStyle.italic),
              //     ),
              //   ),
              //   title: 'This is Ignored',
              //   desc: 'This is also Ignored',
              //   btnOkColor: Colors.red,
              //   btnOkOnPress: () {},
              // ).show();
              // return;

              // print('ok');
              User updateUser = User(
                  name: _usernameController.text,
                  nik: _nikController.text,
                  password: _passwordController.text,
                  role: dropdown,
                  number: _numberController.text,
                  MailInbox: [],
                  userId: "");
              // userListProvider.addUser(newUser);
              userListProvider.updateUser(widget.index, updateUser);
              updateUserData(
                  niksebelum,
                  _usernameController.text,
                  _nikController.text,
                  dropdown,
                  int.parse(_numberController.text),
                  _passwordController.text);

              Navigator.pop(context, true);
            },
            child: Text('Update'),
          ),
          // SizedBox(
          //   height: 100,
          // ),
          // Row(
          //   // crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Divider(
          //         color: Colors.grey,
          //         thickness: 1,
          //         indent: 30,
          //         endIndent: 10, // Jarak antara Divider dan teks
          //       ),
          //     ),
          //     Text(
          //       ' Or signup with ',
          //       style: TextStyle(color: Colors.grey),
          //     ),
          //     Expanded(
          //       child: Divider(
          //         color: Colors.grey,
          //         thickness: 1,
          //         indent: 10, // Jarak antara Divider dan teks
          //         endIndent: 30, // Jarak antara Divider dan teks
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         // Tindakan yang ingin dilakukan saat CircleAvatar diklik
          //         print('CircleAvatar diklik!');
          //       },
          //       borderRadius: BorderRadius.circular(
          //           5), // Membuat efek ink menyesuaikan bentuk CircleAvatar
          //       child: CircleAvatar(
          //           radius: 18, backgroundColor: Colors.blue, child: Text('')),
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     InkWell(
          //       onTap: () {
          //         // Tindakan yang ingin dilakukan saat CircleAvatar diklik
          //         print('CircleAvatar diklik!');
          //       },
          //       borderRadius: BorderRadius.circular(
          //           5), // Membuat efek ink menyesuaikan bentuk CircleAvatar
          //       child: CircleAvatar(
          //           radius: 18, backgroundColor: Colors.blue, child: Text('')),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

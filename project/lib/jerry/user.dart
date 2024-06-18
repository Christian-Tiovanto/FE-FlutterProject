import 'package:flutter/material.dart';
import 'package:project/Devon/user_detail_screen.dart';
import 'package:project/jerry/create-user.dart';
import 'package:project/jerry/create-user2.dart';
import 'package:provider/provider.dart';
import 'package:project/Devon/providers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// class User {
//   final String name;

//   User(this.name);
// }

// 2. API Service (Optional)
// class UserService {
//   static Future<List<User>> getUsers() async {
//     // Replace with your actual API call
//     await Future.delayed(Duration(seconds: 1));
//     return [
//       User('Jerry'),
//       User('Hadron Herman Cong'),
//       User('Devon Marvelous Leon'),
//       User('Jerry Wijaya'),
//       User('Christian Tiovanto'),
//     ];
//   }
// }

class UserPage extends StatefulWidget {
  bool isupdated = false;
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // List<User> users = [];
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    // _fetchData();
  }

  // Future<void> _fetchData() async {
  //   try {
  //     final fetchedUsers = await UserService.getUsers();
  //     setState(() {
  //       users = fetchedUsers;
  //     });
  //   } catch (error) {
  //     // Handle errors appropriately
  //     print(error);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final userListProvider = Provider.of<UserListProvider>(context);

    final userList = userListProvider.users;
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by Name',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchTerm = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          final lowerCaseName = user.name.toLowerCase();
          if (searchTerm.isEmpty || lowerCaseName.contains(searchTerm)) {
            return card(context, user, index);
          } else {
            return SizedBox(); // Hide unmatched items
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey,
        onPressed: () async {
          // Navigate to CreateUserPage and await result
          final newUserName = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Signup_screen()),
          );

          if (newUserName != null) {
            // Add the new user to the list and update state
            setState(() {
              // users.add(User(newUserName));
              userListProvider.addUser(newUserName);
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackbarCreate(context));
            });
          }
        },
        label: Icon(Icons.add),
      ),
    );
  }
}

card(BuildContext context, User user, int index) {
  final userListProvider = Provider.of<UserListProvider>(context);

  return InkWell(
    onTap: () async {
      final _isupdated = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetail_screen(index: index)));
      if (_isupdated == true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbarUpdate(context, user.name, user.role));
      }
    },
    child: Container(
      // color: Colors.amber,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 20.0, bottom: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red, // Set background color to red
                  ),
                  child: Center(
                    child: Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : '',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 290,
                  height: 45,
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name),
                          Text('${user.role} - ${user.nik}')
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              // animType: ,
                              dialogType: DialogType.noHeader,
                              body: Container(
                                // color: Colors.black45,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${user.name} - ${user.role} Will be deleted',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        'Permanently,',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        'Are You Sure?',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // title: 'This is ignored',
                              // desc: 'This is also Ignored',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                userListProvider.removeUser(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackbarDelete(
                                        context, user.name, user.role));
                              },
                            ).show();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 2.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    ),
  );
}

snackbarCreate(BuildContext context) {
  return SnackBar(
    content: Text('New User Has been Created'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Kode untuk menghandle aksi snackbar
      },
    ),
  );
}

snackbarUpdate(BuildContext context, String name, String role) {
  return SnackBar(
    content: Text('${name} - ${role} Has been Updated'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Kode untuk menghandle aksi snackbar
      },
    ),
  );
}

snackbarDelete(BuildContext context, String name, String role) {
  return SnackBar(
    content: Text('${name} - ${role} Has been Deleted'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Kode untuk menghandle aksi snackbar
      },
    ),
  );
}

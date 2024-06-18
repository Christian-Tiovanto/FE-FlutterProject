import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/jerry/create-user.dart';
import 'package:project/jerry/create-user2.dart';
import 'package:provider/provider.dart';
import 'package:project/Devon/providers.dart';

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
            return card(context, user, userListProvider);
          } else {
            return SizedBox(); // Hide unmatched items
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
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
            });
          }
        },
        label: const Text('Tambah User'),
      ),
    );
  }
}

card(BuildContext context, User user, UserListProvider userListProvider) {
  return GestureDetector(
    onTap: () {
      print("user ditekan");
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, top: 20.0, bottom: 10.0, right: 10.0),
          child: Row(
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
              Expanded(child: Text(user.name)),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  userListProvider.removeUser(user);
                },
              )
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
  );
}

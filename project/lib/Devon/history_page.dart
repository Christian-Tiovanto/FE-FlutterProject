import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:project/Devon/home_page.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/jerrywijaya/profile.dart';
import 'package:project/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:project/Devon/filterpopup.dart'; // Sesuaikan dengan lokasi FilterPopup
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  // int _selectedIndex = 1;
  List<String>? selectedFilters = ['Urgent', 'Regular'];
  List<MailSent> lettersList = [];
  late TabController _convexTabController;
  bool resultFetched = false;

  void getUserLetter() async {
    try {
      final results = await LetterService().getUserCreatedLetter("ongoing");
      setState(() {
        lettersList = results;
        resultFetched = true;
        print('lettersList');
        print(lettersList);
      });
    } catch (error) {
      print('error history');
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    // Mengatur initialIndex pada TabController ke 2 untuk ConvexAppBar
    _convexTabController =
        TabController(length: 3, vsync: this, initialIndex: 1);
    getUserLetter();
  }

  @override
  Widget build(BuildContext context) {
    final LoggedInUser = Provider.of<UserListProvider>(context).onlineusers;

    Future<void> _refresh() async {
      await Future.delayed(Duration(seconds: 1));

      setState(() {});
    }

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,

            title: const Text(
              'History Kirim Surat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ), // Judul AppBar
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Ongoing',
                ),
                Tab(
                  text: 'Finished',
                ),
                Tab(
                  text: 'Cancelled',
                ),
              ],
              indicatorColor: Colors.green, // Mengatur warna garis bawah
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.green,
            ),
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ),
          body: TabBarView(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(11, 13, 0, 0),
                      child: ElevatedButton.icon(
                        label: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        icon: selectedFilters != null &&
                                selectedFilters!.length > 1
                            ? Text(
                                "${selectedFilters![0]}+${selectedFilters!.length - 1}",
                                style: TextStyle(color: Colors.black),
                              )
                            : selectedFilters!.isNotEmpty
                                ? Text(
                                    "${selectedFilters![0]}",
                                    style: TextStyle(color: Colors.black),
                                  )
                                : Text(
                                    'Filter',
                                    style: TextStyle(color: Colors.black),
                                  ),
                        onPressed: () async {
                          final List<String>? Filter =
                              await showDialog<List<String>>(
                            context: context,
                            builder: (BuildContext context) {
                              return FilterPopup(
                                  selectedFilters: selectedFilters);
                            },
                          );

                          // Handle selected filters here
                          if (Filter != null) {
                            setState(() {
                              selectedFilters = Filter;
                            });
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Atur radius di sini
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(
                              Size(90, 35)), // Atur ukuran di sini
                          // Atau menggunakan fixedSize:
                          // fixedSize: MaterialStateProperty.all(Size(100, 50)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(0),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: Color.fromARGB(
                                  255, 94, 94, 94), // Atur warna border di sini
                              width: 1.0, // Atur lebar border di sini
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Ongoing',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                            itemCount: lettersList
                                .where((user) =>
                                    user.letterStatus == 'ongoing' &&
                                    selectedFilters!.contains(user.status))
                                .length,
                            itemBuilder: (context, index) {
                              final filteredUsers = lettersList
                                  .where((user) =>
                                      user.letterStatus == 'ongoing' &&
                                      selectedFilters!.contains(user.status))
                                  .toList();
                              final user = filteredUsers![index];
                              return mail(context, filteredUsers, index);
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              //####################################################################finished
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(11, 13, 0, 0),
                      child: ElevatedButton.icon(
                        label: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        icon: selectedFilters != null &&
                                selectedFilters!.length > 1
                            ? Text(
                                "${selectedFilters![0]}+${selectedFilters!.length - 1}",
                                style: TextStyle(color: Colors.black),
                              )
                            : selectedFilters!.isNotEmpty
                                ? Text(
                                    "${selectedFilters![0]}",
                                    style: TextStyle(color: Colors.black),
                                  )
                                : Text(
                                    'Filter',
                                    style: TextStyle(color: Colors.black),
                                  ),
                        onPressed: () async {
                          final List<String>? Filter =
                              await showDialog<List<String>>(
                            context: context,
                            builder: (BuildContext context) {
                              return FilterPopup(
                                  selectedFilters: selectedFilters);
                            },
                          );

                          // Handle selected filters here
                          if (Filter != null) {
                            setState(() {
                              selectedFilters = Filter;
                            });
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Atur radius di sini
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(
                              Size(90, 35)), // Atur ukuran di sini
                          // Atau menggunakan fixedSize:
                          // fixedSize: MaterialStateProperty.all(Size(100, 50)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(0),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: Color.fromARGB(
                                  255, 94, 94, 94), // Atur warna border di sini
                              width: 1.0, // Atur lebar border di sini
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Finished',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                          itemCount: lettersList
                              .where((user) =>
                                  user.progres == 'Finished' &&
                                  selectedFilters!.contains(user.status))
                              .length,
                          itemBuilder: (context, index) {
                            final filteredUsers = lettersList
                                .where((user) =>
                                    user.progres == 'Finished' &&
                                    selectedFilters!.contains(user.status))
                                .toList();
                            final user = filteredUsers![index];
                            return Dismissible(
                                key: Key(filteredUsers![index]
                                    .name), // Gunakan nilai yang unik sebagai key
                                direction: DismissDirection
                                    .startToEnd, // Slide dari kiri ke kanan
                                background: Container(
                                  color: Colors.red,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.delete),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.red,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.delete),
                                ),
                                onDismissed: (direction) {
                                  // Aksi ketika item di-slide
                                  setState(() {
                                    // Hapus item dari daftar
                                    lettersList.remove(user);
                                  });
                                },
                                child: mail(context, filteredUsers, index));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //##################################################################cancelled
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(11, 13, 0, 0),
                      child: ElevatedButton.icon(
                        label: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        icon: selectedFilters != null &&
                                selectedFilters!.length > 1
                            ? Text(
                                "${selectedFilters![0]}+${selectedFilters!.length - 1}",
                                style: TextStyle(color: Colors.black),
                              )
                            : selectedFilters!.isNotEmpty
                                ? Text(
                                    "${selectedFilters![0]}",
                                    style: TextStyle(color: Colors.black),
                                  )
                                : Text(
                                    'Filter',
                                    style: TextStyle(color: Colors.black),
                                  ),
                        onPressed: () async {
                          final List<String>? Filter =
                              await showDialog<List<String>>(
                            context: context,
                            builder: (BuildContext context) {
                              return FilterPopup(
                                  selectedFilters: selectedFilters);
                            },
                          );

                          // Handle selected filters here
                          if (Filter != null) {
                            setState(() {
                              selectedFilters = Filter;
                            });
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Atur radius di sini
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(
                              Size(90, 35)), // Atur ukuran di sini
                          // Atau menggunakan fixedSize:
                          // fixedSize: MaterialStateProperty.all(Size(100, 50)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(0),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: Color.fromARGB(
                                  255, 94, 94, 94), // Atur warna border di sini
                              width: 1.0, // Atur lebar border di sini
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Cancelled',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                          itemCount: lettersList
                              .where((user) =>
                                  user.name == 'Cancelled' &&
                                  selectedFilters!.contains(user.status))
                              .length,
                          itemBuilder: (context, index) {
                            final filteredUsers = lettersList
                                .where((user) =>
                                    user.name == 'Cancelled' &&
                                    selectedFilters!.contains(user.status))
                                .toList();
                            final user = filteredUsers![index];
                            return Dismissible(
                                key: Key(filteredUsers[index]
                                    .name), // Gunakan nilai yang unik sebagai key
                                direction: DismissDirection
                                    .startToEnd, // Slide dari kiri ke kanan
                                background: Container(
                                  color: Colors.red,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.delete),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.red,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.delete),
                                ),
                                onDismissed: (direction) {
                                  // Aksi ketika item di-slide
                                  setState(() {
                                    // Hapus item dari daftar
                                    lettersList.remove(user);
                                  });
                                },
                                child: mail(context, filteredUsers, index));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // bottomNavigationBar: ConvexAppBar(
          //     // initialActiveIndex: _selectedIndex,
          //     controller: _convexTabController,
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
          //         // Navigator.push(
          //         //   context,
          //         //   MaterialPageRoute(builder: (context) => HistoryPage()),
          //         // );
          //       } else {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => ProfilePageWidget()),
          //         );
          //       }
          //     }),
        ));
  }
}

mail(BuildContext context, List<MailSent>? _data, int index) {
  final prov = Provider.of<Settings_provider>(context);
  return InkWell(
    onTap: () {
      // Tambahkan logika yang ingin dilakukan saat card diklik di sini
      print('Card clicked: ${_data![index].name}');
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 94,
      child: Card(
        color: prov.enableDarkMode == true ? Colors.black : Colors.white,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue,
                  child: Text(
                    _data![index].name[0].toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // color: Colors.red,
                    width: 200,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      _data![index].name.toString(),
                      style: TextStyle(
                          color: prov.enableDarkMode == true
                              ? Colors.white
                              : Colors.black,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      DateFormat('d-MMM')
                          .format(_data[index].tgl as DateTime)
                          .toString(),
                      style: TextStyle(
                          color: prov.enableDarkMode == true
                              ? Colors.white
                              : Colors.black,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        // color: Colors.blue,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          '${_data[index].Subject.toString()}',
                          style: TextStyle(
                            color: prov.enableDarkMode == true
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text(
                          overflow: TextOverflow.ellipsis,

                          '${_data[index].status.toString()}', // Teks urgent disini
                          style: TextStyle(
                            color: prov.enableDarkMode == true
                                ? Colors.white
                                : Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 9), // Jarak antara baris pertama dan kedua
                  LinearProgressIndicator(
                    value: 1,
                    backgroundColor: Colors.red[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.green, // Warna biru untuk yang lainnya
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Function untuk menghitung nilai progress
double _calculateProgress(String progress) {
  switch (progress) {
    case 'Pending':
      return 0.2; // Contoh nilai untuk 'Pending'
    case 'Finished':
      return 1.0; // Contoh nilai untuk 'Finished'
    case 'Cancelled':
      return 0.5; // Contoh nilai untuk 'Cancelled'
    default:
      return 0.0;
  }
}

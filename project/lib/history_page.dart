import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/home_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:project/filterpopup.dart'; // Sesuaikan dengan lokasi FilterPopup

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 1;
  List<String>? selectedFilters = ['Urgent', 'Regular'];
  List<Map<String, dynamic>> _allusers = [
    {
      "name": "andy",
      "Subject": "Surat Pengunduran Diri",
      "tgl": "Apr 17",
      "status": "Regular",
      "progres": "Pending"
    },
    {
      "name": "Devon",
      "Subject": "Surat Pengajuan Cuti",
      "tgl": "Apr 18",
      "status": "Regular",
      "progres": "Pending"
    },
    {
      "name": "Chris",
      "Subject": "Surat Pengajuan Pembelian Unit",
      "tgl": "Apr 19",
      "status": "Urgent",
      "progres": "Finished"
    },
    {
      "name": "Jerry",
      "Subject": "Surat Pengajuan Cuti",
      "tgl": "Apr 18",
      "status": "Regular",
      "progres": "Cancelled"
    },
    {
      "name": "Jerry W",
      "Subject": "Surat Pengajuan Pembelian Unit",
      "tgl": "Apr 19",
      "status": "Urgent",
      "progres": "Pending"
    },
    {
      "name": "Hadron",
      "Subject": "Surat Pengajuan Cuti",
      "tgl": "Apr 18",
      "status": "Regular",
      "progres": "Finished"
    },
    {
      "name": "Lina ",
      "Subject": "Surat Pengajuan Pembelian Unit",
      "tgl": "Apr 19",
      "status": "Urgent",
      "progres": "Pending"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'History',
              style: TextStyle(fontWeight: FontWeight.bold),
            ), // Judul AppBar
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Pending',
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
            backgroundColor: Colors.white, // Warna latar belakang AppBar
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
                        'Pending',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: _allusers
                              .where((user) =>
                                  user['progres'] == 'Pending' &&
                                  selectedFilters!.contains(user['status']))
                              .length,
                          itemBuilder: (context, index) {
                            final filteredUsers = _allusers
                                .where((user) =>
                                    user['progres'] == 'Pending' &&
                                    selectedFilters!.contains(user['status']))
                                .toList();
                            final user = filteredUsers[index];
                            return InkWell(
                              onTap: () {
                                // Tambahkan logika yang ingin dilakukan saat card diklik di sini
                                print(
                                    'Card clicked: ${filteredUsers[index]['name']}');
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                height: 94,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        leading: Container(
                                          padding: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                          ),
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.blue,
                                            child: Text(
                                              filteredUsers[index]['name'][0]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              filteredUsers[index]['name'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              _allusers[index]
                                                  ['tgl'], // Tanggal disini
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${filteredUsers[index]["Subject"].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  '${filteredUsers[index]["status"].toString()}', // Teks urgent disini
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    9), // Jarak antara baris pertama dan kedua
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.green,
                                                    height: 2.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.red,
                                                    height: 2.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.black,
                                                    height: 2.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
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
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _allusers
                            .where((user) =>
                                user['progres'] == 'Finished' &&
                                selectedFilters!.contains(user['status']))
                            .length,
                        itemBuilder: (context, index) {
                          final filteredUsers = _allusers
                              .where((user) =>
                                  user['progres'] == 'Finished' &&
                                  selectedFilters!.contains(user['status']))
                              .toList();
                          final user = filteredUsers[index];
                          return Dismissible(
                            key: Key(filteredUsers[index][
                                'name']), // Gunakan nilai yang unik sebagai key
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
                                _allusers.remove(user);
                              });
                            },
                            child: InkWell(
                              onTap: () {
                                // Tambahkan logika yang ingin dilakukan saat card diklik di sini
                                print(
                                    'Card clicked: ${filteredUsers[index]['name']}');
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                height: 94,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        leading: Container(
                                          padding: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                          ),
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.blue,
                                            child: Text(
                                              filteredUsers[index]['name'][0]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              filteredUsers[index]['name'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              _allusers[index]
                                                  ['tgl'], // Tanggal disini
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${filteredUsers[index]["Subject"].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  '${filteredUsers[index]["status"].toString()}', // Teks urgent disini
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    9), // Jarak antara baris pertama dan kedua
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.green,
                                                    height: 2.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.red,
                                                    height: 2.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.black,
                                                    height: 2.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _allusers
                            .where((user) =>
                                user['progres'] == 'Cancelled' &&
                                selectedFilters!.contains(user['status']))
                            .length,
                        itemBuilder: (context, index) {
                          final filteredUsers = _allusers
                              .where((user) =>
                                  user['progres'] == 'Cancelled' &&
                                  selectedFilters!.contains(user['status']))
                              .toList();
                          final user = filteredUsers[index];
                          return Dismissible(
                            key: Key(filteredUsers[index][
                                'name']), // Gunakan nilai yang unik sebagai key
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
                                _allusers.remove(user);
                              });
                            },
                            child: InkWell(
                              onTap: () {
                                // Tambahkan logika yang ingin dilakukan saat card diklik di sini
                                print(
                                    'Card clicked: ${filteredUsers[index]['name']}');
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                height: 94,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        leading: Container(
                                          padding: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                          ),
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.blue,
                                            child: Text(
                                              filteredUsers[index]['name'][0]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              filteredUsers[index]['name'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              _allusers[index]
                                                  ['tgl'], // Tanggal disini
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${filteredUsers[index]["Subject"].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  '${filteredUsers[index]["status"].toString()}', // Teks urgent disini
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    9), // Jarak antara baris pertama dan kedua
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.green,
                                                    height: 2.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.red,
                                                    height: 2.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.black,
                                                    height: 2.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xff6200ee),
            unselectedItemColor: const Color(0xff757575),
            onTap: (index) {
              if (index == 0) {
// mai page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else if (index == 1) {
                //historypage
              } else if (index == 2) {
// profile page
              }
            },
            items: [
              _navBarItems[0], // History
              _navBarItems[1], // Mail
              _navBarItems[2], // Profile
            ],
          ),
        ));
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.mail),
    title: const Text("Mail"),
    selectedColor: Colors.red, // Ubah warna sesuai preferensi Anda
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.history),
    title: const Text("History"),
    selectedColor: Colors.blue, // Ubah warna sesuai preferensi Anda
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.teal, // Ubah warna sesuai preferensi Anda
  ),
];

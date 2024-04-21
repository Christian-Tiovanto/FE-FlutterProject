import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/history_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:project/filterpopup.dart'; // Sesuaikan dengan lokasi FilterPopup

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> _allusers = [
    {"name": "andy", "age": "Surat Pengunduran Diri"},
    {"name": "wandy", "age": "Surat Pengajuan Cuti"},
    {"name": "wandy", "age": "Surat Pengajuan Cuti"},
    {"name": "wandy", "age": "Surat Pengajuan Cuti"},
    {"name": "wandy", "age": "Surat Pengajuan Cuti"},
    {"name": "wandy", "age": "Surat Pengajuan Cuti"},
    {"name": "wandy", "age": "Surat Pengajuan Cuti"},
    {"name": "wandy", "age": "Surat Pengajuan Cuti"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            kToolbarHeight + 20), // 50 adalah tinggi SearchBar
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SizedBox(
            height: 120, // Tinggi AppBar diatur disini
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SearchBar(),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(11, 0, 0, 0),
            child: ElevatedButton.icon(
              label: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              icon: Text(
                'Filter',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                final List<String>? selectedFilters =
                    await showDialog<List<String>>(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterPopup();
                  },
                );

                // Handle selected filters here
                if (selectedFilters != null) {
                  print('Selected filters: $selectedFilters');
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Atur radius di sini
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                    Size(90, 35)), // Atur ukuran di sini
                // Atau menggunakan fixedSize:
                // fixedSize: MaterialStateProperty.all(Size(100, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
              'Mailbox',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _allusers.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  // Tambahkan logika yang ingin dilakukan saat card diklik di sini
                  print('Card clicked: ${_allusers[index]['name']}');
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
                                'B',
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
                              Text(
                                _allusers[index]['name'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              Text(
                                'APR 17', // Tanggal disini
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${_allusers[index]["age"].toString()}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'URGENT', // Teks urgent disini
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
                                mainAxisAlignment: MainAxisAlignment.end,
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
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10.0,
        label: const Text("Pengajuan"),
        icon: Icon(Icons.edit),
        onPressed: () {},
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
// mai page
          } else if (index == 1) {
            //historypage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage()),
            );
          } else if (index == 2) {
// profile page
          }
        },
        items: [
          _navBarItems[0],
          _navBarItems[1],
          _navBarItems[2],
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search In Mail',
          contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white), // Set border default
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.white,
            ), // Set border saat text field aktif
          ),
          filled: true,
          fillColor: Colors.grey[200], // Warna latar belakang abu
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue,
              child: Text(
                'AB', // Ganti dengan inisial pengguna
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

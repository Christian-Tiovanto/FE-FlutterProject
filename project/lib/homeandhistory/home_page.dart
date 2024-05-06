import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:project/homeandhistory/history_page.dart';
import 'package:project/jerrywijaya/profile.dart';
import 'package:project/tian/PengajuanSurat.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:project/homeandhistory/filterpopup.dart'; // Sesuaikan dengan lokasi FilterPopup

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String>? selectedFilters = ['Urgent', 'Regular'];
  final SearchController controller = SearchController();

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

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _allusers.add(
        {
          "name": "Ayu ",
          "Subject": "Surat Pengajuan Pembelian Unit",
          "tgl": "Apr 25",
          "status": "Urgent",
          "progres": "Pending"
        },
      );
    });
  }

  List<String> searchhistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) => [
          SliverAppBar(
            //backgroundColor: Colors.white,

            automaticallyImplyLeading: false,
            expandedHeight: 75.0,
            pinned: false,
            snap: true,
            floating: true,
            flexibleSpace: SizedBox(
              height: 120, // Tinggi AppBar diatur disini
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    SearchAnchor(
                      viewSurfaceTintColor: Colors.white,
                      // MENGUBAH BACKGROUND COLOR
                      isFullScreen: true,
                      //viewBackgroundColor: Colors.white,
                      searchController: controller,
                      viewHintText: 'Search in Mail',
                      viewTrailing: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              searchhistory.add(controller.text);
                              searchhistory =
                                  searchhistory.reversed.toSet().toList();
                              controller.closeView(controller.text);
                            });
                          },
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.clear();
                            },
                            icon: const Icon(Icons.clear))
                      ],
                      builder: (context, controller) {
                        return SearchBar(
                          controller: controller,
                          leading: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                          //untuk menambahkan icon di samping kanan search bar
                          /*
                          trailing: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.mic),
                            ),
                          ],
                          */
                          hintText: 'Search in Mail',
                          onTap: () => controller.openView(),
                        );
                      },
                      suggestionsBuilder: (context, controller) {
                        return [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Recent Mail Searches'),
                          ),
                          Wrap(
                            children:
                                List.generate(searchhistory.length, (index) {
                              final item = searchhistory[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ChoiceChip(
                                  side: BorderSide(color: Colors.white),
                                  label: Text(item),
                                  selected: item == controller.text,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24.0))),
                                  onSelected: (value) {
                                    controller.text = item;
                                    controller.closeView(item);
                                  },
                                ),
                              );
                            }),
                          ),
                          if (controller.text.isNotEmpty) ...[
                            const Divider(),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: _allusers
                                    .where((user) =>
                                        user['progres'] == 'Pending' &&
                                        (controller.text.isEmpty ||
                                            user['name']
                                                .toString()
                                                .toLowerCase()
                                                .contains(controller.text
                                                    .toLowerCase())))
                                    .length,
                                itemBuilder: (context, index) {
                                  final filteredUsers = _allusers
                                      .where((user) =>
                                          user['progres'] == 'Pending' &&
                                          (controller.text.isEmpty ||
                                              user['name']
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(controller.text
                                                      .toLowerCase())))
                                      .toList();
                                  return InkWell(
                                    onTap: () {
                                      // Tambahkan logika yang ingin dilakukan saat card diklik di sini
                                      print(
                                          'Card clicked: ${filteredUsers[index]['name']}');
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      height: 94,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              leading: Container(
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 2),
                                                ),
                                                child: CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: Colors.blue,
                                                  child: Text(
                                                    filteredUsers[index]['name']
                                                            [0]
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    filteredUsers[index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    _allusers[index][
                                                        'tgl'], // Tanggal disini
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
                          ]
                        ];
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(11, 8, 0, 0),
                child: ElevatedButton.icon(
                  label: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  icon: selectedFilters != null && selectedFilters!.length > 1
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
                    final List<String>? Filter = await showDialog<List<String>>(
                      context: context,
                      builder: (BuildContext context) {
                        return FilterPopup(selectedFilters: selectedFilters);
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
                  'Mailbox',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )),
        ],
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
              itemCount: _allusers
                  .where((user) =>
                      user['progres'] == 'Pending' &&
                      selectedFilters!.contains(user['status']) &&
                      (controller.text.isEmpty ||
                          user['name']
                              .toString()
                              .toLowerCase()
                              .contains(controller.text.toLowerCase())))
                  .length,
              itemBuilder: (context, index) {
                final filteredUsers = _allusers
                    .where((user) =>
                        user['progres'] == 'Pending' &&
                        selectedFilters!.contains(user['status']) &&
                        (controller.text.isEmpty ||
                            user['name']
                                .toString()
                                .toLowerCase()
                                .contains(controller.text.toLowerCase())))
                    .toList();
                return InkWell(
                  onTap: () {
                    // Tambahkan logika yang ingin dilakukan saat card diklik di sini
                    print('Card clicked: ${filteredUsers[index]['name']}');
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            leading: Container(
                              padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  filteredUsers[index]['name'][0].toUpperCase(),
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
                                  filteredUsers[index]['name'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  _allusers[index]['tgl'], // Tanggal disini
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
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10.0,
        label: Text("Pengajuan"),
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PengajuanSurat()),
          );
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          if (index == 0) {
// mai page
          } else if (index == 1) {
            //historypage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePageWidget()),
            );
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

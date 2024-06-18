import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/devon/history_page.dart';
import 'package:project/jerrywijaya/profile.dart';
import 'package:project/tian/LetterContentWidget.dart';
import 'package:project/tian/PengajuanSurat.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:project/devon/filterpopup.dart'; // Sesuaikan dengan lokasi FilterPopup
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String>? selectedFilters = ['Urgent', 'Regular'];
  final SearchController controller = SearchController();

  // List<Map<String, dynamic>> LoggedInUser.MailInbox = [
  //   {
  //     "name": "andy",
  //     "Subject": "Surat Pengunduran Diri",
  //     "tgl": "Apr 17",
  //     "status": "Regular",
  //     "progres": "Pending"
  //   },
  //   {
  //     "name": "Devon",
  //     "Subject": "Surat Pengajuan Cuti",
  //     "tgl": "Apr 18",
  //     "status": "Regular",
  //     "progres": "Pending"
  //   },
  //   {
  //     "name": "Chris",
  //     "Subject": "Surat Pengajuan Pembelian Unit",
  //     "tgl": "Apr 19",
  //     "status": "Urgent",
  //     "progres": "Finished"
  //   },
  //   {
  //     "name": "Jerry",
  //     "Subject": "Surat Pengajuan Cuti",
  //     "tgl": "Apr 18",
  //     "status": "Regular",
  //     "progres": "Cancelled"
  //   },
  //   {
  //     "name": "Jerry W",
  //     "Subject": "Surat Pengajuan Pembelian Unit",
  //     "tgl": "Apr 19",
  //     "status": "Urgent",
  //     "progres": "Pending"
  //   },
  //   {
  //     "name": "Hadron",
  //     "Subject": "Surat Pengajuan Cuti",
  //     "tgl": "Apr 18",
  //     "status": "Regular",
  //     "progres": "Finished"
  //   },
  //   {
  //     "name": "Lina ",
  //     "Subject": "Surat Pengajuan Pembelian Unit",
  //     "tgl": "Apr 19",
  //     "status": "Urgent",
  //     "progres": "Pending"
  //   },
  // ];

  List<String> searchhistory = [];

  @override
  Widget build(BuildContext context) {
    final LoggedInUser = Provider.of<UserListProvider>(context).onlineusers;
    Future<void> _refresh() async {
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        LoggedInUser!.MailInbox.add(Mail(
            name: "Ayu ",
            Subject: "Surat Pengajuan Pembelian Unit",
            tgl: "Apr 25",
            status: "Urgent",
            progres: "Pending"));
      });
    }

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
                                itemCount: LoggedInUser!.MailInbox
                                    .where((user) =>
                                        user.progres == 'Pending' &&
                                        (controller.text.isEmpty ||
                                            user.name
                                                .toString()
                                                .toLowerCase()
                                                .contains(controller.text
                                                    .toLowerCase())))
                                    .length,
                                itemBuilder: (context, index) {
                                  final filteredUsers =
                                      LoggedInUser.MailInbox.where((user) =>
                                              user.progres == 'Pending' &&
                                              (controller.text.isEmpty ||
                                                  user.name
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(controller.text
                                                          .toLowerCase())))
                                          .toList();
                                  return mail(context, filteredUsers, index);
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
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                ),
              ),
            ],
          )),
        ],
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
              itemCount: LoggedInUser?.MailInbox.where((user) {
                return user.progres == 'Pending' &&
                    selectedFilters!.contains(user.status) &&
                    (controller.text.isEmpty ||
                        user.name
                            .toString()
                            .toLowerCase()
                            .contains(controller.text.toLowerCase()));
              }).length,
              itemBuilder: (context, index) {
                final filteredUsers = LoggedInUser!.MailInbox
                    .where((user) =>
                        user.progres == 'Pending' &&
                        selectedFilters!.contains(user.status) &&
                        (controller.text.isEmpty ||
                            user.name
                                .toString()
                                .toLowerCase()
                                .contains(controller.text.toLowerCase())))
                    .toList();
                return mail(context, filteredUsers, index);
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey[300],
        // elevation: 10.0,
        label: Icon(Icons.edit,
            color: Theme.of(context).textTheme.bodyText2?.color),
        // icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PengajuanSurat(
                      userData: [],
                    )),
          );
        },
      ),
      //   bottomNavigationBar: ConvexAppBar(
      //       initialActiveIndex: _selectedIndex,
      //       color: Colors.white,
      //       backgroundColor: Colors.grey,
      //       items: [
      //         TabItem(icon: Icons.mail),
      //         TabItem(icon: Icons.history),
      //         TabItem(icon: Icons.person),
      //       ],
      //       onTap: (int index) {
      //         if (index == 0) {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(builder: (context) => HistoryPage()),
      //           // );
      //         } else if (index == 1) {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => HistoryPage()),
      //           );
      //         } else {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => ProfilePageWidget()),
      //           );
      //         }
      //       }),
    );
  }
}

mail(BuildContext context, List<Mail> _data, int index) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LetterContentWidget(
                    dataSurat: _data[index],
                  )));
      // Tambahkan logika yang ingin dilakukan saat card diklik di sini
      // print('Card clicked: ${_data[index]['name']}');
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
                    _data[index].name[0].toUpperCase(),
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
                      _data[index].name.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Container(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      _data[index].tgl.toString(), // Tanggal disini
                      style: TextStyle(color: Colors.black, fontSize: 13),
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
                            color: Colors.black,
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
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 9), // Jarak antara baris pertama dan kedua
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/hadron/tesdate.dart';
import 'package:project/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:project/Devon/filterpopup.dart'; // Sesuaikan dengan lokasi FilterPopup

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

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
      final results = await LetterService().getUserCreatedLetter("finished");
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

    Future<void> refresh() async {
      await Future.delayed(const Duration(seconds: 1));
      getUserLetter();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(11, 13, 0, 0),
                          child: ElevatedButton.icon(
                            label: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            icon: selectedFilters != null &&
                                    selectedFilters!.length > 1
                                ? Text(
                                    "${selectedFilters![0]}+${selectedFilters!.length - 1}",
                                    style: const TextStyle(color: Colors.black),
                                  )
                                : selectedFilters!.isNotEmpty
                                    ? Text(
                                        selectedFilters![0],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )
                                    : const Text(
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Atur radius di sini
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(90, 35)), // Atur ukuran di sini
                              // Atau menggunakan fixedSize:
                              // fixedSize: MaterialStateProperty.all(Size(100, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(0),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                  color: Color.fromARGB(255, 94, 94,
                                      94), // Atur warna border di sini
                                  width: 1.0, // Atur lebar border di sini
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(11, 13, 0, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              final DateTimeRange? picked =
                                  await showDialog<DateTimeRange?>(
                                context: context,
                                builder: (BuildContext context) {
                                  return DateRangePickerWidget();
                                },
                              );

                              if (picked != null) {
                                // Lakukan sesuatu dengan tanggal yang dipilih
                                print(
                                    'Start Date: ${picked.start}, End Date: ${picked.end}');
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Atur radius di sini
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(132, 26)), // Atur ukuran di sini
                              // Atau menggunakan fixedSize:
                              fixedSize: MaterialStateProperty.all(
                                  const Size(132, 26)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(0),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                  color: Color.fromARGB(255, 94, 94,
                                      94), // Atur warna border di sini
                                  width: 1.0, // Atur lebar border di sini
                                ),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Date Filter',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                    width: 4), // Jarak antara teks dan ikon
                                Icon(Icons.calendar_today,
                                    size: 15,
                                    color: Colors
                                        .black), // Ganti dengan ikon yang diinginkan
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Ongoing',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: refresh,
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
                              final user = filteredUsers[index];
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(11, 13, 0, 0),
                          child: ElevatedButton.icon(
                            label: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            icon: selectedFilters != null &&
                                    selectedFilters!.length > 1
                                ? Text(
                                    "${selectedFilters![0]}+${selectedFilters!.length - 1}",
                                    style: const TextStyle(color: Colors.black),
                                  )
                                : selectedFilters!.isNotEmpty
                                    ? Text(
                                        selectedFilters![0],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )
                                    : const Text(
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Atur radius di sini
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(90, 35)), // Atur ukuran di sini
                              // Atau menggunakan fixedSize:
                              // fixedSize: MaterialStateProperty.all(Size(100, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(0),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                  color: Color.fromARGB(255, 94, 94,
                                      94), // Atur warna border di sini
                                  width: 1.0, // Atur lebar border di sini
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final DateTimeRange? picked =
                                await showDialog<DateTimeRange?>(
                              context: context,
                              builder: (BuildContext context) {
                                return DateRangePickerWidget();
                              },
                            );

                            if (picked != null) {
                              // Lakukan sesuatu dengan tanggal yang dipilih
                              print(
                                  'Start Date: ${picked.start}, End Date: ${picked.end}');
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Atur radius di sini
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                                const Size(132, 26)), // Atur ukuran di sini
                            // Atau menggunakan fixedSize:
                            fixedSize:
                                MaterialStateProperty.all(const Size(132, 26)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            elevation: MaterialStateProperty.all<double>(0),
                            side: MaterialStateProperty.all<BorderSide>(
                              const BorderSide(
                                color: Color.fromARGB(255, 94, 94,
                                    94), // Atur warna border di sini
                                width: 1.0, // Atur lebar border di sini
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Date Filter',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(width: 4), // Jarak antara teks dan ikon
                              Icon(Icons.calendar_today,
                                  size: 15,
                                  color: Colors
                                      .black), // Ganti dengan ikon yang diinginkan
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Finished',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                          itemCount: lettersList.where((user) {
                            print('user di finished');
                            print(user);
                            return user.letterStatus == 'finished' &&
                                selectedFilters!.contains(user.status);
                          }).length,
                          itemBuilder: (context, index) {
                            final filteredUsers = lettersList
                                .where((user) =>
                                    user.letterStatus == 'finished' &&
                                    selectedFilters!.contains(user.status))
                                .toList();
                            final user = filteredUsers[index];
                            return Dismissible(
                                key: Key(filteredUsers[index]
                                    .name), // Gunakan nilai yang unik sebagai key
                                direction: DismissDirection
                                    .startToEnd, // Slide dari kiri ke kanan
                                background: Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  alignment: Alignment.centerLeft,
                                  child: const Icon(Icons.delete),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(Icons.delete),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(11, 13, 0, 0),
                          child: ElevatedButton.icon(
                            label: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            icon: selectedFilters != null &&
                                    selectedFilters!.length > 1
                                ? Text(
                                    "${selectedFilters![0]}+${selectedFilters!.length - 1}",
                                    style: const TextStyle(color: Colors.black),
                                  )
                                : selectedFilters!.isNotEmpty
                                    ? Text(
                                        selectedFilters![0],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )
                                    : const Text(
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Atur radius di sini
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(90, 35)), // Atur ukuran di sini
                              // Atau menggunakan fixedSize:
                              // fixedSize: MaterialStateProperty.all(Size(100, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(0),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                  color: Color.fromARGB(255, 94, 94,
                                      94), // Atur warna border di sini
                                  width: 1.0, // Atur lebar border di sini
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(11, 13, 0, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              final DateTimeRange? picked =
                                  await showDialog<DateTimeRange?>(
                                context: context,
                                builder: (BuildContext context) {
                                  return DateRangePickerWidget();
                                },
                              );

                              if (picked != null) {
                                // Lakukan sesuatu dengan tanggal yang dipilih
                                print(
                                    'Start Date: ${picked.start}, End Date: ${picked.end}');
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Atur radius di sini
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(132, 26)), // Atur ukuran di sini
                              // Atau menggunakan fixedSize:
                              fixedSize: MaterialStateProperty.all(
                                  const Size(132, 26)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(0),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                  color: Color.fromARGB(255, 94, 94,
                                      94), // Atur warna border di sini
                                  width: 1.0, // Atur lebar border di sini
                                ),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Date Filter',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                    width: 4), // Jarak antara teks dan ikon
                                Icon(Icons.calendar_today,
                                    size: 15,
                                    color: Colors
                                        .black), // Ganti dengan ikon yang diinginkan
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Cancelled',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: refresh,
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
                            final user = filteredUsers[index];
                            return Dismissible(
                                key: Key(filteredUsers[index]
                                    .name), // Gunakan nilai yang unik sebagai key
                                direction: DismissDirection
                                    .startToEnd, // Slide dari kiri ke kanan
                                background: Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  alignment: Alignment.centerLeft,
                                  child: const Icon(Icons.delete),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(Icons.delete),
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

mail(BuildContext context, List<MailSent>? data, int index) {
  final prov = Provider.of<Settings_provider>(context);
  return InkWell(
    onTap: () {
      // Tambahkan logika yang ingin dilakukan saat card diklik di sini
      print('Card clicked: ${data[index].name}');
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue,
                  child: Text(
                    data![index].name[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    // color: Colors.red,
                    width: 200,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      data[index].name.toString(),
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
                      DateFormat('d-MMM').format(data[index].tgl).toString(),
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
                      SizedBox(
                        width: 200,
                        // color: Colors.blue,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          data[index].Subject.toString(),
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

                          data[index].status.toString(), // Teks urgent disini
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
                  const SizedBox(
                      height: 9), // Jarak antara baris pertama dan kedua
                  LinearProgressIndicator(
                    value: data[index].progresValue,
                    backgroundColor: Colors.red[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
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

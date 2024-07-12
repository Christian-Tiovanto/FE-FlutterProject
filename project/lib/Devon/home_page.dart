import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:project/Devon/filterpopup.dart';
import 'package:project/Devon/providers.dart';
import 'package:project/hadron/tesdate.dart';
import 'package:project/jerrywijaya/profile.dart';
import 'package:project/services/user_services.dart';
import 'package:project/tian/LetterContentWidget.dart';
import 'package:project/tian/PengajuanSurat.dart';
import 'package:intl/intl.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 0;
  List<String>? selectedFilters = ['Urgent', 'Regular'];
  List<Mail> lettersList = [];
  bool resultFetched = false;
  final SearchController controller = SearchController();
  List<String> searchhistory = [];

  void getUserLetter() async {
    try {
      final results = await LetterService().getUserLetter();

      setState(() {
        lettersList = results;
        resultFetched = true;
        print('lettersList');
      });
    } catch (error) {
      print("error di home");
      print(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLetter();
  }

  Future<void> _refresh() async {
    getUserLetter();
  }

  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Settings_provider>(context);
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
                    const SizedBox(
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
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Recent Mail Searches',
                              style: TextStyle(
                                color: prov.enableDarkMode == true
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Wrap(
                            children:
                                List.generate(searchhistory.length, (index) {
                              final item = searchhistory[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ChoiceChip(
                                  side: const BorderSide(color: Colors.white),
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
                                itemCount: lettersList
                                    .where((user) =>
                                        user.progres == 'request' &&
                                        (controller.text.isEmpty ||
                                            user.name
                                                .toString()
                                                .toLowerCase()
                                                .contains(controller.text
                                                    .toLowerCase())))
                                    .length,
                                itemBuilder: (context, index) {
                                  final filteredUsers = lettersList
                                      .where((user) =>
                                          user.progres == 'request' &&
                                          (controller.text.isEmpty ||
                                              user.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(controller.text
                                                      .toLowerCase())))
                                      .toList();
                                  return mail(
                                      context, filteredUsers, index, _refresh);
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
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(11, 8, 0, 0),
                child: ElevatedButton.icon(
                  label: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  icon: selectedFilters != null && selectedFilters!.length > 1
                      ? Text(
                          "${selectedFilters![0]}+${selectedFilters!.length - 1}",
                          style: const TextStyle(color: Colors.black),
                        )
                      : selectedFilters!.isNotEmpty
                          ? Text(
                              selectedFilters![0],
                              style: const TextStyle(color: Colors.black),
                            )
                          : const Text(
                              'Filter',
                              style: TextStyle(color: Colors.black),
                            ),
                  onPressed: () async {
                    final List<String>? typeFilter =
                        await showDialog<List<String>>(
                      context: context,
                      builder: (BuildContext context) {
                        return FilterPopup(selectedFilters: selectedFilters);
                      },
                    );

                    // Handle selected filters here
                    if (typeFilter != null) {
                      setState(() {
                        selectedFilters = typeFilter;
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
                        const Size(90, 35)), // Atur ukuran di sini
                    // Atau menggunakan fixedSize:
                    // fixedSize: MaterialStateProperty.all(Size(100, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStateProperty.all<double>(0),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Color.fromARGB(
                            255, 94, 94, 94), // Atur warna border di sini
                        width: 1.0, // Atur lebar border di sini
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final DateTimeRange? dateFilter =
                        await showModalBottomSheet<DateTimeRange?>(
                      context: context,
                      builder: (BuildContext context) {
                        return DateRangePickerWidget();
                      },
                    );

                    if (dateFilter != null) {
                      // Lakukan sesuatu dengan tanggal yang dipilih
                      setState(() {
                        startDate = dateFilter.start;
                        endDate = dateFilter.end;
                        lettersList = lettersList.where((e) {
                          return e.dateCreated.isBefore(endDate!) &&
                              e.dateCreated.isAfter(startDate!);
                        }).toList();
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
                        const Size(140, 35)), // Atur ukuran di sini
                    // Atau menggunakan fixedSize:
                    // fixedSize: MaterialStateProperty.all(Size(130, 9)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStateProperty.all<double>(0),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Color.fromARGB(
                            255, 94, 94, 94), // Atur warna border di sini
                        width: 1.0, // Atur lebar border di sini
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        startDate != null && endDate != null
                            ? '${DateFormat('dd mm yy').format(startDate!)} - ${DateFormat('dd mm yy').format(endDate!)}'
                            : 'Date Filter',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 5), // Jarak antara teks dan ikon
                      const Icon(Icons.calendar_today,
                          size: 15,
                          color: Colors
                              .black), // Ganti dengan ikon yang diinginkan
                    ],
                  ),
                ),
              ),
            ],
          )),
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Mailbox',
                  style: TextStyle(
                    fontSize: 15,
                    color: prov.enableDarkMode == true
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ],
          )),
        ],
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
              itemCount: lettersList.where((user) {
                DateTime userdate = user.dateCreated;

                return user.progres == 'request' &&
                    selectedFilters!.contains(user.status) &&
                    // userdate.isAfter(startDate.subtract(Duration(days: 1))) &&
                    // userdate.isBefore(endDate.add(Duration(days: 1))) &&
                    (controller.text.isEmpty ||
                        user.name
                            .toString()
                            .toLowerCase()
                            .contains(controller.text.toLowerCase()));
              }).length,
              itemBuilder: (context, index) {
                final filteredUsers = lettersList.where((user) {
                  DateTime userdate = user.dateCreated;
                  return user.progres == 'request' &&
                      selectedFilters!.contains(user.status) &&
                      // userdate.isAfter(startDate.subtract(Duration(days: 1))) &&
                      // userdate.isBefore(endDate.add(Duration(days: 1))) &&
                      (controller.text.isEmpty ||
                          user.name
                              .toString()
                              .toLowerCase()
                              .contains(controller.text.toLowerCase()));
                }).toList();
                return mail(context, filteredUsers, index, _refresh);
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey[300],
        // elevation: 10.0,
        label: Icon(Icons.edit,
            color: Theme.of(context).textTheme.bodyMedium!.color),
        // icon: Icon(Icons.edit),
        onPressed: () async {
          final response = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PengajuanSurat(),
            ),
          );

          print('response');
          print(response);
          if (response == "OK") {
            _refresh();
            setState(() {});
          }
        },
      ),
    );
  }
}

mail(BuildContext context, List<Mail> data, int index, refreshFunction) {
  final prov = Provider.of<Settings_provider>(context);
  print('_data');
  print(data);
  // return Text("ea");
  return InkWell(
    onTap: () async {
      final response = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LetterContentWidget(
                    dataSurat: data[index],
                  )));
      if (response == "OK") {
        refreshFunction();
      }
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height:
          120, // Meningkatkan tinggi kontainer untuk penambahan LinearProgressIndicator
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
                    data[index].name[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
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
                      DateFormat('d-MMM')
                          .format(data[index].dateCreated)
                          .toString(), // Tanggal disini
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
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          data[index].subject.toString(),
                          style: TextStyle(
                            color: prov.enableDarkMode == true
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: data[index].progresValue.toDouble(),
                          backgroundColor: Colors.red,
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.green),
                        ),
                      )
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

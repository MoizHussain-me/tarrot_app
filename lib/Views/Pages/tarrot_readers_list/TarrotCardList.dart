// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tarrot_app/Model/random_card.dart';
import 'package:tarrot_app/Model/readers_model.dart';
import 'package:tarrot_app/ViewModel/dashboard_viewmodel.dart';

import 'util/tarrot_card_readers_card.dart';

class TarrotCardList extends StatefulWidget {
  const TarrotCardList({super.key});

  @override
  State<TarrotCardList> createState() => _TarrotCardListState();
}

class _TarrotCardListState extends State<TarrotCardList> {
  DashboardViewModel dashViewModel = DashboardViewModel();
  Future<void> fetchAllLists() async {
    List<ReadersModel> readers = await dashViewModel.getAllReaders();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchAllLists();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 50,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       'Career',
              //       'English',
              //       'Online',
              //       'Highest to Lowest',
              //       'Lowest to highest'
              //     ]
              //         .map(
              //           (e) => Container(
              //             margin: const EdgeInsets.symmetric(
              //                 vertical: 8.0, horizontal: 10.0),
              //             child: OutlinedButton(
              //               style: OutlinedButton.styleFrom(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(30),
              //                 ),
              //                 backgroundColor: Colors.white,
              //                 elevation: 5,
              //                 shadowColor: Colors.grey,
              //               ),
              //               onPressed: () {},
              //               child: Text(
              //                 e,
              //                 style: const TextStyle(color: Colors.black),
              //               ),
              //             ),
              //           ),
              //         )
              //         .toList(),
              //   ),
              // ),

              FutureBuilder<List<ReadersModel>>(
                future: dashViewModel.getAllReaders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Readers found'));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        ReadersModel reader = snapshot.data![index];
                        return TarrotCardReadersCard(reader);
                      },
                    );
                  }
                },
              ),

              // TarrotCardReadersCard(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:core';
import 'package:donor/const/blood_group.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor/pages/home/method_home.dart';
import 'package:donor/widgets/card.dart';
import 'package:donor/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PublicHome extends StatefulWidget {
  const PublicHome({super.key});

  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  TextEditingController donorSearch = TextEditingController();
  String? selectedGroup;
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
      .instance
      .collection('donors')
      .where('donorActive', isEqualTo: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Icon(
          Icons.bloodtype,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: FaIcon(FontAwesomeIcons.handshakeAngle),
        label: Text('Make a Request'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 600
                  ? 600
                  : MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Active Donors',
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      label: Row(
                        children: [
                          Icon(
                            Icons.bloodtype,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          Text('Blood Group'),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    items: bloodGroups.map((String group) {
                      return DropdownMenuItem(value: group, child: Text(group));
                    }).toList(),
                    onChanged: (value) {
                      selectedGroup = value;
                      setState(() {
                        stream = FirebaseFirestore.instance
                            .collection('donors')
                            .where('donorActive', isEqualTo: true)
                            .where('donorBloodGroup', isEqualTo: selectedGroup)
                            .snapshots();
                      });
                    },
                  ),
                  SizedBox(height: 6),
                  donorTextField(
                    context: context,
                    icon: Icons.search,
                    keyboardType: TextInputType.text,
                    controller: donorSearch,
                    labelText: 'Search Location',
                    obscureText: false,
                  ),

                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Timestamp timestamp =
                              snapshot.data!.docs[index]['donotRegistereAt'];
                          DateTime date = timestamp.toDate();

                          return BloodDonorCard(
                            bloodGroup:
                                snapshot.data!.docs[index]['donorBloodGroup'],
                            donorName: snapshot.data!.docs[index]['donorName'],
                            donorPlace:
                                snapshot.data!.docs[index]['donorLocation'],
                            donorStatus:
                                snapshot.data!.docs[index]['donorActive']
                                        .toString() ==
                                    "true"
                                ? "Active"
                                : "Inactive",
                            onCallPressed: () {
                              makePhoneCall(
                                snapshot.data!.docs[index]['donorPhone'],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

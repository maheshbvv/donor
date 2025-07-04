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
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 6),
                  TextField(
                    controller: donorSearch,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          donorSearch.clear();
                          setState(() {});
                        },
                        icon: Icon(Icons.clear),
                      ),
                      labelText: 'Search by Location',
                      labelStyle: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),

                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('donors')
                        .where('donorActive', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final allDocs = snapshot.data!.docs;

                      // filter by selected blood group and search
                      final filteredDocs = allDocs.where((doc) {
                        final bloodGroupMatches =
                            selectedGroup == null ||
                            doc['donorBloodGroup'] == selectedGroup;
                        final locationMatches =
                            donorSearch.text.isEmpty ||
                            doc['donorLocation']
                                .toString()
                                .toLowerCase()
                                .contains(donorSearch.text.toLowerCase());

                        return bloodGroupMatches && locationMatches;
                      }).toList();

                      if (filteredDocs.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No matching donors found'),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredDocs.length,
                        itemBuilder: (context, index) {
                          final donor = filteredDocs[index];
                          return BloodDonorCard(
                            bloodGroup: donor['donorBloodGroup'],
                            donorName: donor['donorName'],
                            donorPlace: donor['donorLocation'],
                            donorStatus:
                                donor['donorActive'].toString() == "true"
                                ? "Active"
                                : "Inactive",
                            onCallPressed: () {
                              makePhoneCall(donor['donorPhone']);
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

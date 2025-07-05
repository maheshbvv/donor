import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor/pages/home/method_home.dart';
import 'package:donor/widgets/request_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 600
                ? 600
                : MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  'Recent Requests',
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('requests')
                      .where(
                        'selectedDate',
                        isGreaterThanOrEqualTo: DateTime.now(),
                      )
                      .orderBy('selectedDate', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final allDocs = snapshot.data!.docs;

                    if (allDocs.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('No new requests.'),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allDocs.length,
                      itemBuilder: (context, index) {
                        final requests = allDocs[index];
                        return BloodRequestCard(
                          bloodGroup: requests['bloodGroup'],
                          hospitalName: requests['hospitalName'],
                          patientName: requests['patientName'],
                          contactPerson: requests['contactPerson'],
                          contactPhoneNumber: requests['contactPhone'],
                          requiredDate: (requests['selectedDate'] as Timestamp)
                              .toDate(),
                          onCallPressed: () {
                            makePhoneCall(requests['contactPhone']);
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
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Donors extends StatefulWidget {
  const Donors({super.key});

  @override
  State<Donors> createState() => _DonorsState();
}

class _DonorsState extends State<Donors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Donors')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('donors')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 20,
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Phone')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Blood Group')),
                          DataColumn(label: Text('Location')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;

                          return DataRow(
                            cells: [
                              DataCell(Text(data['donorName'] ?? '')),
                              DataCell(Text(data['donorPhone'] ?? '')),
                              DataCell(Text(data['donorEmail'] ?? '')),
                              DataCell(Text(data['donorBloodGroup'] ?? '')),
                              DataCell(Text(data['donorLocation'] ?? '')),
                              DataCell(
                                Text(
                                  data['donorActive'] == true
                                      ? 'Active'
                                      : 'Inactive',
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

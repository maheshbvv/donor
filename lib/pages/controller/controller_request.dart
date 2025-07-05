import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Requests')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('requests')
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
                          DataColumn(label: Text('Patient Name')),
                          DataColumn(label: Text('Contact Person')),
                          DataColumn(label: Text('Contact Phone')),
                          DataColumn(label: Text('Blood Group')),
                          DataColumn(label: Text('Location')),
                          DataColumn(label: Text('Required Date')),
                        ],
                        rows: docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;

                          return DataRow(
                            cells: [
                              DataCell(Text(data['patientName'] ?? '')),
                              DataCell(Text(data['contactPerson'] ?? '')),
                              DataCell(Text(data['contactPhone'] ?? '')),
                              DataCell(Text(data['bloodGroup'] ?? '')),
                              DataCell(Text(data['hospitalName'] ?? '')),
                              DataCell(
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(
                                        (data['selectedDate'] as Timestamp)
                                            .toDate(),
                                      )
                                      .toString(),
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

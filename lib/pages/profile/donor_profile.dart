import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor/pages/profile/method_donor.dart';
import 'package:donor/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonorProfile extends StatefulWidget {
  const DonorProfile({super.key});

  @override
  State<DonorProfile> createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  final user = FirebaseAuth.instance.currentUser;

  // Valid blood groups list
  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  // Method to validate phone number
  bool _isValidPhoneNumber(String phone) {
    // Remove all non-digit characters
    String cleanPhone = phone.replaceAll(RegExp(r'\D'), '');

    // Check if it's exactly 10 digits
    return cleanPhone.length == 10 && RegExp(r'^\d{10}$').hasMatch(cleanPhone);
  }

  // Method to validate blood group
  bool _isValidBloodGroup(String bloodGroup) {
    return bloodGroups.contains(bloodGroup.toUpperCase());
  }

  // Method to format phone number display
  // String _formatPhoneNumber(String phone) {
  //   String cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
  //   if (cleanPhone.length == 10) {
  //     return '${cleanPhone.substring(0, 3)}-${cleanPhone.substring(3, 6)}-${cleanPhone.substring(6)}';
  //   }
  //   return phone; // Return original if not 10 digits
  // }

  // Method to show edit dialog
  void _showEditDialog(String field, String currentValue, String fieldKey) {
    final TextEditingController controller = TextEditingController(
      text: currentValue,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: field,
                  border: const OutlineInputBorder(),
                  hintText: fieldKey == 'donorPhone'
                      ? 'Enter 10-digit phone number'
                      : fieldKey == 'donorBloodGroup'
                      ? 'Enter blood group (A+, A-, B+, B-, AB+, AB-, O+, O-)'
                      : null,
                ),
                keyboardType: fieldKey == 'donorPhone'
                    ? TextInputType.phone
                    : TextInputType.text,
                maxLength: fieldKey == 'donorPhone' ? 10 : null,
              ),
              // Show valid blood groups for blood group field
              if (fieldKey == 'donorBloodGroup') ...[
                const SizedBox(height: 8),
                const Text(
                  'Valid blood groups:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: bloodGroups.map((bg) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(bg, style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String inputValue = controller.text.trim();

                if (inputValue.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$field cannot be empty')),
                  );
                  return;
                }

                // Special validation for phone numbers
                if (fieldKey == 'donorPhone') {
                  if (!_isValidPhoneNumber(inputValue)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter a valid 10-digit phone number',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                }

                // Special validation for blood groups
                if (fieldKey == 'donorBloodGroup') {
                  if (!_isValidBloodGroup(inputValue)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter a valid blood group (A+, A-, B+, B-, AB+, AB-, O+, O-)',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  // Convert to uppercase for consistency
                  inputValue = inputValue.toUpperCase();
                }

                try {
                  await FirebaseFirestore.instance
                      .collection('donors')
                      .doc(user!.uid)
                      .update({fieldKey: inputValue});

                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Updated successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error updating $field: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User not authenticated')),
      );
    }

    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
        .instance
        .collection('donors')
        .doc(user!.uid)
        .snapshots();

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
                  'PROFILE',
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Thank you for joining the team.'),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Text('Document does not exist');
                    }

                    final data = snapshot.data!.data();
                    if (data == null) {
                      return const Text('No data available');
                    }

                    return Column(
                      children: [
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(data['donorName'] ?? 'N/A'),
                            trailing: IconButton(
                              onPressed: () {
                                _showEditDialog(
                                  'Name',
                                  data['donorName'] ?? '',
                                  'donorName',
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.bloodtype),
                            title: Text(data['donorBloodGroup'] ?? 'N/A'),
                            trailing: IconButton(
                              onPressed: () {
                                _showEditDialog(
                                  'Blood Group',
                                  data['donorBloodGroup'] ?? '',
                                  'donorBloodGroup',
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(data['donorLocation'] ?? 'N/A'),
                            trailing: IconButton(
                              onPressed: () {
                                _showEditDialog(
                                  'Location',
                                  data['donorLocation'] ?? '',
                                  'donorLocation',
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.email),
                            title: Text(data['donorEmail'] ?? 'N/A'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.phone),
                            title: Text(data['donorPhone'] ?? 'N/A'),
                            trailing: IconButton(
                              onPressed: () {
                                _showEditDialog(
                                  'Phone',
                                  data['donorPhone'] ?? '',
                                  'donorPhone',
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.directions_walk),
                            title: const Text('Available to Donate'),
                            trailing: Switch(
                              value: data['donorActive'] ?? false,
                              onChanged: (value) async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('donors')
                                      .doc(user!.uid)
                                      .update({'donorActive': value});
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Error updating status: $e',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        donorButton(
                          context: context,
                          text: 'LOGOUT',
                          onPressed: () {
                            signOut(context);
                          },
                        ),
                      ],
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

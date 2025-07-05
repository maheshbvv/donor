import 'package:donor/const/blood_group.dart';
import 'package:donor/const/date_picker.dart';
import 'package:donor/pages/requests/method_requests.dart';
import 'package:donor/widgets/button.dart';
import 'package:donor/widgets/snackbar.dart';
import 'package:donor/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final TextEditingController patientName = TextEditingController();
  final TextEditingController hospitalName = TextEditingController();
  final TextEditingController contactPerson = TextEditingController();
  final TextEditingController contactPhone = TextEditingController();
  String? selectedGroup;
  DateTime? selectedDate;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                children: [
                  Text(
                    'Request Blood',
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Please do not use this platform for emergency requests, as immediate availability cannot be guaranteed.',
                  ),
                  SizedBox(height: 12),
                  donorTextField(
                    context: context,
                    icon: Icons.person,
                    keyboardType: TextInputType.text,
                    controller: patientName,
                    labelText: 'Patient Name',
                    obscureText: false,
                  ),
                  SizedBox(height: 12),
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
                        selectedGroup = value;
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  StyledDatePicker(
                    onDateSelected: (date) {
                      setState(() {
                        if (date == null) {
                          selectedDate = DateTime.now();
                        } else {
                          selectedDate = date;
                        }
                      });
                    },
                    initialDate: selectedDate,
                  ),
                  SizedBox(height: 12),
                  donorTextField(
                    context: context,
                    icon: Icons.location_on,
                    keyboardType: TextInputType.text,
                    controller: hospitalName,
                    labelText: 'Hospital Name/Location',
                    obscureText: false,
                  ),
                  SizedBox(height: 12),
                  donorTextField(
                    context: context,
                    icon: Icons.person,
                    keyboardType: TextInputType.text,
                    controller: contactPerson,
                    labelText: 'Contact Person',
                    obscureText: false,
                  ),
                  SizedBox(height: 12),
                  donorTextField(
                    context: context,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    controller: contactPhone,
                    labelText: 'Contact Phone',
                    obscureText: false,
                  ),
                  SizedBox(height: 12),
                  donorButton(
                    context: context,
                    text: 'SUBMIT REQUEST',
                    onPressed: () {
                      // Check if required fields are filled
                      if (patientName.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          donorSnackBar(
                            context: context,
                            text: 'Please enter a patient name',
                            type: 'error',
                          ),
                        );
                        return;
                      }

                      if (selectedGroup == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          donorSnackBar(
                            context: context,
                            text: 'Please select a blood group',
                            type: 'error',
                          ),
                        );
                        return;
                      }

                      if (selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          donorSnackBar(
                            context: context,
                            text: 'Please select a date',
                            type: 'error',
                          ),
                        );
                        return;
                      }

                      if (hospitalName.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          donorSnackBar(
                            context: context,
                            text: 'Please enter a hospital name',
                            type: 'error',
                          ),
                        );
                        return;
                      }
                      if (contactPerson.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          donorSnackBar(
                            context: context,
                            text: 'Please enter a contact person',
                            type: 'error',
                          ),
                        );
                        return;
                      }
                      if (contactPhone.text.isEmpty ||
                          contactPhone.text.length < 10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          donorSnackBar(
                            context: context,
                            text: 'Please enter a valid contact phone',
                            type: 'error',
                          ),
                        );
                        return;
                      }
                      // Show loading
                      showLoadingDialog(context);
                      // Save request
                      submitRequest(
                        context: context,
                        patientName: patientName.text.trim(),
                        hospitalName: hospitalName.text.trim(),
                        contactPerson: contactPerson.text.trim(),
                        contactPhone: contactPhone.text.trim(),
                        bloodGroup: selectedGroup!,
                        selectedDate: selectedDate!,
                      );
                      () {
                        patientName.clear();
                        hospitalName.clear();
                        contactPerson.clear();
                        contactPhone.clear();
                        selectedGroup = null;
                        selectedDate = null;
                      };
                    },
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).go('/app_scaffold');
                    },
                    child: Text('See all DONORS'),
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

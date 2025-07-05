import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BloodRequestCard extends StatelessWidget {
  final String bloodGroup;
  final String hospitalName;
  final String patientName;
  final String contactPerson;
  final String contactPhoneNumber;
  final DateTime requiredDate;
  final VoidCallback? onCallPressed;

  const BloodRequestCard({
    super.key,
    required this.bloodGroup,
    required this.hospitalName,
    required this.patientName,
    required this.contactPerson,
    required this.contactPhoneNumber,
    required this.requiredDate,
    this.onCallPressed,
  });

  Color _getBloodGroupColor(String bloodGroup) {
    String normalized = bloodGroup
        .trim()
        .toUpperCase()
        .replaceAll('–', '-') // en-dash
        .replaceAll('—', '-');
    switch (normalized) {
      case 'A+':
        return Colors.red.shade600;
      case 'A-':
        return Colors.red.shade400;
      case 'B+':
        return Colors.blue.shade600;
      case 'B-':
        return Colors.blue.shade400;
      case 'AB+':
        return Colors.purple.shade600;
      case 'AB-':
        return Colors.purple.shade400;
      case 'O+':
        return Colors.orange.shade600;
      case 'O-':
        return Colors.orange.shade400;
      default:
        return Colors.grey.shade600;
    }
  }

  Color _getUrgencyColor(DateTime requiredDate) {
    final now = DateTime.now();
    final difference = requiredDate.difference(now).inDays;

    if (difference <= 0) {
      return Colors.red.shade700; // Overdue/Today
    } else if (difference <= 2) {
      return Colors.orange.shade600; // Within 2 days
    } else if (difference <= 7) {
      return Colors.yellow.shade700; // Within a week
    } else {
      return Colors.green.shade600; // More than a week
    }
  }

  String _getUrgencyText(DateTime requiredDate) {
    final now = DateTime.now();
    final difference = requiredDate.difference(now).inDays;

    if (difference < 0) {
      return 'OVERDUE';
    } else if (difference == 0) {
      return 'TODAY';
    } else if (difference == 1) {
      return 'TOMORROW';
    } else if (difference <= 7) {
      return '$difference DAYS';
    } else {
      return '$difference DAYS';
    }
  }

  IconData _getUrgencyIcon(DateTime requiredDate) {
    final now = DateTime.now();
    final difference = requiredDate.difference(now).inDays;

    if (difference <= 0) {
      return Icons.warning;
    } else if (difference <= 2) {
      return Icons.schedule;
    } else if (difference <= 7) {
      return Icons.access_time;
    } else {
      return Icons.event;
    }
  }

  // String _formatDate(DateTime date) {
  //   return '${date.day}/${date.month}/${date.year}';
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row with Blood Group and Urgency
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Blood Group Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _getBloodGroupColor(bloodGroup),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: _getBloodGroupColor(bloodGroup),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      bloodGroup,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Urgency Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getUrgencyColor(requiredDate),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: _getUrgencyColor(requiredDate),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getUrgencyIcon(requiredDate),
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getUrgencyText(requiredDate),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Request Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient Name
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey.shade600, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Patient: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          patientName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Hospital Name
                  Row(
                    children: [
                      Icon(
                        Icons.local_hospital,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Hospital: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          hospitalName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Contact Person
                  Row(
                    children: [
                      Icon(
                        Icons.contact_phone,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Contact: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          contactPerson,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Required Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Required by: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          DateFormat('dd-MM-yyyy').format(requiredDate),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Call Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onCallPressed,
                  icon: const Icon(Icons.phone, color: Colors.white),
                  label: Text(
                    'Call $contactPerson',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.green.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

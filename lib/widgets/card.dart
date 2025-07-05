import 'package:flutter/material.dart';
class BloodDonorCard extends StatelessWidget {
  final String bloodGroup;
  final String donorName;
  final String donorPlace;
  final String donorStatus;
  final VoidCallback? onCallPressed;

  const BloodDonorCard({
    super.key,
    required this.bloodGroup,
    required this.donorName,
    required this.donorPlace,
    required this.donorStatus,
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Icons.check_circle;
      case 'inactive':
        return Icons.cancel;
      case 'pending':
        return Icons.access_time;
      default:
        return Icons.help_outline;
    }
  }

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
              // Header Row with Blood Group and Status
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
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(donorStatus),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: _getStatusColor(donorStatus),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(donorStatus),
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          donorStatus,
                          style: TextStyle(
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

              // Donor Info Row with Name, Place, and Call Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side - Name and Place
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Donor Name
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                donorName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Donor Place
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                donorPlace,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Right side - Call Button
                  CircleAvatar(
                    backgroundColor: Colors.green.shade600,
                    child: IconButton(
                      onPressed: onCallPressed,
                      icon: Icon(Icons.phone, color: Colors.white),
                    ),
                  ),
                ],
              ),

              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton.icon(
              //     onPressed: onCallPressed,
              //     icon: const Icon(Icons.phone, color: Colors.white),
              //     label: const Text(
              //       'Call Donor',
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //         color: Colors.white,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.green.shade600,
              //       foregroundColor: Colors.white,
              //       padding: const EdgeInsets.symmetric(vertical: 12),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       elevation: 4,
              //       shadowColor: Colors.green.shade600,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

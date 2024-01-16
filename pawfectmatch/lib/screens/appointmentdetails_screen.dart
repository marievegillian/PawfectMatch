import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawfectmatch/models/appointment_model.dart';
import 'package:pawfectmatch/repositories/database_repository.dart';
import 'package:pawfectmatch/screens/appointment_screen.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final Appointment appointment;

  AppointmentDetailsScreen({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appointment Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildDetailRow('User:', appointment.user),
            _buildDetailRow('Dog:', appointment.dog),
            _buildDetailRow('Status:', appointment.status),
            _buildDetailRow('Date and Time:', _formatDateTime(appointment.date)),
            SizedBox(height: 20),
            if (appointment.status == 'upcoming') // Show buttons only if the status is 'upcoming'
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _cancelAppointment(context);
                    },
                    child: Text('Cancel Appointment'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _proceedToPayment(context);
                    },
                    child: Text('Proceed to Payment'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('EEE, MMM d, y h:mm a').format(dateTime);
  }

  void _cancelAppointment(BuildContext context) async {
    try {
      // Implement cancellation logic here
      // For example, show a confirmation dialog before canceling

      // Update the status to 'cancelled'
      await DatabaseRepository().updateAppointmentStatus(
        appointment.id,
        'cancelled',
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppointmentScreen()),
      );
    } catch (error) {
      // Handle the error (e.g., show an error message)
      print('Error cancelling appointment: $error');
    }
  }

  void _proceedToPayment(BuildContext context) {
    // Implement logic to proceed to payment screen
    // This could involve navigating to a payment screen or initiating a payment process

    // After payment, you might want to go back to the previous screen or refresh the appointment list
    Navigator.pop(context);
  }
}

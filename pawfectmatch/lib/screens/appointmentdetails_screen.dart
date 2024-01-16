import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final String appointmentDetails; // You may need to pass the actual appointment details

  AppointmentDetailsScreen({required this.appointmentDetails});

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
            Text(appointmentDetails), // Display the actual appointment details here
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle cancellation logic
                    _cancelAppointment(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle payment logic
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

  void _cancelAppointment(BuildContext context) {
    // Implement cancellation logic here
    // For example, show a confirmation dialog before canceling

    // After canceling, you might want to go back to the previous screen or refresh the appointment list
    Navigator.pop(context);
  }

  void _proceedToPayment(BuildContext context) {
    // Implement logic to proceed to payment screen
    // This could involve navigating to a payment screen or initiating a payment process

    // After payment, you might want to go back to the previous screen or refresh the appointment list
    Navigator.pop(context);
  }
}

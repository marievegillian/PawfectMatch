import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawfectmatch/models/appointment_model.dart';
import 'package:pawfectmatch/repositories/database_repository.dart';
import 'package:pawfectmatch/screens/appointment_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
            _buildDetailRow('Dog:', appointment.dog),
            _buildDetailRow('Status:', appointment.status),
            _buildDetailRow(
                'Date and Time:', _formatDateTime(appointment.date)),
            SizedBox(height: 20),
            if (appointment.status ==
                'upcoming') // Show buttons only if the status is 'upcoming'
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
                      _paidAppointment(context);
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
      await DatabaseRepository().CancelAppointment(
        appointment.id,
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

  void _paidAppointment(BuildContext context) async {
    try {
      await DatabaseRepository().PaidAppointment(
        appointment.id,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppointmentScreen()),
      );
    } catch (error) {
      // Handle the error (e.g., show an error message)
      print('Error completing appointment: $error');
    }
  }

  void _proceedToPayment(BuildContext context) {
    // Implement logic to proceed to payment screen
    // This could involve navigating to a payment screen or initiating a payment process
    try {
      _launchURL(
          "https://pm.link/org-CE8qjbKiDcVRAQjPkYns4jk8/test/4gr8G4K", context);
      // Additional logic after launching the URL if needed
    } catch (e) {
      print('Error in _proceedToPayment: $e');
    }

    // After payment, you might want to go back to the previous screen or refresh the appointment list
    //Navigator.pop(context);
  }

  /*void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }*/
  /*void _launchURL(String url, context) async {
    try {
      // Open a WebView with JavaScript enabled
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      );
    } catch (e) {
      print('Error launching payment gateway URL: $e');
    }
  }*/
  void _launchURL(String url, BuildContext context) async {
    try {
      await launch(url);
      //await launch(url, forceWebView: true, enableJavaScript: true);
    } catch (e) {
      // If an error occurs, try opening in the external browser without WebView
      try {
        await launch(url, forceWebView: true, enableJavaScript: true);
        //await launch(url);
      } catch (e) {
        print('Error launching URL: $e');
      }
    }
  }
}

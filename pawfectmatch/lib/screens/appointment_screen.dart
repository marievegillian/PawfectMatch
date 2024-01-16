import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawfectmatch/screens/newappointment_screen.dart';
import '/repositories/database_repository.dart'; 

class AppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Appointments'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _AppointmentList(status: 'upcoming'),
            _AppointmentList(status: 'completed'),
            _AppointmentList(status: 'cancelled'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewAppointmentScreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class _AppointmentList extends StatelessWidget {
  final String status;

  _AppointmentList({required this.status});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _getAppointments(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No $status appointments available.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]),
              );
            },
          );
        }
      },
    );
  }

  Future<List<String>> _getAppointments(String status) async {
    try {
      List<String> appointments = await DatabaseRepository().getAppointmentsByStatus(status);
      return appointments;
    } catch (error) {
      print('Error fetching appointments: $error');
      return [];
    }
  }
}


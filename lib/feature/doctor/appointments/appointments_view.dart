import 'package:flutter/material.dart';
import 'package:se7ety/feature/doctor/appointments/appointments_list.dart';

class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({super.key});

  @override
  DoctorAppointmentsState createState() => DoctorAppointmentsState();
}

class DoctorAppointmentsState extends State<DoctorAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مواعيد الحجز',
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: DoctorAppointmentList(),
      ),
    );
  }
}

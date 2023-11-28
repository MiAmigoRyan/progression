
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:coach_flutter/models/event.dart';

class CalendarWidget extends StatelessWidget{
  
  final List<Event> events;

  const CalendarWidget({Key? key, required this.events}): super(key:key);

  @override
  Widget build(BuildContext context){
    return SfCalendar(
      view: CalendarView.timelineMonth,
      initialSelectedDate: DateTime.now(),
      dataSource: _getCalendarDataSource(),
    );
  }

  CalendarDataSource _getCalendarDataSource(){
    List<Appointment> appointments = events.map((event){
      return Appointment(startTime: event.from, endTime: event.to, subject: event.title,);
    }).toList();
    return AppointmentDataSource(appointments);
  }
}
class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

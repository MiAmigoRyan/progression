import 'package:coach_flutter/models/event.dart';
import 'package:coach_flutter/screens/event_edititing_screen.dart';
import 'package:coach_flutter/utils/colors.dart';
import 'package:coach_flutter/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // List to store events
  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          'progression.png',
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.messenger_outline,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: CalendarWidget(events: events),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to EventEditingPage and wait for a result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventEditingPage()),
          );

          // Handle the result (updated event) returned from the editing page
          if (result != null && result is Event) {
            setState(() {
              // Add the updated event to your calendar data
              events.add(result);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

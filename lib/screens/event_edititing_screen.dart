import 'package:coach_flutter/models/event.dart';
import 'package:coach_flutter/models/task.dart';
import 'package:coach_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime startDate;
  late DateTime endDate;
  late TextEditingController titleController;
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event?.title);
    startDate = widget.event?.from ?? DateTime.now();
    endDate = widget.event?.to ?? DateTime.now().add(const Duration(hours: 3));
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildEditingActions(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                const SizedBox(height: 16),
                buildDateTimePickers(),
                const SizedBox(height: 16,)
                buildTasks(),
              ],
            ),
          ),
        ),
      );

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              // Save the event here using the entered data
              final updatedEvent = Event(
                title: titleController.text,
                from: startDate,
                to: endDate,
                description: '',
                tasks:[],
                // Include other properties as needed
              );
              // You can now use the updatedEvent for saving or updating
              // You might want to pass it to a callback or a provider to handle the save functionality
            Navigator.pop(context, updatedEvent);
            }
          },
          icon: const Icon(Icons.done),
          label: const Text('Save'),
        ),
      ];

  Widget buildTitle() => TextFormField(
        style: const TextStyle(fontSize: 24),
        controller: titleController,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Event Title',
        ),
        onFieldSubmitted: (_) {},
        validator: (title) =>
            title != null && title.isEmpty ? 'title cannot be empty' : null,
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildDateTimePicker({
    required String title,
    required DateTime selectedDate,
    required ValueChanged<DateTime> onSelected,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          ElevatedButton(
            onPressed: () => pickDate(context, selectedDate, onSelected),
            child: Text(
              selectedDate.toLocal().toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      );

  Future pickDate(
    BuildContext context,
    DateTime initialDate,
    ValueChanged<DateTime> onSelected,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != initialDate) {
      onSelected(pickedDate);
    }
  }

  Widget buildFrom() => buildHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: toDate(startDate),
                onClicked: () => pickDate(context, startDate, (date) {
                  setState(() {
                    startDate = date;
                  });
                }),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: toTime(startDate),
                onClicked: () => pickTime(context, startDate, (time) {
                  setState(() {
                    startDate = DateTime(
                      startDate.year,
                      startDate.month,
                      startDate.day,
                      time.hour,
                      time.minute,
                    );
                  });
                }),
              ),
            ),
          ],
        ),
      );
  Widget buildTo() => buildHeader(
        header: 'TO',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: toDate(endDate),
                onClicked: () => pickDate(context, endDate, (date) {
                  setState(() {
                    endDate = date;
                  });
                }),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: toTime(endDate),
                onClicked: () => pickTime(context, endDate, (time) {
                  setState(() {
                    endDate = DateTime(
                      endDate.year,
                      endDate.month,
                      endDate.day,
                      time.hour,
                      time.minute,
                    );
                  });
                }),
              ),
            ),
          ],
        ),
      );

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Future pickTime(
    BuildContext context,
    DateTime initialTime,
    ValueChanged<TimeOfDay> onSelected,
  ) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialTime),
    );

    if (pickedTime != null) {
      onSelected(pickedTime);
    }
  }

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );
      
      Widget buildTasks() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tasks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < tasks.length; i++) ...[
            buildTaskRow(i),
            const SizedBox(height: 8),
          ],
          ElevatedButton(
            onPressed: () {
              setState(() {
                tasks.add(Task(description: '', sets: 0, reps: 0, duration: Duration()));
              });
            },
            child: const Text('Add Task'),
          ),
        ],
      );

  Widget buildTaskRow(int index) => Row(
        children: [
          Expanded(
            flex: 3,
            child: TextFormField(
              initialValue: tasks[index].description,
              onChanged: (value) {
                setState(() {
                  tasks[index] = tasks[index].copyWith(description: value);
                });
              },
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<int>(
              value: tasks[index].sets,
              onChanged: (value) {
                setState(() {
                  tasks[index] = tasks[index].copyWith(sets: value ?? 0);
                });
              },
              items: List.generate(5, (index) => index + 1)
                  .map((value) => DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value Sets'),
                      ))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Sets'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<int>(
              value: tasks[index].reps,
              onChanged: (value) {
                setState(() {
                  tasks[index] = tasks[index].copyWith(reps: value ?? 0);
                });
              },
              items: List.generate(20, (index) => index + 1)
                  .map((value) => DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value Reps'),
                      ))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Reps'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<Duration>(
              value: tasks[index].duration,
              onChanged: (value) {
                setState(() {
                  tasks[index] = tasks[index].copyWith(duration: value ?? Duration());
                });
              },
              items: [
                const DropdownMenuItem<Duration>(
                  value: Duration(minutes: 15),
                  child: Text('15 Minutes'),
                ),
                const DropdownMenuItem<Duration>(
                  value: Duration(minutes: 30),
                  child: Text('30 Minutes'),
                ),
                // Add more duration options as needed
              ],
              decoration: const InputDecoration(labelText: 'Duration'),
            ),
          ),
        ],
      );

}

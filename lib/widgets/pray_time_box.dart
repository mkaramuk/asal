import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayTimeBox extends StatefulWidget {
  final String timeName;
  final DateTime time;

  const PrayTimeBox({super.key, required this.timeName, required this.time});

  @override
  State<PrayTimeBox> createState() => _PrayTimeBoxState();
}

class _PrayTimeBoxState extends State<PrayTimeBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Colors.blueGrey, spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3))
          ],
          color: const Color.fromARGB(255, 64, 235, 115),
          border: Border.all(width: 2, color: const Color.fromARGB(255, 128, 128, 128)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              widget.timeName,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            const Divider(color: Colors.black, thickness: 1),
            Text(DateFormat.Hm().format(widget.time),
                style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 42, 156)))
          ],
        ),
      ),
    );
  }
}

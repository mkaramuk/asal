import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeCard extends StatelessWidget {
  final String title;
  final DateTime time;

  const TimeCard({super.key, required this.time, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 90, 90, 90),
                spreadRadius: 1,
                blurRadius: 15,
                offset: Offset(0, 3))
          ],
          color: Color.fromARGB(255, 196, 196, 196),
          border: Border.all(width: 2, color: Color.fromARGB(255, 182, 182, 182)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            const Divider(color: Colors.black, thickness: 1),
            Text(DateFormat.Hm().format(time),
                style: const TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)))
          ],
        ),
      ),
    );
  }
}

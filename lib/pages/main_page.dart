import 'package:asel/widgets/pray_time_box.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/background.jpg",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            _prayTimeRow(context, PrayTimeBox(timeName: "İmsak", time: DateTime.now()),
                PrayTimeBox(timeName: "Güneş", time: DateTime.now())),
            const SizedBox(
              height: 30,
            ),
            _prayTimeRow(context, PrayTimeBox(timeName: "Öğle", time: DateTime.now()),
                PrayTimeBox(timeName: "İkindi", time: DateTime.now())),
            const SizedBox(
              height: 30,
            ),
            _prayTimeRow(context, PrayTimeBox(timeName: "Akşam", time: DateTime.now()),
                PrayTimeBox(timeName: "Yatsı", time: DateTime.now())),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.blueGrey,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ],
                  color: const Color.fromARGB(255, 64, 235, 115),
                  border: Border.all(width: 2, color: const Color.fromARGB(255, 128, 128, 128)),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Text(
                      "Vaktin Çıkmasına",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                    const Divider(color: Colors.black, thickness: 1),
                    Text("00:00",
                        style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 42, 156)))
                  ],
                ),
              ),
            ),
          ]),
        )
      ],
    );
  }
}

Widget _prayTimeRow(BuildContext context, PrayTimeBox left, PrayTimeBox right) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      left,
      SizedBox(
        width: MediaQuery.of(context).size.width / 4,
      ),
      right,
    ],
  );
}

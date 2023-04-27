import 'package:asal/pages/homepage/homepage_cubit.dart';
import 'package:asal/widgets/time_card/time_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomepageCubit(),
      child: BlocConsumer<HomepageCubit, HomepageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomepageLoading) {
            return _buildProgressIndicator();
          } else /* if (state is HomepageLoaded) */ {
            return Stack(
              children: [_buildBackground(context), _buildScaffold(context)],
            );
          }
        },
      ),
    );
  }

  Scaffold _buildProgressIndicator() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Colors.grey),
      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
        ),
        _buildTimeRow(
            context,
            TimeCard(title: "İmsak", time: context.read<HomepageCubit>().calendar!.today().fajr),
            TimeCard(
                title: "Güneş", time: context.read<HomepageCubit>().calendar!.today().sunrise)),
        const SizedBox(
          height: 30,
        ),
        _buildTimeRow(
            context,
            TimeCard(title: "Öğle", time: context.read<HomepageCubit>().calendar!.today().dhuhr),
            TimeCard(title: "İkindi", time: context.read<HomepageCubit>().calendar!.today().asr)),
        const SizedBox(
          height: 30,
        ),
        _buildTimeRow(
            context,
            TimeCard(title: "Akşam", time: context.read<HomepageCubit>().calendar!.today().maghrib),
            TimeCard(title: "Yatsı", time: context.read<HomepageCubit>().calendar!.today().isha)),
        const Spacer(),
        _buildTimeLeftCard(context),
      ]),
    );
  }

  Image _buildBackground(BuildContext context) {
    return Image.asset(
      "assets/images/background.jpg",
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );
  }

  Container _buildTimeLeftCard(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Colors.blueGrey, spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3))
          ],
          color: Color.fromARGB(255, 223, 223, 223),
          border: Border.all(width: 2, color: const Color.fromARGB(255, 128, 128, 128)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              "Vaktin Çıkmasına",
              style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            const Divider(color: Colors.black, thickness: 1),
            Text(context.read<HomepageCubit>().timeLeft,
                style: const TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)))
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRow(BuildContext context, TimeCard left, TimeCard right) {
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
}

import 'package:asal/dialogs/update_times/update_times_view.dart';
import 'package:asal/extensions/date_extensions.dart';
import 'package:asal/models/time_model.dart';
import 'package:asal/pages/homepage/homepage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomepageCubit(context),
      child: BlocConsumer<HomepageCubit, HomepageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomepageLoading) {
            return _buildProgressIndicator();
          } else /* if (state is HomepageLoaded) */ {
            return Stack(
              children: [_buildScaffold(context)],
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
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: context.read<HomepageCubit>().showUpdateTimesDialog,
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Column(children: [
        Center(
          child: _buildTimeSlider(context),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Text("Vaktin çıkmasına:", style: GoogleFonts.robotoCondensed(fontSize: 30)),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0.2,
                        blurRadius: 7,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Center(
                  child: Text(context.read<HomepageCubit>().timeLeft,
                      style:
                          GoogleFonts.robotoCondensed(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
            ),
          ],
        ),
        const Spacer(
          flex: 2,
        ),
        Row(
          children: [Expanded(child: _buildTimeTable(context))],
        )
      ]),
    );
  }

  DataTable _buildTimeTable(BuildContext context) {
    var cubit = context.read<HomepageCubit>();

    style(String timeName) {
      return TextStyle(color: cubit.nextTime.name == timeName ? Colors.white : Colors.black);
    }

    return DataTable(
        columns: const [DataColumn(label: Text("Vakit")), DataColumn(label: Text("Saat"))],
        rows: cubit.prayTimes
            .map((e) => DataRow(
                  cells: [
                    DataCell(Text(e.name, style: style(e.name))),
                    DataCell(Text(DateFormat.Hm().format(e.value), style: style(e.name))),
                  ],
                  color: MaterialStateColor.resolveWith((states) {
                    if (e.name == cubit.nextTime.name) {
                      return Colors.lightGreen;
                    }
                    return Colors.transparent;
                  }),
                ))
            .toList());
  }

  Widget _buildTimeCard(BuildContext context, TimeModel model) {
    var cubit = context.read<HomepageCubit>();
    var image = DecorationImage(
        image: AssetImage(model.image.isNotEmpty ? model.image : "assets/images/evening.jpg"),
        fit: BoxFit.fill);

    Border? drawBorder() {
      if (model.name == cubit.nextTime.name) {
        return Border.all(
          color: Colors.lightGreen,
          style: BorderStyle.solid,
          width: 2,
        );
      }
      return null;
    }

    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                image: image,
                border: drawBorder(),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 0.2, blurRadius: 7, offset: Offset(0, 2))
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                Row(
                  children: [
                    Text(model.name,
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
                Row(children: [
                  Text(DateFormat.Hm().format(model.value),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white))
                ]),
              ]),
            )),
      ],
    );
  }

  Widget _buildTimeSlider(BuildContext context) {
    var cubit = context.read<HomepageCubit>();

    return Column(
      children: [
        CarouselSlider(
          carouselController: cubit.carouselController,
          options: CarouselOptions(
            initialPage: context.read<HomepageCubit>().cardIndex,
            height: 160,
            viewportFraction: 1,
            enlargeCenterPage: true,
            disableCenter: true,
            enlargeFactor: 0,
            onPageChanged: context.read<HomepageCubit>().onCardChanged,
          ),
          items: cubit.prayTimes.map((e) => _buildTimeCard(context, e)).toList(),
        ),
        AnimatedSmoothIndicator(
          activeIndex: context.read<HomepageCubit>().cardIndex,
          count: cubit.prayTimes.length,
          effect: const ExpandingDotsEffect(
              dotWidth: 10, dotHeight: 10, activeDotColor: Colors.lightGreen),
        )
      ],
    );
  }
}

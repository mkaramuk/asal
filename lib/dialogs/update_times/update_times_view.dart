import 'package:asal/dialogs/update_times/update_times_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var UpdateTimesDialog = const AlertDialog(
  title: Text("Vakitleri Güncelle"),
  content: UpdateTimesView(),
);

class UpdateTimesView extends StatelessWidget {
  const UpdateTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateTimesCubit(context),
      child: BlocConsumer<UpdateTimesCubit, UpdateTimesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
              onWillPop: context.read<UpdateTimesCubit>().onBack,
              child: Wrap(
                children: [
                  Column(
                    children: [
                      _buildTextRow("Ülke:"),
                      _buildDropdown(
                          context,
                          context.read<UpdateTimesCubit>().country,
                          context.read<UpdateTimesCubit>().countriesLoading,
                          context.read<UpdateTimesCubit>().countries,
                          context.read<UpdateTimesCubit>().onChangeCountry,
                          "ülke"),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextRow("Şehir:"),
                      _buildDropdown(
                          context,
                          context.read<UpdateTimesCubit>().city,
                          context.read<UpdateTimesCubit>().citiesLoading,
                          context.read<UpdateTimesCubit>().cities,
                          context.read<UpdateTimesCubit>().onChangeCity,
                          "ülke"),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextRow("İlçe:"),
                      _buildDropdown(
                          context,
                          context.read<UpdateTimesCubit>().region,
                          context.read<UpdateTimesCubit>().regionsLoading,
                          context.read<UpdateTimesCubit>().regions,
                          context.read<UpdateTimesCubit>().onChangeRegion,
                          "şehir"),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: context.read<UpdateTimesCubit>().updateTimes,
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.grey),
                                foregroundColor: MaterialStatePropertyAll(Colors.black)),
                            child: const Text("Güncelle"),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ));
        },
      ),
    );
  }

  DropdownButton<String> _buildDropdown(BuildContext context, String? value, bool isLoading,
      List<String> items, void Function(String?) onChanged, String lastSelection) {
    return DropdownButton(
        isExpanded: true,
        value: value,
        disabledHint: Text("Lütfen $lastSelection seçin"),
        items: isLoading
            ? [_buildLoadingDropdownItem()]
            : items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
        onChanged: onChanged);
  }

  DropdownMenuItem<String> _buildLoadingDropdownItem() {
    return DropdownMenuItem(
        value: "",
        child: Row(children: const [
          SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(
              color: Colors.grey,
              strokeWidth: 3,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text("Yükleniyor")
        ]));
  }

  Row _buildTextRow(String text) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Text(text, style: const TextStyle(fontWeight: FontWeight.w700))]);
  }
}

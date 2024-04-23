import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RegimentTab extends StatefulWidget {
  const RegimentTab({super.key});

  @override
  State<RegimentTab> createState() => _RegimentTabState();
}

Widget _regimentPreview(
    BuildContext context, TrainingRegiment regiment, RegimentService service) {
  return GestureDetector(
    onTap: () {
      service.openRegiment(context, regiment);
      Navigator.of(context).pushNamed("/set_regiment_calendar");
    },
    child: Card(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        ListTile(
          leading: FaIcon(regiment.trainingType!.getIconData()),
          title: Text(regiment.name!),
          subtitle: Text(regiment.notes!),
        )
      ]),
    ),
  );
}

Widget _addRegimentButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/set_name');
    },
    child: Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(31, 180, 180, 180)),
      child: Wrap(alignment: WrapAlignment.center, children: [
        const FaIcon(FontAwesomeIcons.plus),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Add new regiment'.toUpperCase(),
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
      ]),
    ),
  );
}

class _RegimentTabState extends State<RegimentTab> {
  Future<List<TrainingRegiment>>? regiments;
  final DatabaseService _dbService = DatabaseService();
  final RegimentService _regimentService = RegimentService();
  @override
  void initState() {
    regiments = _dbService.getUserRegiments('/users/abWbLcBiD2xRyYTI5ZQ0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              _addRegimentButton(context),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: FutureBuilder(
                    future: regiments,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Error - ${snapshot.error}"));
                      } else if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _regimentPreview(context,
                                snapshot.data![index], _regimentService);
                          });
                    }),
              )
            ],
          )),
    );
  }
}

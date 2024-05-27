import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/training_regiment.dart';
import 'package:flutter_fitness_app/models/user.dart';
import 'package:flutter_fitness_app/services/database_service.dart';
import 'package:flutter_fitness_app/services/regiment_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegimentTab extends StatefulWidget {
  const RegimentTab({super.key});

  @override
  State<RegimentTab> createState() => _RegimentTabState();
}

Widget _regimentPreview(BuildContext context, TrainingRegiment regiment,
    RegimentService service, Function setState) {
  return GestureDetector(
    onTap: () {
      service.openRegiment(context, regiment);
      Navigator.of(context).pushNamed("/set_regiment_calendar");
    },
    onLongPress: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(children: [
              ElevatedButton(
                  onPressed: () {
                    service.openRegiment(context, regiment);
                    service.startRegiment(context);
                  },
                  child: const Text("Start"))
            ]),
          );
        },
      );
    },
    child: Card(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        ListTile(
          leading: FaIcon(regiment.trainingType!.getIconData()),
          title: Text(regiment.name!),
          subtitle: Text(regiment.notes == null ? "" : regiment.notes!),
        ),
        LinearProgressIndicator(
          value: regiment.startDate != null
              ? (regiment.getCurrentDay() + 1) / regiment.cycleDurationInDays!
              : 0,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    regiments =
        _dbService.getUserRegiments(Provider.of<AppUser>(context).userUID!);
    //regiments ??= [];
    return SafeArea(
      child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              _addRegimentButton(context),
              FutureBuilder(
                  future: regiments,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 195,
                        width: double.infinity,
                        child: Container(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var regiment = snapshot.data![index];
                                  String cardText = "";
                                  if (regiment.startDate == null) {
                                    cardText = "Not started";
                                  } else if (regiment.dayOfPause == -1) {
                                    cardText =
                                        "Day ${regiment.getCurrentDay() + 1} of ${regiment.cycleDurationInDays}";
                                  } else if (regiment.dayOfPause != -1) {
                                    cardText =
                                        "Paused on day ${regiment.dayOfPause + 1} of ${regiment.cycleDurationInDays}";
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      _regimentService.openRegiment(
                                          context, regiment);
                                      Navigator.of(context)
                                          .pushNamed("/set_regiment_calendar")
                                          .then((value) => setState(
                                                () {},
                                              ));
                                    },
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Column(children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _regimentService
                                                          .openRegiment(context,
                                                              regiment);
                                                      _regimentService
                                                          .startRegiment(
                                                              context);
                                                    });
                                                  },
                                                  child: const Text("Start")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _regimentService
                                                          .openRegiment(context,
                                                              regiment);
                                                      _regimentService
                                                          .pauseRegiment(
                                                              context);
                                                    });
                                                  },
                                                  child: const Text("Pause")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _regimentService
                                                          .openRegiment(context,
                                                              regiment);
                                                      _regimentService
                                                          .resumeRegiment(
                                                              context);
                                                    });
                                                  },
                                                  child: const Text("Resume")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _regimentService
                                                          .openRegiment(context,
                                                              regiment);
                                                      _regimentService
                                                          .stopRegiment(
                                                              context);
                                                    });
                                                  },
                                                  child: const Text("Stop"))
                                            ]),
                                          );
                                        },
                                      );
                                    },
                                    child: Card(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ListTile(
                                              leading: FaIcon(regiment
                                                  .trainingType!
                                                  .getIconData()),
                                              title: Text(regiment.name!),
                                              subtitle: Text(cardText),
                                            ),
                                            LinearProgressIndicator(
                                              value: (regiment.getCurrentDay() +
                                                      1) /
                                                  regiment.cycleDurationInDays!,
                                            )
                                          ]),
                                    ),
                                  );
                                  ;
                                })),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          )),
    );
  }
}

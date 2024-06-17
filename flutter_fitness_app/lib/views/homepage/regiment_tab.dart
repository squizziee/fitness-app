import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/base/training_regiment.dart';
import 'package:flutter_fitness_app/models/base/user.dart';
import 'package:flutter_fitness_app/views/misc/regiment_preview.dart';
import 'package:flutter_fitness_app/views/misc/route_base_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RegimentTab extends StatefulWidget {
  const RegimentTab({super.key});

  @override
  State<RegimentTab> createState() => _RegimentTabState();
}

class _RegimentTabState extends State<RegimentTab> {
  List<TrainingRegiment>? regiments;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    regiments = Provider.of<AppUser>(context).regiments;
    return SafeArea(
      child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              routeBaseButton(context, '/set_name', FontAwesomeIcons.plus,
                  "Add new regiment"),
              Container(
                  child: Expanded(
                child: ListView.builder(
                    itemCount: regiments!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var regiment = regiments![index];
                      //return _regimentPreview(context, regiment);
                      return RegimentPreview(regiment: regiment);
                    }),
              ))
            ],
          )),
    );
  }
}

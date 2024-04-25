import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/weight_training/weight_exercise_type.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchDelegate extends SearchDelegate<WeightExerciseType> {
  List<WeightExerciseType>? _searchList;

  CustomSearchDelegate(List<WeightExerciseType>? searchList) {
    _searchList = searchList;
    _searchList!
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  Widget _searchResultWidget(WeightExerciseType e, Function func) {
    return GestureDetector(
      onTap: () => func,
      child: SizedBox(
        height: 50,
        child: Wrap(children: [
          Image.network(
            e.iconURL,
            height: 50,
          ),
          Text(e.name),
          Text(
            e.bodyPart,
            style: const TextStyle(color: Color.fromRGBO(0, 0, 0, .5)),
          )
        ]),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    var searchResult = _searchList!
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          var e = searchResult[index];
          return GestureDetector(
            onTap: () => close(context, searchResult[index]),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              child: Wrap(
                spacing: 15,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Image.network(
                    e.iconURL,
                    height: 40,
                  ),
                  Text(e.name,
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1)),
                  Text(
                    e.bodyPart,
                    style: const TextStyle(color: Color.fromRGBO(0, 0, 0, .25)),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      title: const Text(''),
      onTap: () {},
    );
  }
}

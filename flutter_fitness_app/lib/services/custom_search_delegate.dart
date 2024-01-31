import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/models/exercise_type.dart';

class CustomSearchDelegate extends SearchDelegate<ExerciseType> {
  
  List<ExerciseType>? _searchList;

  CustomSearchDelegate(List<ExerciseType>? searchList) {
    _searchList = searchList;
  }
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(
      onPressed: () => query = '', 
      icon: const Icon(Icons.clear)
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(), 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var searchResult = _searchList!
      .where((element) => element.name.toLowerCase()
      .contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: searchResult.length, 
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResult[index].name),
          onTap: () => close(context, searchResult[index]),
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
          title: Text('No suggestions for now'),
          onTap: () {},
        );
  }

}
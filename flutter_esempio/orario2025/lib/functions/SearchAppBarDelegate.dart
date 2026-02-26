//Search delegate
import '../utilities/globals.dart';
import 'package:flutter/material.dart';

import 'WordSuggestionList.dart';

class SearchAppBarDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  SearchAppBarDelegate(List<String> words, List<String> history)
      : _words = words,
        //pre-populated history of words
        _history = history,
        super();

  // Setting leading icon for the search bar.
  //Clicking on back arrow will take control to main page
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        close(context, "null");
      },
    );
  }

  // Builds page to populate search results.
  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Tocca per visualizzare l\'orario di...',
              style: Globals.font3Orange,
            ),
            GestureDetector(
              onTap: () {
                //Define your action when clicking on result item.
                //In this example, it simply closes the page
                close(context, query);
              },
              child: Text(
                ' ... $query',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.deepOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ATTENZIONE ...',
            style: Globals.fontError,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Nell\'elenco dei docenti non è'),
                const Text('presente alcun nominativo che'),
                Text('inizia con la lettera "$query"!!!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: Globals.fontError,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//  String s = "";

  // Suggestions list while typing search query - this.query.
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return WordSuggestionList(
      query: (query.length == 1) ? query.toUpperCase() : query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        _history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          : IconButton(
              icon: const Icon(Icons.mic),
              tooltip: 'Voice input',
              onPressed: () {
                //this.query = 'TBW: Get input from voice';
              },
            ),
    ];
  }
}

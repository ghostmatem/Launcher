import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:launch/apps/all%20apps/data/app_repository.dart';
import 'package:launch/apps/all%20apps/search/search_algorytms.dart' as alg;

class MySearchDelegate extends SearchDelegate {
  static const double _bottonSize = 32;
  static const Color _bottonColor = Color.fromRGBO(48, 48, 48, 1);

  static List<alg.SearchAGLContains> algs = [alg.StartWithSearch(), alg.PhraseSearch()];
  static List<Icon> icons = [
    const Icon(Icons.format_indent_decrease_rounded, size: _bottonSize, color: _bottonColor),
    const Icon(Icons.format_indent_increase_rounded, size: _bottonSize, color: _bottonColor),
    const Icon(Icons.manage_search, size: _bottonSize, color: _bottonColor),];
  List<int> results = [];

  int _algType = 2;

  _incrementAlgType(BuildContext context) {
    _algType = (_algType + 1) % 3;
    var s = query;
    query = s;
  }



  @override 
  List<Widget>? buildActions(BuildContext context) =>
     [  IconButton(
        icon: icons[_algType],
        onPressed: () => _incrementAlgType(context)),
        IconButton(icon: 
        const Icon(Icons.restore_from_trash_rounded, size: _bottonSize, color: _bottonColor),
        onPressed: () {
          query = "";
        },
      ),
    ];
  

  @override
  Widget? buildLeading(BuildContext context) =>
    IconButton(icon: const Icon(Icons.keyboard_backspace_rounded), 
    onPressed: () => Navigator.pop(context));

  @override
  Widget buildResults(BuildContext context) {
    return getListResults(results, context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var qurrent = query.toLowerCase();
    if (_algType == 2) {
      var resFirst = getResultsIndex(AppsRepository.keys, qurrent, algs[0]);
      var resKeyWords = getResultsIndex(AppsRepository.keys, qurrent, algs[1],
      resFirst);
      resFirst.addAll(resKeyWords);
      results = resFirst;
      return getListResults(resFirst, context);
    }
    else {
      var res = getResultsIndex(AppsRepository.keys, qurrent, algs[_algType]);
      results = res;
      return getListResults(res, context);
    }  
  }

  Widget getListResults(List<int> indexes, BuildContext context) {
    if (indexes.isNotEmpty) {
      return ListView.builder(
        itemCount: indexes.length,
        itemBuilder: (context, index){
          return AppsRepository.mapWidget[
            AppsRepository.keys[indexes[index]]
          ] as Widget;
        });
    }
    return Container(
      alignment: Alignment.center,
      child: Text('По запросу \'$query\' ничего не найдено',
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.center,));
  }

  List<int> getResultsIndex(List<String> appsNames, String phrase, 
  alg.SearchAGLContains algorytm, [List<int>? exceptions]) {
    bool exNotNull = exceptions != null && exceptions.isNotEmpty;
    var result = <int>[];
    for (int i = 0; i < appsNames.length; i++) {
      if (algorytm.isContains(appsNames[i], phrase)) {
        if (exNotNull) {
          if (binarySearch(exceptions, i) == -1) {
            result.add(i);
          }
        }
        else {
          result.add(i);
        }
      }
    }
    return result;
  }

}
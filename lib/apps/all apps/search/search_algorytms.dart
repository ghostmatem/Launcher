abstract class SearchAGLContains {

  bool isContains(String s, String phrase);
}

class PhraseSearch extends SearchAGLContains {
  @override

  // Алгоритм Кнута - Морриса - Пратта
  bool isContains(String s, String phrase) 
  => _keyWord(s, phrase);

  bool _keyWord(String s, String phrase) {
  if (phrase.isEmpty || phrase == '') return true;
  if (phrase.length > s.length) return false;
  var p = _getPArray(phrase);
  int i = 0, j = 0;
  int m = phrase.length, n = s.length;
  while(i < n) {
    if (s[i] == phrase[j]) {
      i++;
      j++;
      if (j == m) {
        return true;
      }
    }
    else {
      if (j > 0) {
        j = p[j - 1];
      }
      else {
        i++;
  }}}
  return false;
  }

  List<int> _getPArray (String phrase){
  List<int> p = List.filled(phrase.length, 0);

  int i = 1, j = 0;

  while(i < phrase.length) {
    if (phrase[j] == phrase[i]) {
      p[i] = j + 1;
      i++;
      j++;
    }
    else {
      if (j == 0) {
        p[i] = 0;
        i++;
      }
      else {
        j = p[j - 1];
  }}}
  return p;
}
}

class StartWithSearch extends SearchAGLContains{
  @override
  bool isContains (String s, String phrase) {
  if (phrase.isEmpty || phrase == '') return true;
  if (phrase.length > s.length) return false;

  for (var i = 0; i < phrase.length; i++) {
    if (phrase[i] != s[i]) {
      return false;
    }
  }
  return true;
  }
}





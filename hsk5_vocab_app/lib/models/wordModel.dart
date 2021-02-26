import 'dart:convert';

class WordModel {
  String stt;
  String get getStt {
    return stt;
  }

  String word;
  String get getWord {
    return word;
  }

  String pronounciation;
  String get getPronounciation {
    return pronounciation;
  }

  String definition;
  String get getDefinition {
    return definition;
  }

  int remembered;
  int get getRemembered {
    return remembered;
  }

  bool isMarked;
  bool get getIsMarked {
    return isMarked;
  }

  bool isStudied;
  bool get getIsStudied {
    return isStudied;
  }

  WordModel({
    this.definition,
    this.pronounciation,
    this.stt,
    this.word,
    this.remembered,
    this.isMarked,
    this.isStudied,
  });
  @override
  String toString() {
    return 'Word{stt: $stt, definition: $definition, word: $word, remembered: $remembered, isMarked: $isMarked, pronunciation: $pronounciation, studied: $isStudied}';
  }

  static String encode(List<WordModel> wordList) {
    return json.encode(
        wordList.map<Map<String, dynamic>>((word) => toMap(word)).toList());
  }

  static Map<String, dynamic> toMap(WordModel word) {
    return {
      "stt": word.getStt,
      "pronounciation": word.getPronounciation,
      "definition": word.getDefinition,
      "word": word.getWord,
      "isMarked": (word.getIsMarked == true) ? 1 : 0,
      "remembered": word.getRemembered,
      "isStudied": (word.getIsStudied == true) ? 1 : 0,
    };
  }

  static List<WordModel> decode(String wordList) =>
      (json.decode(wordList) as List<dynamic>)
          .map<WordModel>((item) => WordModel.fromJson(item))
          .toList();

  factory WordModel.fromJson(Map<String, dynamic> jsonData) {
    return WordModel(
      stt: jsonData['stt'],
      definition: jsonData['definition'],
      word: jsonData['word'],
      remembered: jsonData['remembered'],
      pronounciation: jsonData['pronounciation'],
      isMarked: jsonData['isMarked'],
      isStudied: jsonData['isStudied'],
    );
  }
}

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

  WordModel({this.definition, this.pronounciation, this.stt, this.word});
}

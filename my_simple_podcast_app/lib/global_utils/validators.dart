class Validators {
  // creation of singleton
  static final Validators _validators = Validators.internal();
  Validators.internal();
  factory Validators() {
    return _validators;
  }
  // regex, static since people say there is alot of overhead
  // for creation of regex
  static final validSearchCharacters = RegExp(r'^[a-zA-Z0-9 ]+$');

  static bool isAlphaNumerical(String value) {
    return validSearchCharacters.hasMatch(value);
  }
}

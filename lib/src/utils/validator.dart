class Validator {
  bool isValidAmount(String value) {
    double val = double.tryParse(value) ?? -1;
    if (val is double && val >= 0) return true;
    return false;
  }

  int isValidStringPositiveInteger(String value) {
    int val = int.tryParse(value) ?? -1;
    if ( val >= 0) {
      return val;
    }
    return -1;
  }

  bool isValidInteger(String value) {
    int val = int.tryParse(value) ?? -1;
    if (val >= 0) return true;
    return false;
  }

  // Checks if string is null or empty
  bool isNullOrEmpty(String text) => text.trim() == '';
}

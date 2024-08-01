String addAbsoluteValueText(int value) {
  String retString = '';
  if (value == 0) {
    retString = '';
  } else if (value > 0) {
    retString = '+$value';
  } else {
    retString = '$value';
  }
  return retString;
}

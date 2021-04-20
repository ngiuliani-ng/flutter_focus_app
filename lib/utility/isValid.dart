/// Inizialmente il bool [valid] viene inizializzato true all'interno della Function [isValidBlock].
///
/// Quando anche una solo un [condition] sarà true, [valid] diventerà false.
///
/// ```dart
/// valid = valid && !condition;
/// valid = true  && false  /// return valid = false
/// valid = true  && true   /// return valid = true
/// valid = false && false  /// return valid = false
/// valid = false && true   /// return valid = false
/// ```
///
/// ```dart
/// final valid = isValidBlock((bool Function(bool, Function) when) {
///   when(condition, () {});
///   when(condition, () {});
/// });
/// ```
bool isValidBlock(Function block) {
  bool valid = true;
  final when = (bool condition, Function fn) {
    valid = valid && !condition;
    if (condition && fn != null) fn();
  };

  block(when);
  return valid;
}

bool isValidEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

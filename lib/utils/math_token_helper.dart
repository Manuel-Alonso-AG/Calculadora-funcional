import 'dart:math';

class MathTokenHelper {
  static const Map<String, double> _mathConstantsMap = {
    'π': pi,
    'e': e,
    'φ': 1.618033988749895,
  };

  static const Map<String, int> _precedenceMap = {
    '+': 1,
    '-': 1,
    '*': 2,
    '/': 2,
    '^': 3,
  };

  static bool isNumber(String char) {
    if (char.isEmpty) return false;
    return double.tryParse(char) != null;
  }

  static bool isOperator(String char) {
    const operatios = {'+', '-', '/', '*', '^'};
    return operatios.contains(char);
  }

  static bool isParenthesis(String char) {
    return char == '(' || char == ')';
  }

  static bool isOperation(String char) {
    return isOperator(char) || isParenthesis(char);
  }

  static double getMathConstant(String char) {
    return _mathConstantsMap[char]!;
  }

  static int getPrecedence(String c) {
    return _precedenceMap[c]!;
  }

  static bool comparePrecedence(String c1, String c2) {
    return getPrecedence(c1) >= getPrecedence(c2);
  }
}

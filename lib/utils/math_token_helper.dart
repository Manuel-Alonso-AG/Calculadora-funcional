class MathTokenHelper {
  static const Map<String, int> _precedenceMap = {
    '+': 1,
    '-': 1,
    '*': 2,
    '/': 2,
    '^': 3,
  };

  static bool isNumber(String c) {
    if (c.isEmpty) return false;
    return double.tryParse(c) != null;
  }

  static bool isOperator(String c) {
    const operatios = {'+', '-', '/', '*', '^'};
    return operatios.contains(c);
  }

  static bool isParenthesis(String c) {
    return c == '(' || c == ')';
  }

  static bool isOperation(String c) {
    return isOperator(c) || isParenthesis(c);
  }

  static int getPrecedence(String c) {
    return _precedenceMap[c]!;
  }

  static bool comparePrecedence(String c1, String c2) {
    return getPrecedence(c1) >= getPrecedence(c2);
  }
}

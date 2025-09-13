import 'package:calculadora/utils/math_token_helper.dart';

class ExpressionTokenizer {
  static List<String> tokenize(String expression) {
    if (expression.trim().isEmpty) {
      throw Exception("Campo vacio");
    }

    final List<String> tokens = <String>[];
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < expression.length; i++) {
      final String currentChar = expression[i];

      if (MathTokenHelper.isOperation(currentChar)) {
        _processToken(tokens, buffer, currentChar, expression, i);
      } else if (currentChar.trim().isNotEmpty) {
        buffer.write(currentChar);
      }
    }

    if (buffer.isNotEmpty) {
      tokens.add(buffer.toString());
    }

    return _validate(tokens);
  }

  static void _processToken(List<String> tokens, StringBuffer buffer,
      String currentChar, String expression, int idx) {
    if (buffer.isNotEmpty) {
      tokens.add(buffer.toString());
      buffer.clear();
    }

    if (currentChar == '-') {
      if (_isNegativeSing(expression, idx)) {
        buffer.write('-');
        return;
      }
    }

    tokens.add(currentChar);
  }

  static bool _isNegativeSing(String expression, int idx) {
    if (idx == 0) return true;

    final String prevChar = expression[idx - 1];
    return MathTokenHelper.isOperator(prevChar) || prevChar == '(';
  }

  static List<String> _validate(List<String> tokens) {
    if (tokens.isEmpty) {
      throw Exception("Syntax Error");
    }

    int parenthesesCount = 0;

    for (String token in tokens) {
      if (token == '(') {
        parenthesesCount++;
      }
      if (token == ')') {
        parenthesesCount--;
      }

      if (parenthesesCount < 0) {
        throw Exception("Syntax Error en parentesis");
      }
    }

    if (parenthesesCount != 0) {
      throw Exception("Syntax Error en parentesis");
    }

    return tokens;
  }
}

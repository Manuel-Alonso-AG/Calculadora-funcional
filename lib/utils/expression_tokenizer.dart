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
        _checkImplicitMultiplication(
            tokens, buffer, currentChar, expression, i);
        buffer.write(currentChar);
      }
    }

    if (buffer.isNotEmpty) {
      tokens.add(buffer.toString());
    }

    return _validate(tokens);
  }

  static void _checkImplicitMultiplication(List<String> tokens,
      StringBuffer buffer, String currentChar, String expression, int idx) {
    if (buffer.isEmpty && idx > 0) {
      final String prevChar = expression[idx - 1];

      /* TODO: Aqui se debe de implementar la condicion si el actual caractar es una constante matematica. No olvidar*/
      if ((MathTokenHelper.isNumber(prevChar) || prevChar == ')') &&
          (currentChar == '(')) {
        tokens.add('*');
      }
    }
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

    if (currentChar == '(') {
      _openingParenthesis(tokens, expression, idx);
    }

    tokens.add(currentChar);

    if (currentChar == ')') {
      _closingParenthesis(tokens, expression, idx);
    }
  }

  static void _openingParenthesis(
      List<String> tokens, String expression, int idx) {
    if (idx > 0) {
      final String prevChar = expression[idx - 1];

      /* TODO: Aqui se debe de implementar la condicion si el actual caractar es una constante matematica. No olvidar*/
      if (MathTokenHelper.isNumber(prevChar) || prevChar == ')') {
        tokens.add('*');
      }
    }
  }

  static void _closingParenthesis(
      List<String> tokens, String expression, int idx) {
    if (idx < expression.length - 1) {
      final String nextChar = expression[idx + 1];

      /* TODO: Aqui se debe de implementar la condicion si el actual caractar es una constante matematica. No olvidar*/
      if (MathTokenHelper.isNumber(nextChar) || nextChar == '(') {
        tokens.add('*');
      }
    }
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

    print('Tokens generados:');
    for (var tok in tokens) {
      print('  "$tok"');
    }

    return tokens;
  }
}

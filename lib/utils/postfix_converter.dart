import 'package:calculadora/utils/expression_tokenizer.dart';
import 'package:calculadora/utils/math_token_helper.dart';

class PostfixConverter {
  static List<String> convert(String expression) {
    final List<String> output = <String>[];
    final List<String> operationsStack = <String>[];
    List<String> tokens = ExpressionTokenizer.tokenize(expression);

    for (String token in tokens) {
      if (MathTokenHelper.isNumber(token)) {
        output.add(token);
      } else if (token == '(') {
        operationsStack.add(token);
      } else if (token == ')') {
        _closeParenthesis(output, operationsStack);
      } else if (MathTokenHelper.isOperator(token)) {
        _processOperator(token, output, operationsStack);
      }
    }

    while (operationsStack.isNotEmpty) {
      final op = operationsStack.removeLast();
      if (op == '(' || op == ')') {
        throw Exception("Syntax Error en parentesis");
      }
      output.add(op);
    }

    return output;
  }

  static void _closeParenthesis(
      List<String> output, List<String> operationsStack) {
    while (operationsStack.isNotEmpty && operationsStack.last != '(') {
      output.add(operationsStack.removeLast());
    }

    if (operationsStack.isEmpty) {
      throw Exception("Syntax Error en parentesis");
    }

    operationsStack.removeLast();
  }

  static void _processOperator(
      String token, List<String> output, List<String> operationsStack) {
    while (operationsStack.isNotEmpty &&
        operationsStack.last != '(' &&
        MathTokenHelper.comparePrecedence(operationsStack.last, token)) {
      output.add(operationsStack.removeLast());
    }
    operationsStack.add(token);
  }
}

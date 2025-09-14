import 'dart:math';

import 'package:calculadora/model/node_class.dart';
import 'package:calculadora/utils/math_token_helper.dart';
import 'package:calculadora/utils/postfix_converter.dart';

class TreeCalculator {
  double evaluateTree(Node node) {
    if (node.type == NodeType.number) {
      final double? value = double.tryParse(node.value);
      if (value == null) {
        throw Exception('Numero $value invalido');
      }
      return value;
    }

    if (node.rightNode == null || node.leftNode == null) {
      throw Exception("Error campo de sintaxis");
    }

    final double left = evaluateTree(node.leftNode!);
    final double right = evaluateTree(node.rightNode!);

    return _proccesOperation(node.value, left, right);
  }

  double _proccesOperation(String operator, double left, double right) {
    switch (operator) {
      case '+':
        return left + right;
      case '-':
        return left - right;
      case '*':
        return left * right;
      case '/':
        if (right == 0) {
          throw Exception("División por cero");
        }
        return left / right;
      case '^':
        return _powerOperation(left, right);
      default:
        throw Exception("Operador $operator invalido");
    }
  }

  double _powerOperation(double base, double exponent) {
    if (exponent == 0) {
      return 1;
    }
    return pow(base, exponent).toDouble();
  }

  Node generateTree(String expression) {
    final List<Node> nodeStack = <Node>[];
    final List<String> postfixTokens = PostfixConverter.convert(expression);

    if (postfixTokens.isEmpty) {
      throw Exception("Error campo vacio");
    }

    for (String token in postfixTokens) {
      if (token.trim().isEmpty) {
        continue;
      }

      if (MathTokenHelper.isNumber(token)) {
        final Node numberNode = Node(type: NodeType.number, value: token);
        nodeStack.add(numberNode);
      } else if (MathTokenHelper.isOperation(token)) {
        if (nodeStack.length < 2) {
          throw Exception("Se necesita de numeros");
        }

        final Node operationNode = Node(type: NodeType.operation, value: token);
        operationNode.rightNode = nodeStack.removeLast();
        operationNode.leftNode = nodeStack.removeLast();
        nodeStack.add(operationNode);
      }
    }

    if (nodeStack.length != 1) {
      throw Exception("Expresión malformada");
    }

    return nodeStack.single;
  }

  double evaluate(String expression) {
    final Node tree = generateTree(expression);
    return evaluateTree(tree);
  }
}

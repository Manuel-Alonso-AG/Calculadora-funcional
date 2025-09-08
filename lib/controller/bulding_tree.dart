import 'dart:math';
/*filadeputa*/
import 'package:calculadora/model/node_class.dart';

bool isNumber(String c) {
  return double.tryParse(c) != null;
}

bool isOperation(String c) {
  return c == "+" ||
      c == "-" ||
      c == "/" ||
      c == "*" ||
      c == "^" ||
      c == "(" ||
      c == ")";
}

int precedence(String op) {
  if (op == "+" || op == "-") return 1;
  if (op == "*" || op == "/") return 2;
  if (op == "^") return 3;
  return 0;
}

List<String> infixToPostfix(String expression) {
  List<String> output = [];
  List<String> stack = [];
  List<String> tokens = tokenize(expression);

  for (String token in tokens) {
    if (isNumber(token)) {
      output.add(token);
    } else if (token == "(") {
      stack.add(token);
    } else if (token == ")") {
      while (stack.isNotEmpty && stack.last != "(") {
        output.add(stack.removeLast());
      }
      stack.removeLast();
    } else if (isOperation(token)) {
      while (stack.isNotEmpty && precedence(stack.last) >= precedence(token)) {
        output.add(stack.removeLast());
      }
      stack.add(token);
    }
  }

  while (stack.isNotEmpty) {
    output.add(stack.removeLast());
  }

  return output;
}

/* 2-(4/6)*(4/-5)-(8^3) */
List<String> tokenize(String expression) {
  List<String> tokens = [];
  String buffer = '';

  for (int i = 0; i < expression.length; i++) {
    String c = expression[i];

    if (isOperation(c)) {
      if (buffer.isNotEmpty) {
        tokens.add(buffer);
        buffer = '';

        if (c == '-') {
          buffer = '-';

          if ((isNumber(expression[i - 1]) || expression[i - 1] == ')')) {
            c = '+';
          }
        }
      } else if (c == '-') {
        buffer = '-';

        if (i > 0 &&
            (isNumber(expression[i - 1]) || expression[i - 1] == ')')) {
          tokens.add('+');
          buffer = '-';
        } else {
          c = '';
        }
      }

      if (i > 0) {
        tokens.add(c);
      }
    } else if (c.trim().isNotEmpty) {
      buffer += c;
    }
  }

  if (buffer.isNotEmpty) {
    tokens.add(buffer);
  }

  for (String t in tokens) {
    print(t);
  }

  return tokens;
}

class BuldingTree {
  double evaluateTree(Node node) {
    if (node.type == NodeType.number) {
      return double.parse(node.value);
    }

    double leftValue = evaluateTree(node.leftNode!);
    double rightValue = evaluateTree(node.rightNode!);

    switch (node.value) {
      case "+":
        return leftValue + rightValue;
      case "-":
        return leftValue - rightValue;
      case "*":
        return leftValue * rightValue;
      case "/":
        if (rightValue == 0) {
          throw Exception("Syntax Error");
        }
        return leftValue / rightValue;
      case "^":
        if (leftValue == 0 && rightValue <= 0) {
          throw Exception("Syntax Error");
        } else if (leftValue < 0 && rightValue % 1 != 0) {
          throw Exception("Syntax Error");
        }
        return pow(leftValue, rightValue).toDouble();
      default:
        throw Exception("Unknown operator: ${node.value}");
    }
  }

  Node generateTree(String expression) {
    List<Node> stack = [];
    List<String> tokens = infixToPostfix(expression);

    for (String token in tokens) {
      if (token.isEmpty) continue;

      if (isNumber(token)) {
        Node node = Node(value: token, type: NodeType.number);
        node.rightNode = null;
        node.leftNode = null;
        stack.add(node);
      } else {
        Node node = Node(value: token, type: NodeType.operation);
        node.rightNode = stack.removeLast();
        node.leftNode = stack.removeLast();
        stack.add(node);
      }
    }
    return stack.isEmpty
        ? Node(value: '', type: NodeType.number)
        : stack.single;
  }
}

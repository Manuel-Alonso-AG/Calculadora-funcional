// ignore_for_file: public_member_api_docs, sort_constructors_first
class Node {
  late String value;
  late NodeType type;

  Node({
    required this.value,
    required this.type,
  });

  Node? rightNode;
  Node? leftNode;
}

enum NodeType { operation, number }

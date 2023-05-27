import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MatchDetail extends StatefulWidget {
  String detailMatch;
  MatchDetail({super.key,
  required this.detailMatch,
  });

  @override
  State<MatchDetail> createState() => _MatchDetailState();
}

class _MatchDetailState extends State<MatchDetail> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
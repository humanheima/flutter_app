import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

///
/// Crete by dumingwei on 2019-09-12
/// Desc: 包管理
///

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WordPair wordPair = WordPair.random();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(wordPair.toString()),
    );
  }
}

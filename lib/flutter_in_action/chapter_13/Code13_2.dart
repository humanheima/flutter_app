import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019-10-15.
/// Desc:
///
class Code13_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('13.2 实现Localizations'),
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}

class DemoLocalizations {
  bool isZh = false;

  DemoLocalizations(this.isZh);

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of(context, DemoLocalizations);
  }

  String get title {
    return isZh ? "Flutter应用" : 'Flutter App';
  }
}

///Delegate类的职责是在Locale改变时加载新的Locale资源，所以它有一个load方法，
///Delegate类需要继承自LocalizationsDelegate类，实现相应的接口。

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    print('DemoLocalizationsDelegate load $locale');
    return SynchronousFuture<DemoLocalizations>(
        DemoLocalizations(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) {
    return false;
  }
}

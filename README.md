Mini.parser
-----------

Package for Dart. Read web-page on url and return decoded string for make dom selectors.

Return Object type Map:

```dart
{.repo: [Springel, jetbrains-webstorm-theme, angulardart.org, for_me, FruTrade, dart-up-and-running, highlight-selected, heroku-buildpack-dart],

.repo-description: [Elements which following cursor on limit destination, with spring effect, theme for webstorm, Website for AngularDart, В плане обновить свой сайт, Фруктовая компания, Перевод книги Dart: Up and running, Highlights the current word selected when double clicking, Heroku buildpack for Dart]}

```

Use like this:

```dart
import 'package:mini.parser/parser.dart';

main() async {
  MiniParser Parser = new MiniParser();
  var content = await Parser.getContentFrom('https://github.com/Rasarts', selectors: ['.repo', '.repo-description']);

  print(content);
}

```

If you need decoded page from CP1251, use thrid bool parametr ***cp1251*** like this:

```dart
Parser.getContentFrom('https://github.com/Rasarts', selectors: ['.repo', '.repo-description'], cp1251: true);

```

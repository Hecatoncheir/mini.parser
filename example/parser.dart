import 'package:mini.parser/parser.dart';

main() async {
  MiniParser Parser = new MiniParser();
  // var content = await Parser.getContentFrom('https://github.com/Rasarts', selectors: ['.repo', '.repo-description']);
  //
  // print(content);

  var contentFromTagAttributes = await Parser.getContentFromTagsAttributes('https://github.com/explore', selectors: ['.author-gravatar'], attributes: ['src','alt']);

  print(contentFromTagAttributes);
}

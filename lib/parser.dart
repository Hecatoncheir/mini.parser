library mini.parser;

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class MiniParser {
  getContentFrom(String uri, {List selectors}) async {
    var htmlForParse, content, html;

    htmlForParse = await http.read(uri);
    html = parse(htmlForParse);
    content = new Map();

    selectFor(String selector){
      var contentListFromSelector;
      List nodes = new List();

      makeMapContent(node){
        nodes.add(node.text);
        content[selector] = nodes;
      }

      contentListFromSelector = html.querySelectorAll(selector);
      contentListFromSelector.forEach(makeMapContent);
    }

    selectors.forEach(selectFor);

    //content = html.querySelector(selectors).text;

    return content;

  }
}

library mini.parser;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

abstract class Parser {
  getContentFrom(String uri, {List selectors});
  getContentFromTag();
}

class MiniParser implements Parser {
  getContentFrom(String uri, {List selectors}) async {
    var htmlForParse, content, html;

    Map headers = {'Content-type':'text/html', 'charset':'windows-1251'};

    htmlForParse = await http.read(uri, headers: headers);

    html = parse(htmlForParse, encoding:'utf-8');
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

    return content;

  }
}

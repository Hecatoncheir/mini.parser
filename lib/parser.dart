library mini.parser;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

part 'cp1251.dart';

abstract class Parser {
  getContentFrom(String uri, {List selectors});
  // getContentFromTag();
}

class MiniParser implements Parser {
  getContentFrom(String uri, {List selectors, bool cp1251:false}) async {
    var htmlForParse, content, html, bytes;

    bytes = await http.readBytes(uri);

    if(cp1251){
      htmlForParse = decodeCp1251(bytes);
    } else {
      htmlForParse = UTF8.decode(bytes);
    }

    html = parse(htmlForParse);
    content = new Map();

    selectFor(String selector) {
      var contentListFromSelector;
      List nodes = new List();

      makeMapContent(node) {
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

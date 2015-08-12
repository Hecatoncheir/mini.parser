library mini.parser;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

part 'cp1251.dart';

abstract class Parser {
  getContentFrom(String uri, {List selectors});
  getContentFromTagsAttributes(String uri,{List selectors, List attributes});
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

  getContentFromTagsAttributes(String uri,{List selectors, List attributes}) async {

    var bytes, htmlForParse, html, content;

    bytes = await http.readBytes(uri);
    htmlForParse = UTF8.decode(bytes);
    html = parse(htmlForParse);
    content = new Map();

    selectFor(String selector) {
      List contentListFromSelector;
      List nodes = new List();

      //int selectorIndex = selectors.indexOf(selector);
      
      makeMapContent(node) {
      List selectorResult = new List();

        attributes.forEach((selector){
          selectorResult.add(node.attributes[selector]);
        });

        nodes.add(selectorResult);
        //nodes.add(node.attributes['${attributes[selectorIndex]}']);
        content[selector] = nodes;
      }


      contentListFromSelector = html.querySelectorAll(selector);
      contentListFromSelector.forEach(makeMapContent);

      content[selector] = nodes;
    }

    selectors.forEach(selectFor);

    return content;
  }

}

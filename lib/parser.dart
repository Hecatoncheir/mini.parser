library Parser;

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class Parser {
  getContentFrom(String uri, {List selectors}) async {
    var htmlForParse, content, html;

    htmlForParse = await http.read(uri);
    html = parse(htmlForParse);

    //content = html.querySelector(selectors).text;

    return content;

  }
}

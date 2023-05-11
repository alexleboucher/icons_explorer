import 'dart:io';
import 'dart:math';

import 'package:icons_explorer/html_templates/icon_item.dart';
import 'package:icons_explorer/html_templates/icons_explorer.dart';
import 'package:path/path.dart';

/// Get all SVG files from directory
List<FileSystemEntity> getDirSvgFiles(String dirPath) {
  final dir = Directory(dirPath);
  return dir
      .listSync()
      .where((file) => file is File && extension(file.path) == '.svg')
      .toList();
}

/// Read file asynchronously ans returns content as string
Future<String> readFileAsync(String filePath) {
  final file = File(filePath);
  return file.readAsString();
}

/// Form a SVG file content to a HTML icon item
String formatFileContentToIconItem(IconData iconData) {
  final idRegex = RegExp(r'id="([^"]*)"');

  String content = iconData.content;
  for (final match in idRegex.allMatches(iconData.content)) {
    content = content.replaceAll(
        match.group(1)!, Random().nextInt(1000000).toString());
  }
  return iconItemHtml
      .replaceAll('<!-- SVG_PLACE -->', content)
      .replaceAll('<!-- ICON_NAME_PLACE -->', iconData.name);
}

/// Create the icons explorer html
File createIconsExplorerHtml(List<String> iconsItems) {
  final buffer = StringBuffer();
  buffer.writeAll(iconsItems, '\n');
  final htmlString =
      iconsExplorerHtml.replaceAll('<!-- ICONS_PLACE -->', buffer.toString());

  final outputPath = join(Directory.systemTemp.path, 'icons_explorer.html');

  final htmlFile = File(outputPath);
  htmlFile.createSync(recursive: true);
  htmlFile.writeAsStringSync(htmlString);

  return htmlFile;
}

/// Open file in browser
void openFileInBrowser(File file) {
  switch (Platform.operatingSystem) {
    case "linux":
      Process.run("x-www-browser", [file.absolute.path]);
      break;
    case "macos":
      Process.run("open", [file.absolute.path]);
      break;
    case "windows":
      Process.run("explorer", [file.absolute.path]);
      break;
    default:
      break;
  }
}

class IconData {
  IconData({
    required this.content,
    required this.name,
  });

  String content;
  String name;
}

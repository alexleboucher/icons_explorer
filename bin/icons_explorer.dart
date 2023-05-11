import 'dart:io';

import 'package:args/args.dart';
import 'package:icons_explorer/icons_explorer.dart';
import 'package:path/path.dart';

const dirPath = 'dirPath';

void main(List<String> arguments) async {
  exitCode = 0;

  final parser = ArgParser()
    ..addOption(dirPath,
        abbr: 'd', mandatory: true, help: 'The icons directory path');

  ArgResults argResults = parser.parse(arguments);
  final iconsDirPath = argResults[dirPath];

  final files = getDirSvgFiles(iconsDirPath);

  final readFileFutures = files.map((e) => readFileAsync(e.path));
  List<String> fileContents = await Future.wait(readFileFutures);

  // Transforms a file to a IconData class
  final iconsData = files
      .asMap()
      .entries
      .map((e) => IconData(
            content: fileContents[e.key],
            name: basenameWithoutExtension(e.value.path),
          ))
      .toList();

  // Sort the iconDatas by name alphabetically
  iconsData.sort((a, b) => a.name.compareTo(b.name));

  final iconItems =
      iconsData.map((e) => formatFileContentToIconItem(e)).toList();

  final file = createIconsExplorerHtml(iconItems);
  openFileInBrowser(file);
}

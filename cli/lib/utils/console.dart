import 'dart:io';

class Console {
  static void clear() {
    if (Platform.isWindows) {
      // Clear command for Windows
      print(Process.runSync("cls", [], runInShell: true).stdout);
    } else {
      // Clear command for Linux and macOS
      print(Process.runSync("clear", [], runInShell: true).stdout);
    }
  }

  static int choice() {
    stdout.write('Enter your choice: ');
    return int.tryParse(stdin.readLineSync()!) ?? -1;
  }
}
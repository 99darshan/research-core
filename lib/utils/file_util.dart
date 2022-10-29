class FileUtil {
  static fileName(String path) {
    return path.split('/').last.replaceFirst('.pdf', '').replaceAll('_', ' ');
  }
}

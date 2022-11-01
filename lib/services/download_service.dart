import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  static download(String url, String fileName,
      {dynamic onComplete, dynamic onError}) async {
    try {
      final dio = Dio();
      final savePath =
          '${(await getApplicationDocumentsDirectory()).path}/research_core_pdfs/${fileName.trim().replaceAll(' ', '_')}.pdf';

      // NOTE: User-Agent is required because dio returns 403 without it for some URLs
      dio
          .download(
            url,
            savePath,
            cancelToken: CancelToken(),
            options: Options(headers: {
              io.HttpHeaders.userAgentHeader: 'PostmanRuntime/7.29.0'
            }),
          )
          .then(onComplete)
          .catchError(onError);
    } catch (_) {
      print('Error Downloading File');
    }
  }

  static Future<List<io.FileSystemEntity>> allDownloads() async {
    final dirPath =
        '${(await getApplicationDocumentsDirectory()).path}/research_core_pdfs';
    final dir = io.Directory(dirPath);
    if (dir.existsSync()) {
      return dir.listSync();
    }

    return [];
  }
}

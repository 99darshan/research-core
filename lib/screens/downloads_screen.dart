import 'dart:io';

import 'package:flutter/material.dart';
import 'package:researchcore/components/full_screen_info.dart';
import 'package:researchcore/screens/pdf_view_screen.dart';
import 'package:researchcore/services/download_service.dart';
import 'package:researchcore/utils/theme_util.dart';

import '../utils/file_util.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  late List<FileSystemEntity> _downloads = [];
  bool _initializingDownloads = true;

  @override
  void initState() {
    _initAllDownloads();
    super.initState();
  }

  _initAllDownloads() async {
    var allDownloads = await DownloadService.allDownloads();
    setState(() {
      _downloads = allDownloads;
      _initializingDownloads = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),
      body: _initializingDownloads
          ? const SizedBox()
          : _downloads.isEmpty
              ? const FullScreenInfo(
                  iconName: Icons.integration_instructions_outlined,
                  title: 'Empty downloads folder!',
                  subTitle: 'Downloaded articles will show up here.',
                )
              : ListView.builder(
                  itemCount: _downloads.length,
                  itemBuilder: (context, index) {
                    final filePath = _downloads[index].path;

                    return GestureDetector(
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 2.0),
                          child: ListTile(
                            leading: null,
                            title: Text(FileUtil.fileName(filePath)),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: ThemeUtil.primaryColor,
                              ),
                              onPressed: () {
                                _downloads[index].deleteSync();
                                _downloads.removeAt(index);
                                setState(() {
                                  _downloads = _downloads;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PdfViewScreen(
                                filePath: filePath,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}

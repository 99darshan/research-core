import 'dart:io';

import 'package:flutter/material.dart';
import 'package:researchcore/components/full_screen_info.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatefulWidget {
  final String? pdfUrl;
  final String? filePath;
  const PdfViewScreen({Key? key, this.pdfUrl, this.filePath}) : super(key: key);

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late bool _pdfLoadError;

  @override
  void initState() {
    _pdfLoadError = false;
    super.initState();
  }

  Widget _fromNetwork() {
    return SfPdfViewer.network(
      '${widget.pdfUrl}',
      onDocumentLoadFailed: (details) {
        setState(() {
          _pdfLoadError = true;
        });
      },
      key: _pdfViewerKey,
    );
  }

  Widget _fromFile() {
    return SfPdfViewer.file(
      File('${widget.filePath}'),
      onDocumentLoadFailed: (details) {
        setState(() {
          _pdfLoadError = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF View'),
      ),
      body: _pdfLoadError
          ? const FullScreenInfo(
              iconName: Icons.broken_image_rounded,
              title: 'Apologies! Error loading PDF file.',
              subTitle: '')
          : (widget.pdfUrl?.isEmpty ?? true)
              ? _fromFile()
              : _fromNetwork(),
    );
  }
}

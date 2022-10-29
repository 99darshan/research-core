import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'PDF View'), // TODO: should this be article title or download file name??
      ),
      body: (widget.pdfUrl?.isNotEmpty ?? false)
          ? SfPdfViewer.network(
              '${widget.pdfUrl}',
              onDocumentLoadFailed: (details) {
                // TODO: use state and render a different component with error message
                // description has a readable method
                // allow try again button??
                print(
                    'document load failed ${details.description} ${details.error}');
              },
              key: _pdfViewerKey,
            )
          : const SizedBox(),
    );
  }
}

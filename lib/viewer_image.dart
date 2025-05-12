/*
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

class PDFViewerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pdfPath = Provider.of<NoteProvider>(context).selectedPdfPath;

    if (pdfPath == null) {
      return Scaffold(
        appBar: AppBar(title: Text("PDF Viewer")),
        body: Center(child: Text("No PDF Selected")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("PDF Viewer")),
      body: PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
      ),
    );
  }
}
*/


// second
/*
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

class PDFViewerPage extends StatefulWidget {
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? _pdfViewController;

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final pdfPath = noteProvider.selectedPdfPath;

    if (pdfPath == null) {
      return Scaffold(
        appBar: AppBar(title: Text("PDF Viewer")),
        body: Center(child: Text("No PDF Selected")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page ${noteProvider.currentPage + 1} / ${noteProvider.totalPages}",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onRender: (pages) {
          noteProvider.setPageInfo(noteProvider.currentPage, pages ?? 0);
        },
        onViewCreated: (controller) {
          _pdfViewController = controller;
        },
        onPageChanged: (int? page, int? total) {
          if (page != null && total != null) {
            noteProvider.setPageInfo(page, total);
          }
        },
      ),
    );
  }
}
*/

// third
/*
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

class PDFViewerPage extends StatefulWidget {
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? _pdfViewController;
  bool _isReady = false;

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final pdfPath = noteProvider.selectedPdfPath;

    if (pdfPath == null) {
      return Scaffold(
        appBar: AppBar(title: Text("PDF Viewer")),
        body: Center(child: Text("No PDF Selected")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page ${noteProvider.currentPage + 1} / ${noteProvider.totalPages}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: pdfPath,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            onRender: (pages) {
              noteProvider.setPageInfo(noteProvider.currentPage, pages ?? 0);
              setState(() {
                _isReady = true;
              });
            },
            onViewCreated: (controller) {
              _pdfViewController = controller;
            },
            onPageChanged: (int? page, int? total) {
              if (page != null && total != null) {
                noteProvider.setPageInfo(page, total);
              }
            },
          ),
          if (!_isReady)
            Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            ),
        ],
      ),
      floatingActionButton: _isReady
          ? FloatingActionButton.extended(
        onPressed: () {
          _pdfViewController?.setPage(0);
        },
        label: Text("Start Over"),
        icon: Icon(Icons.first_page),
        backgroundColor: Colors.teal,
      )
          : null,
    );
  }
}
*/


// fourth
/*
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

class PDFViewerPage extends StatefulWidget {
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? _pdfViewController;
  bool _isReady = false;

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final pdfPath = noteProvider.selectedPdfPath;

    if (pdfPath == null) {
      return Scaffold(
        appBar: AppBar(title: Text("PDF Viewer")),
        body: Center(child: Text("No PDF Selected")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page ${noteProvider.currentPage + 1} / ${noteProvider.totalPages}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Stack(
        children: [
          // Main PDF viewer
          PDFView(
            filePath: pdfPath,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            onRender: (pages) {
              noteProvider.setPageInfo(noteProvider.currentPage, pages ?? 0);
              setState(() {
                _isReady = true;
              });
            },
            onViewCreated: (controller) {
              _pdfViewController = controller;
            },
            onPageChanged: (int? page, int? total) {
              if (page != null && total != null) {
                noteProvider.setPageInfo(page, total);
              }
            },
          ),

          // Loading indicator
          if (!_isReady)
            Center(
              child: CircularProgressIndicator(color: Colors.teal),
            ),

          // Vertical page slider
          if (_isReady && noteProvider.totalPages > 1)
            Positioned(
              right: 12,
              top: 80,
              bottom: 80,
              child: Column(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'Page ${noteProvider.currentPage + 1} / ${noteProvider.totalPages}',
                      style: TextStyle(
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  RotatedBox(
                    quarterTurns: 3,
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 14),
                      ),
                      child: Slider(
                        activeColor: Colors.teal,
                        inactiveColor: Colors.teal.shade100,
                        value: (noteProvider.currentPage + 1).toDouble(),
                        min: 1,
                        max: noteProvider.totalPages.toDouble(),
                        divisions: noteProvider.totalPages - 1,
                        onChanged: (value) {
                          final pageIndex = value.toInt() - 1;
                          _pdfViewController?.setPage(pageIndex);
                          noteProvider.setPageInfo(pageIndex, noteProvider.totalPages);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

*/


//six
/*
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

class PDFViewerPage extends StatefulWidget {
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? _pdfViewController;
  bool _isReady = false;
  double _zoom = 1.0; // Custom zoom simulation

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final pdfPath = noteProvider.selectedPdfPath;

    if (pdfPath == null) {
      return Scaffold(
        appBar: AppBar(title: Text("PDF Viewer")),
        body: Center(child: Text("No PDF Selected")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page ${noteProvider.currentPage + 1} / ${noteProvider.totalPages}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.zoom_in),
            tooltip: "Zoom In",
            onPressed: () {
              setState(() {
                _zoom = (_zoom + 0.1).clamp(1.0, 2.5);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            tooltip: "Zoom Out",
            onPressed: () {
              setState(() {
                _zoom = (_zoom - 0.1).clamp(1.0, 2.5);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border),
            tooltip: "Bookmarks (Not supported)",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Bookmark view is not supported in this viewer."),
              ));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Transform.scale(
            scale: _zoom,
            child: PDFView(
              filePath: pdfPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              onRender: (pages) {
                noteProvider.setPageInfo(noteProvider.currentPage, pages ?? 0);
                setState(() {
                  _isReady = true;
                });
              },
              onViewCreated: (controller) {
                _pdfViewController = controller;
              },
              onPageChanged: (int? page, int? total) {
                if (page != null && total != null) {
                  noteProvider.setPageInfo(page, total);
                }
              },
            ),
          ),

          // Loading indicator
          if (!_isReady)
            Center(child: CircularProgressIndicator(color: Colors.teal)),

          // Vertical page slider
          if (_isReady && noteProvider.totalPages > 1)
            Positioned(
              right: 12,
              top: 80,
              bottom: 80,
              child: Column(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'Page ${noteProvider.currentPage + 1} / ${noteProvider.totalPages}',
                      style: TextStyle(
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  RotatedBox(
                    quarterTurns: 3,
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 14),
                      ),
                      child: Slider(
                        activeColor: Colors.teal,
                        inactiveColor: Colors.teal.shade100,
                        value: (noteProvider.currentPage + 1).toDouble(),
                        min: 1,
                        max: noteProvider.totalPages.toDouble(),
                        divisions: noteProvider.totalPages - 1,
                        onChanged: (value) {
                          final pageIndex = value.toInt() - 1;
                          _pdfViewController?.setPage(pageIndex);
                          noteProvider.setPageInfo(pageIndex, noteProvider.totalPages);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),

      floatingActionButton: _isReady
          ? FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        icon: Icon(Icons.input),
        label: Text('Go to Page'),
        onPressed: () => _showJumpToPageDialog(context, noteProvider),
      )
          : null,
    );
  }

  void _showJumpToPageDialog(BuildContext context, NoteProvider noteProvider) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Go to Page"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter page number",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: Text("Go"),
            onPressed: () {
              final page = int.tryParse(controller.text) ?? 1;
              final index = (page - 1).clamp(0, noteProvider.totalPages - 1);
              _pdfViewController?.setPage(index);
              noteProvider.setPageInfo(index, noteProvider.totalPages);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

*/


//seven
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

class PDFViewerPage extends StatefulWidget {
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? _pdfViewController;
  bool _isReady = false;
  double _zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final pdfPath = noteProvider.selectedPdfPath;

    if (pdfPath == null) {
      return Scaffold(
        body: Center(child: Text("No PDF Selected")),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // PDF View with zoom
          Positioned.fill(
            child: Transform.scale(
              scale: _zoom,
              child: PDFView(
                filePath: pdfPath,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: true,
                pageFling: true,
                onRender: (pages) {
                  noteProvider.setPageInfo(noteProvider.currentPage, pages ?? 0);
                  setState(() => _isReady = true);
                },
                onViewCreated: (controller) {
                  _pdfViewController = controller;
                },
                onPageChanged: (int? page, int? total) {
                  if (page != null && total != null) {
                    noteProvider.setPageInfo(page, total);
                  }
                },
              ),
            ),
          ),

          // Loader
          if (!_isReady)
            Center(child: CircularProgressIndicator(color: Colors.teal)),

          // Right-side vertical slider
          if (_isReady && noteProvider.totalPages > 1)
            Positioned(
              right: 4,
              top: 80,
              bottom: 80,
              child: RotatedBox(
                quarterTurns: 3,
                child: SliderTheme(
                  data: SliderThemeData(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 5),
                  ),
                  child: Slider(
                    activeColor: Colors.teal,
                    inactiveColor: Colors.teal.shade100,
                    value: (noteProvider.currentPage + 1).toDouble(),
                    min: 1,
                    max: noteProvider.totalPages.toDouble(),
                    divisions: noteProvider.totalPages - 1,
                    onChanged: (value) {
                      final pageIndex = value.toInt() - 1;
                      _pdfViewController?.setPage(pageIndex);
                      noteProvider.setPageInfo(pageIndex, noteProvider.totalPages);
                    },
                  ),
                ),
              ),
            ),

          // Bottom-centered page number
          if (_isReady)
            Positioned(
              bottom: 20,
              left: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Page ${noteProvider.currentPage + 1} / ${noteProvider.totalPages}',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),

      // Floating controls
      floatingActionButton: _isReady
          ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: "jumpPage",
            backgroundColor: Colors.teal,
            icon: Icon(Icons.input),
            label: Text('Go to Page'),
            onPressed: () => _showJumpToPageDialog(context, noteProvider),
          ),
        ],
      )
          : null,
    );
  }

  void _showJumpToPageDialog(BuildContext context, NoteProvider noteProvider) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Go to Page"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter page number",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: Text("Go"),
            onPressed: () {
              final page = int.tryParse(controller.text) ?? 1;
              final index = (page - 1).clamp(0, noteProvider.totalPages - 1);
              _pdfViewController?.setPage(index);
              noteProvider.setPageInfo(index, noteProvider.totalPages);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}


// eight


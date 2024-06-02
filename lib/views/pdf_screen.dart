import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/firebase_services.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  // Add a key to identify this widget
  static final GlobalKey<_PdfScreenState> globalKey = GlobalKey<_PdfScreenState>();

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  late Future<List<Map<String, String>>> pdfFuture;

  @override
  void initState() {
    super.initState();
    pdfFuture = _firebaseService.getAllPdfUrlsAndNames();
  }

  void refreshPdfs() {
    setState(() {
      pdfFuture = _firebaseService.getAllPdfUrlsAndNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, String>>>(
        future: pdfFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No PDFs found.'));
          } else {
            final pdfs = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: pdfs.length,
                itemBuilder: (context, index) {
                  final pdf = pdfs[index];
                  return Column(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () => _launchURL(pdf['url']!),
                            child: Container(
                              color: Colors.teal.withOpacity(0.1),
                              child: Center(
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          pdf['name']!,
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
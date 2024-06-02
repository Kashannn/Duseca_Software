import 'package:flutter/material.dart';
import '../services/firebase_services.dart'; // Import your FirebaseService

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  late Future<List<Map<String, String>>> _imagesFuture;

  @override
  void initState() {
    super.initState();
    _imagesFuture = _firebaseService.getAllImagesUrlsAndNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, String>>>(
        future: _imagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No images found.'));
          } else {
            final images = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                  childAspectRatio: 0.8, // Adjust as needed
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final image = images[index];
                  return Column(
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.5), // Border color with some opacity
                              width: 1, // Border width
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            image['url']!,
                            fit: BoxFit.cover, // Ensures the image covers the container
                            width: double.infinity, // Makes the image take the full width
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          image['name']!,
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center, // Center-align the text
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
}

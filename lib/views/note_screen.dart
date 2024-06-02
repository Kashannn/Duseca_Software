import 'package:flutter/material.dart';
import '../services/firebase_services.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  late Future<List<Map<String, String>>> textFuture;

  @override
  void initState() {
    super.initState();
    textFuture = _firebaseService.getAllText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, String>>>(
        future: textFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notes found.'));
          } else {
            final texts = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: texts.length,
                itemBuilder: (context, index) {
                  final text = texts[index];
                  return Card(
                    color: Colors.black,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        text['text']!,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        fontFamily:  'kStyleGrey14400',
                        ),
                      ),
                    ),
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

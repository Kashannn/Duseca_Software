class Activity {
  String id;
  String text;
  List<String> imageUrls;
  List<String> pdfUrls;
  List<String> fileUrls;
  List<String> textUrls;

  Activity({
    required this.id,
    required this.text,
    required this.imageUrls,
    required this.pdfUrls,
    required this.fileUrls,
    required this.textUrls,
  });

  // Getter for files
  List<Map<String, dynamic>> get files {
    List<Map<String, dynamic>> filesList = [];

    // Add imageUrls to filesList
    imageUrls.forEach((url) {
      filesList.add({'type': 'image', 'url': url});
    });

    // Add pdfUrls to filesList
    pdfUrls.forEach((url) {
      filesList.add({'type': 'pdf', 'url': url});
    });

    // Add fileUrls to filesList
    fileUrls.forEach((url) {
      filesList.add({'type': 'file', 'url': url});
    });

    // Add textUrls to filesList
    textUrls.forEach((url) {
      filesList.add({'type': 'text', 'url': url});
    });

    return filesList;
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      text: json['text'],
      imageUrls: List<String>.from(json['imageUrls']),
      pdfUrls: List<String>.from(json['pdfUrls']),
      fileUrls: List<String>.from(json['fileUrls']),
      textUrls: List<String>.from(json['textUrls']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'imageUrls': imageUrls,
      'pdfUrls': pdfUrls,
      'fileUrls': fileUrls,
      'textUrls': textUrls,
    };
  }
}

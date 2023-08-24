import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSoruCevap {
  static Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
      String collectionName, String documentID) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(documentID)
            .get();
    return documentSnapshot;
  }
}

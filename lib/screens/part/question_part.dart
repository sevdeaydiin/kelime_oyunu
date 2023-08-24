import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPage {
  Future<dynamic> printFirestoreDocument(
      String collectionName, String documentId) async {
    // Firestore instance'ını alın
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Belirtilen koleksiyondan belirtilen dökümanı alın
      DocumentSnapshot snapshot =
          await firestore.collection(collectionName).doc(documentId).get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      var soru = data['soru'].toString().toUpperCase();
      print('soru: $soru');
      return soru;
    } catch (e) {
      print('Hata: $e');
    }
  }
}

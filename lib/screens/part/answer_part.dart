import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerPage {
  Future<dynamic> printAnswerDocument(
      String collectionName, String documentId) async {
    // Firestore instance'ını alın
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Belirtilen koleksiyondan belirtilen dökümanı alın
      DocumentSnapshot snapshot =
          await firestore.collection(collectionName).doc(documentId).get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var cevap = data['cevap'].toString().toUpperCase();
      return cevap;
    } catch (e) {
      print('Hata: $e');
    }
  }
}

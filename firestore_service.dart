import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getArtists() async {
    QuerySnapshot querySnapshot = await _firestore.collection('artists').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> getArtworks() async {
    QuerySnapshot querySnapshot = await _firestore.collection('artworks').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> getFavoriteItems(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> addFavorite(
      String userId, String itemId, String itemType) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(itemId)
        .set({
      'itemId': itemId,
      'itemType': itemType,
    });
  }

  Future<void> removeFavorite(String userId, String itemId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(itemId)
        .delete();
  }

  Future<bool> isFavorite(String userId, String itemId) async {
    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(itemId)
        .get();
    return doc.exists;
  }
}

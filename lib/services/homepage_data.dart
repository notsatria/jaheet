import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fetchData(data) async {
  try {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(data).get();

    if (snapshot.docs.isNotEmpty) {
      for (final DocumentSnapshot<Map<String, dynamic>> document
          in snapshot.docs) {
        final userData = document.data();
        // Lakukan sesuatu dengan data pengguna di sini
        print(userData);
      }
    } else {
      print('Koleksi "users" kosong.');
    }
  } catch (e) {
    print('Error: $e');
  }
}

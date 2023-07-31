import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jahitin/screens/seller/seller_main_screen.dart';

import '../../../constant/theme.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product-screen';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePicker picker = ImagePicker();
  List<XFile>? images = [];

  TextEditingController atasanMinPriceController = TextEditingController();
  TextEditingController atasanMaxPriceController = TextEditingController();
  TextEditingController bawahanMinPriceController = TextEditingController();
  TextEditingController bawahanMaxPriceController = TextEditingController();
  TextEditingController terusanMinPriceController = TextEditingController();
  TextEditingController terusanMaxPriceController = TextEditingController();
  TextEditingController perbaikanMinPriceController = TextEditingController();
  TextEditingController perbaikanMaxPriceController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference seller = FirebaseFirestore.instance.collection('seller');

  // Future<String?> uploadImageToFirebase(File imageFile) async {
  //   try {
  //     final uid = auth.currentUser!.uid;
  //     final sellerId =
  //         await users.doc(uid).get().then((value) => value.get('sellerId'));

  //     final fileName =
  //         'seller_${sellerId}_gallery/${DateTime.now().millisecondsSinceEpoch}.png';

  //     final storageRef = FirebaseStorage.instance.ref().child(fileName);
  //     final uploadTask = storageRef.putFile(imageFile);

  //     final TaskSnapshot snapshot = await uploadTask;

  //     if (snapshot.state == TaskState.success) {
  //       final downloadUrl = await snapshot.ref.getDownloadURL();
  //       return downloadUrl;
  //     }
  //   } catch (e) {
  //     print('Error uploading image to Firebase Storage: $e');
  //   }
  //   return null;
  // }

  // Future<void> uploadImagesAndAddToFirestore(
  //     String title, String minPrice, String maxPrice) async {
  //   final uid = auth.currentUser!.uid;
  //   final sellerId =
  //       await users.doc(uid).get().then((value) => value.get('sellerId'));

  //   if (images!.isNotEmpty) {
  //     // Upload images to Firebase Storage
  //     List<String> imageUrls = [];
  //     for (final imageFile in images!) {
  //       final imageUrl = await uploadImageToFirebase(File(imageFile.path));
  //       if (imageUrl != null) {
  //         imageUrls.add(imageUrl);
  //       }
  //     }

  //     // Clear existing jasa documents for the current seller and title
  //     await FirebaseFirestore.instance
  //         .collection('seller')
  //         .doc('$sellerId')
  //         .collection('jasa')
  //         .where('title', isEqualTo: title)
  //         .get()
  //         .then((snapshot) {
  //       for (var doc in snapshot.docs) {
  //         doc.reference.delete();
  //       }
  //     });

  //     // Create new jasa documents with the uploaded image URLs
  //     for (final imageUrl in imageUrls) {
  //       await FirebaseFirestore.instance
  //           .collection('seller')
  //           .doc('$sellerId')
  //           .collection('jasa')
  //           .add({
  //         'title': title,
  //         'minPrice': minPrice,
  //         'maxPrice': maxPrice,
  //         'imageUrl': imageUrl,
  //       });
  //     }
  //   }
  // }
  Future<void> updateMinMaxPrice(
      String title, String minPrice, String maxPrice) async {
    final uid = auth.currentUser!.uid;
    final sellerId =
        await users.doc(uid).get().then((value) => value.get('sellerId'));

    // Get the specific document reference using a query
    final querySnapshot = await FirebaseFirestore.instance
        .collection('seller')
        .doc('$sellerId')
        .collection('jasa')
        .where('title', isEqualTo: title)
        .get();

    if (querySnapshot.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('seller')
          .doc('$sellerId')
          .collection('jasa')
          .add({
        'title': title,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
      });
    }

    // Ensure that the query returned at least one document
    if (querySnapshot.docs.isNotEmpty) {
      final documentSnapshot = querySnapshot.docs.first;

      // Update the data for the specific document
      await documentSnapshot.reference.update({
        'title': title,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Seller Product Form',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SellerMainScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        elevation: 2,
      );
    }

    Widget hargaForm(String title, TextEditingController minPriceController,
        TextEditingController maxPriceController) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 140,
                  child: TextFormField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Harga Minimum',
                      hintText: 'Rp 100.000',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Text(
                  '_',
                  style: navyTextStyle.copyWith(fontSize: 30),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 140,
                  child: TextFormField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Harga Maksimum',
                      hintText: 'Rp 500.000',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Future<void> pickImages() async {
      try {
        List<XFile>? pickedImages = await picker.pickMultiImage(
          maxWidth: 1920,
          maxHeight: 1080,
          imageQuality: 80,
        );
        if (pickedImages.isNotEmpty) {
          images!.addAll(pickedImages);
          if (images!.length > 4) {
            images!.removeRange(4, images!.length);
          }
          setState(() {});
        }
      } catch (e) {
        throw Exception(e);
      }
    }

    Widget imagePicker() {
      return Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(images!.length, (index) {
                return Container(
                  margin: const EdgeInsets.only(right: 6),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: FileImage(
                        File(images![index].path),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
          ),
          MaterialButton(
            onPressed: () async {
              await pickImages();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  color: primaryColor,
                ),
                Text(
                  'Tambah Gambar',
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget galeriText() {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          '*Silahkan upload foto jasa Anda, foto ini akan tampil pada informasi produk/jasa Anda (Maksimal 4 Gambar)',
          style: navyTextStyle.copyWith(
            fontSize: 14,
            fontWeight: light,
          ),
        ),
      );
    }

    Widget submitButton() {
      return Container(
        margin: const EdgeInsets.all(20),
        height: 50,
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            try {
              updateMinMaxPrice(
                'ATASAN',
                atasanMinPriceController.text,
                atasanMaxPriceController.text,
              );
              updateMinMaxPrice(
                'BAWAHAN',
                bawahanMinPriceController.text,
                bawahanMaxPriceController.text,
              );
              updateMinMaxPrice(
                'TERUSAN',
                terusanMinPriceController.text,
                terusanMaxPriceController.text,
              );
              updateMinMaxPrice(
                'PERBAIKAN',
                perbaikanMinPriceController.text,
                perbaikanMaxPriceController.text,
              );

              // setState(() {
              //   images = null;
              // });

              // Tampilkan circullar progress indicator
              const CircularProgressIndicator();
            } catch (e) {
              print(e.toString());
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Update Data Gagal'),
                    content: const Text('Silahkan coba lagi'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } finally {
              Navigator.pushNamed(context, SellerMainScreen.routeName);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Produk Berhasil Diperbarui'),
                    content: const Text('Silahkan cek kembali produk Anda'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Submit',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: submitButton(),
        ),
        appBar: appBar(),
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 20,
          ),
          child: ListView(
            children: [
              hargaForm(
                  'ATASAN', atasanMinPriceController, atasanMaxPriceController),
              hargaForm('BAWAHAN', bawahanMinPriceController,
                  bawahanMaxPriceController),
              hargaForm('TERUSAN', terusanMinPriceController,
                  terusanMaxPriceController),
              hargaForm('PERBAIKAN', perbaikanMinPriceController,
                  perbaikanMaxPriceController),
              // galeriText(),
              // const SizedBox(height: 10),
              // imagePicker(),
            ],
          ),
        ),
      ),
    );
  }
}

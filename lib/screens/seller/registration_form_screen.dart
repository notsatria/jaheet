import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/theme.dart';
import '../home/profile_screen.dart';
import 'seller_main_screen.dart';

class RegistrationFormScreen extends StatefulWidget {
  static const routeName = '/registration-form-screen';
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final ImagePicker picker = ImagePicker();
  File? image;

  double longitude = 0;
  double latitude = 0;

  TextEditingController namaTokoController = TextEditingController();
  TextEditingController kelurahanTokoController = TextEditingController();
  TextEditingController kecamatanTokoController = TextEditingController();
  TextEditingController kotaTokoController = TextEditingController();
  TextEditingController provinsiTokoController = TextEditingController();
  TextEditingController alamatTokoController = TextEditingController();
  TextEditingController deskripsiTokoController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference seller = FirebaseFirestore.instance.collection('seller');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final storageRef = FirebaseStorage.instance.ref();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    namaTokoController.dispose();
    kelurahanTokoController.dispose();
    kecamatanTokoController.dispose();
    kotaTokoController.dispose();
    provinsiTokoController.dispose();
    alamatTokoController.dispose();
    deskripsiTokoController.dispose();
  }

  Future<int> getSellerDataLength() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('seller').get();

    return snapshot.docs.length;
  }

  Future<void> updateUser() async {
    final sellerDataLength = await getSellerDataLength();

    return users
        .doc(auth.currentUser!.uid)
        .update({
          'isSeller': true,
          'sellerId': sellerDataLength,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> addSeller() async {
    final sellerDataLength = await getSellerDataLength();

    if (namaTokoController.text.isEmpty ||
        kelurahanTokoController.text.isEmpty ||
        kecamatanTokoController.text.isEmpty ||
        kotaTokoController.text.isEmpty ||
        provinsiTokoController.text.isEmpty ||
        alamatTokoController.text.isEmpty ||
        deskripsiTokoController.text.isEmpty) {
      return;
    }

    if (image == null) {
      return;
    }

    final ref = storageRef
        .child('seller_profile_images')
        .child('seller_profile_image_${sellerDataLength + 1}.png');

    final uploadTask = ref.putFile(
      image!,
      SettableMetadata(
        contentType: 'image/png',
      ),
    );

    final taskSnapshot = await uploadTask.whenComplete(() => null);

    final urlDownload = await taskSnapshot.ref.getDownloadURL();

    if (sellerDataLength.toString() == users.id.toString()) {
      return;
    }

    return seller
        .doc('${sellerDataLength + 1}')
        .set({
          'id': sellerDataLength + 1,
          'isClothSeller': false,
          'isSailor': true,
          'name': namaTokoController.text,
          'kelurahan': kelurahanTokoController.text,
          'kecamatan': kecamatanTokoController.text,
          'kota': kotaTokoController.text,
          'provinsi': provinsiTokoController.text,
          'address': alamatTokoController.text,
          'description': deskripsiTokoController.text,
          'profileImage': urlDownload,
          'rating': 3,
          'location': GeoPoint(latitude, longitude),
        })
        .then((value) => print('Seller Added'))
        .catchError((error) => print('Failed to add seller: $error'));
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Seller Registration Form',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        elevation: 2,
      );
    }

    Widget namaTokoForm() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor4,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.store,
              color: subtitleTextColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                controller: namaTokoController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Nama Toko',
                  hintStyle: TextStyle(
                    color: subtitleTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget alamatTokoForm() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_city,
                  color: subtitleTextColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextFormField(
                    controller: kelurahanTokoController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Kelurahan',
                      hintStyle: TextStyle(
                        color: subtitleTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_city,
                  color: subtitleTextColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextFormField(
                    controller: kecamatanTokoController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Kecamatan',
                      hintStyle: TextStyle(
                        color: subtitleTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_city,
                  color: subtitleTextColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextFormField(
                    controller: kotaTokoController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Kota/Kabupaten',
                      hintStyle: TextStyle(
                        color: subtitleTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_city,
                  color: subtitleTextColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextFormField(
                    controller: provinsiTokoController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Provinsi',
                      hintStyle: TextStyle(
                        color: subtitleTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget detailAlamatTokoForm() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        height: 65,
        decoration: BoxDecoration(
          color: backgroundColor4,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: subtitleTextColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Center(
                child: TextFormField(
                  controller: alamatTokoController,
                  minLines: 2,
                  maxLines: 5,
                  decoration: InputDecoration.collapsed(
                    hintText:
                        'Detail Alamat Toko (Jalan, Nomor Gedung, RT/RW, Kelurahan)',
                    hintStyle: TextStyle(
                      color: subtitleTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget deskripsiTokoForm() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        height: 100,
        decoration: BoxDecoration(
          color: backgroundColor4,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.description,
              color: subtitleTextColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                controller: deskripsiTokoController,
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration.collapsed(
                  hintText: 'Deskripsi Toko',
                  hintStyle: TextStyle(
                    color: subtitleTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget getLocationButton() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            try {
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              setState(() {
                longitude = position.longitude;
                latitude = position.latitude;
              });
            } catch (e) {
              print(e.toString());
            } finally {
              print('Longitude: $longitude');
              print('Latitude: $latitude');

              // Tampilkan scaffold messanger
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Lokasi berhasil didapatkan',
                    style: TextStyle(
                      color: whiteTextStyle.color,
                    ),
                  ),
                  backgroundColor: primaryColor,
                ),
              );
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: backgroundColor4,
              ),
              Text(
                'Get Location',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget warningLocationText() {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          "Aplikasi ini akan mengakses lokasi Toko Anda, usahakan untuk mengaktifkan GPS pada perangkat dan perhatikan lokasi anda sekarang",
          style: TextStyle(
            color: subtitleTextColor,
            fontSize: 14,
          ),
        ),
      );
    }

    Widget profileImagePicker() {
      Future<void> pickImage() async {
        try {
          final XFile? pickedImage =
              await picker.pickImage(source: ImageSource.gallery);

          if (pickedImage != null) {
            setState(() {
              image = File(pickedImage.path);
            });
          }
        } catch (e) {
          print(e.toString());
        }
      }

      return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: image != null
              ? DecorationImage(image: FileImage(image!), fit: BoxFit.cover)
              : null,
        ),
        child: GestureDetector(
          onTap: () {
            pickImage();
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  color: backgroundColor4,
                  size: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Add Profile Picture',
                  style: TextStyle(
                    color: backgroundColor4,
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget submitButton() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            try {
              await addSeller();
              await updateUser();

              namaTokoController.clear();
              kelurahanTokoController.clear();
              kecamatanTokoController.clear();
              kotaTokoController.clear();
              provinsiTokoController.clear();
              alamatTokoController.clear();
              deskripsiTokoController.clear();

              setState(() {
                image = null;
              });

              // Tampilkan circullar progress indicator
              const CircularProgressIndicator();
            } catch (e) {
              print(e.toString());
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Pendaftaran Gagal'),
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
                    title: const Text('Pendaftaran Berhasil'),
                    content:
                        const Text('Silahkan tunggu konfirmasi dari admin'),
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
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 20,
          ),
          child: ListView(
            children: [
              namaTokoForm(),
              alamatTokoForm(),
              detailAlamatTokoForm(),
              deskripsiTokoForm(),
              getLocationButton(),
              warningLocationText(),
              profileImagePicker(),
              const SizedBox(height: 20),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

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
  final ImagePicker picker = ImagePicker();
  List<XFile>? images = [];
  List<String> selectedCategories = [];
  static const List<String> categoryOptions = [
    'Atasan',
    'Bawahan',
    'Perbaikan',
    'Terusan',
  ];
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

    Widget namaJasaForm() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Nama Jasa',
            hintText: 'Masukkan nama jasa',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    Widget deskripsiForm() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Deskripsi',
            hintText: 'Masukkan deskripsi jasa',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    Widget hargaForm() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Harga',
            hintText: 'Contoh: Rp 100.000 - Rp 200.000',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    //kategori form menggunakan checkbox
    Widget kategoriForm() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kategori',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              direction: Axis.horizontal,
              spacing: 2,
              children: List.generate(categoryOptions.length, (index) {
                String category = categoryOptions[index];
                return CheckboxListTile(
                  title: Text(category),
                  value: selectedCategories.contains(category),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedCategories.add(category);
                      } else {
                        selectedCategories.remove(category);
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }),
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
      return Text(
        '*Silahkan upload foto jasa Anda, foto ini akan tampil pada informasi produk/jasa Anda (Maksimal 4 Gambar)',
        style: navyTextStyle.copyWith(
          fontSize: 14,
          fontWeight: light,
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
              // await addSeller();
              // await updateUser();

              // namaTokoController.clear();
              // kelurahanTokoController.clear();
              // kecamatanTokoController.clear();
              // kotaTokoController.clear();
              // provinsiTokoController.clear();
              // alamatTokoController.clear();
              // deskripsiTokoController.clear();

              // setState(() {
              //   image = null;
              // });

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
              namaJasaForm(),
              deskripsiForm(),
              hargaForm(),
              kategoriForm(),
              galeriText(),
              const SizedBox(height: 10),
              imagePicker(),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

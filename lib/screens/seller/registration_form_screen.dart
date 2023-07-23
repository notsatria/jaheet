import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jahitin/screens/home/profile_screen.dart';

import '../../constant/theme.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final ImagePicker picker = ImagePicker();
  File? image;
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
                  minLines: 2,
                  maxLines: 5,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Alamat Toko',
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
          onPressed: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
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
          child: Column(
            children: [
              namaTokoForm(),
              alamatTokoForm(),
              deskripsiTokoForm(),
              profileImagePicker(),
              const Spacer(),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

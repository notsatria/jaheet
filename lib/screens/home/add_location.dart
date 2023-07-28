import 'package:flutter/material.dart';
import 'package:jahitin/provider/send_location_provider.dart';
import 'package:jahitin/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';
import 'main_screen.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  static const routeName = "/add-location-dart";

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  TextEditingController _typeController = TextEditingController();
  TextEditingController _receiverNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _additionalInformationController =
      TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController();
    _receiverNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _additionalInformationController = TextEditingController();
    _cityController = TextEditingController();
    _provinceController = TextEditingController();
  }

  @override
  void dispose() {
    _provinceController;
    _cityController;
    _additionalInformationController;
    _phoneNumberController;
    _receiverNameController;
    _typeController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Tambahkan Alamat',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
          ),
        ),
        elevation: 2,
      );
    }

    Widget typeTextField() {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
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
            Expanded(
              child: TextFormField(
                controller: _typeController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Tipe Lokasi (Contoh : Rumah, Kos, Apartemen)',
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

    Widget receiverNameTextField() {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
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
            Expanded(
              child: TextFormField(
                controller: _receiverNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Nama Penerima',
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

    Widget phoneNumberTextField() {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
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
            Expanded(
              child: TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Nomor Telepon Penerima',
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

    Widget additionalInformationTextField() {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
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
            Expanded(
              child: TextFormField(
                controller: _additionalInformationController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Alamat Lengkap',
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

    Widget cityTextField() {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
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
            Expanded(
              child: TextFormField(
                controller: _cityController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Kota (Misal, Semarang)',
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

    Widget provinceTextField() {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
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
            Expanded(
              child: TextFormField(
                controller: _provinceController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Provinsi (Misal, Jawa Tengah)',
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

    Widget bottomButton() {
      return InkWell(
        onTap: () {
          Provider.of<SendLocationProvider>(context, listen: false)
              .addSendLocation(
            _typeController.text,
            _receiverNameController.text,
            _phoneNumberController.text,
            _additionalInformationController.text,
            _cityController.text,
            _provinceController.text,
          );
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          });
        },
        child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Tambahkan Alamat',
                style: whiteTextStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            )),
      );
    }

    Widget form() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            typeTextField(),
            receiverNameTextField(),
            phoneNumberTextField(),
            additionalInformationTextField(),
            cityTextField(),
            provinceTextField()
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: form(),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: bottomButton(),
        ),
      ),
    );
  }
}

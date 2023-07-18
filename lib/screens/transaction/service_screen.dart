import 'package:flutter/material.dart';
import 'package:jahitin/screens/home/detail_screen.dart';
import 'package:jahitin/screens/transaction/checkout_screen.dart';

import '../../constant/theme.dart';

class ServiceScreen extends StatefulWidget {
  static const routeName = '/service-screen';
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

Map<String, String> selectedValues = {
  'kategori': '',
  'jenis': '',
  'jasa': '',
};

const List<String> kategoriValue = [
  'ATASAN',
  'BAWAHAN',
];
const List<String> pakaianValue = [
  'Batik',
  'Jas Formal',
  'Blazer',
  'Celana Bahan',
  'Blus',
  'Kemeja',
  'Kaos',
  'Tunik',
  'Sweater',
  'Jaket',
  'Cardigan',
];

const List<String> celanaValue = [
  'Rok',
  'Blouse',
  'Blazer',
  'Celana Bahan',
  'Celana Panjang',
  'Celana Pendek',
  'Celana Jeans',
  'Celana Legging',
  'Celana Kulot',
  'Celana Jogger',
  'Celana Kargo',
  'Celana Chino',
];

const List<String> jasaValue = [
  'Jahit termasuk bahan',
  'Jahit tidak termasuk bahan'
];

class _ServiceScreenState extends State<ServiceScreen> {
  String firstKategori = kategoriValue.first;
  var firstItem;
  String firstjasa = jasaValue.first;

  Widget customContainer({
    required String judul,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Container(child: child),
      ],
    );
  }

  Widget kategoriDropdown() {
    return Container(
      height: 50,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: firstKategori,
          onChanged: (value) {
            setState(() {
              firstKategori = value!;
              selectedValues['kategori'] = value;
            });
          },
          items: kategoriValue.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget pakaianDropdown() {
    List<String> selectedPakaianValue =
        firstKategori == 'BAWAHAN' ? celanaValue : pakaianValue;

    if (!selectedPakaianValue.contains(firstItem)) {
      firstItem = selectedPakaianValue.first;
    }

    return Container(
      height: 50,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: firstItem,
          onChanged: (value) {
            setState(() {
              firstItem = value!;
              selectedValues['jenis'] = value;
            });
          },
          items: selectedPakaianValue
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          menuMaxHeight: 300,
          isExpanded: true,
          underline: const SizedBox(),
          dropdownColor: Colors.white,
          isDense: false,
          selectedItemBuilder: (BuildContext context) {
            return selectedPakaianValue.map<Widget>((String value) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(value),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  Widget jasaDropdown() {
    return Container(
      height: 50,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: firstjasa,
          onChanged: (value) {
            setState(() {
              firstjasa = value!;
              selectedValues['jasa'] = value;
            });
          },
          items: jasaValue.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: backgroundColor1,
      title: Text(
        'Pilih Jasa',
        style: TextStyle(
          color: primaryTextColor,
          fontWeight: semiBold,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: primaryTextColor,
        ),
      ),
      elevation: 2,
    );
  }

  Widget bottomButton() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CheckoutScreen(data: selectedValues)));
      },
      child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Tambah Jasa',
              style: whiteTextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            customContainer(
              judul: "Pilih Kategori",
              child: kategoriDropdown(),
            ),
            const SizedBox(height: 16),
            customContainer(
              judul: "Pilih Jenis Pakaian",
              child: pakaianDropdown(),
            ),
            const SizedBox(height: 16),
            customContainer(
              judul: "Pilih Jasa",
              child: jasaDropdown(),
            ),
            const Spacer(),
            bottomButton(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jahitin/provider/checkout_screen_provider.dart';
import 'package:jahitin/screens/transaction/checkout_screen.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';
import '../../provider/detail_screen_provider.dart';

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
  'TERUSAN',
  'PERBAIKAN',
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

const List<String> sizeValue = [
  'S',
  'M',
  'L',
  'XL',
  'XXL',
  'XXXL',
  'Custom (tambahkan pada deskripsi)',
];

class _ServiceScreenState extends State<ServiceScreen> {
  String firstKategori = kategoriValue.first;
  var firstItem;
  String firstjasa = jasaValue.first;
  String firstSize = sizeValue.first;

  @override
  void dispose() {
    super.dispose();
  }

  void setSelectedValue(String key, String value, List<String> listValue) {
    if (listValue.contains(value)) {
      selectedValues[key] = value;
    } else {
      selectedValues[key] = listValue.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutScreenProvider>(
      context,
      listen: false,
    );
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    int id = args['id'];

    int sellerId = context.read<DetailScreenProvider>().detailScreenData?['id'];

    String formatTwoDigits(int number) {
      return number.toString().padLeft(2, '0');
    }

    String generateDate() {
      DateTime now = DateTime.now();
      String timestamp =
          "${now.year}${formatTwoDigits(now.month)}${formatTwoDigits(now.day)}"
          "${formatTwoDigits(now.hour)}${formatTwoDigits(now.minute)}${formatTwoDigits(now.second)}";
      return timestamp;
    }

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
                // setSelectedValue('kategori', value, kategoriValue);
                checkoutProvider.setKategori(value);
                Provider.of<CheckoutScreenProvider>(context, listen: false)
                    .getPrice(Provider.of<DetailScreenProvider>(context,
                            listen: false)
                        .getId);
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
                checkoutProvider.setJenis(value);
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
                checkoutProvider.setJasa(value);
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

    Widget sizeDropdown() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: firstSize,
                onChanged: (value) {
                  setState(() {
                    firstSize = value!;
                    checkoutProvider.setSize(value);
                  });
                },
                items: sizeValue.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    insetPadding: const EdgeInsets.all(60),
                    content: Image.asset(
                      'assets/images/size_chart.png',
                    ),
                  );
                },
              );
            },
            child: Text(
              'Lihat size chart',
              style: secondaryTextStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
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
          Navigator.pushReplacementNamed(
            context,
            CheckoutScreen.routeName,
            arguments: id,
          );
          checkoutProvider.setDetailJasa(
            checkoutProvider.getKategori,
            checkoutProvider.getJenis,
            checkoutProvider.getJasa,
            checkoutProvider.getSize,
          );
          checkoutProvider.setOrderdate(generateDate());
          checkoutProvider.setSellerId(sellerId);
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
            const SizedBox(height: 16),
            customContainer(
              judul: "Pilih Size",
              child: sizeDropdown(),
            ),
            const Spacer(),
            bottomButton(),
          ],
        ),
      ),
    );
  }
}

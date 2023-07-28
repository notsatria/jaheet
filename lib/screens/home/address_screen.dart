import 'package:flutter/material.dart';
import 'package:jahitin/provider/address_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    // Panggil fetchAddressUser() untuk mengambil data dari Firebase Firestore
    Future.delayed(Duration.zero, () {
      final addressScreenProvider =
          Provider.of<AddressScreenProvider>(context, listen: false);
      addressScreenProvider.fetchAddressUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addressScreenProvider =
        Provider.of<AddressScreenProvider>(context, listen: false);
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Daftar Alamat',
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: defaultMargin, top: defaultMargin),
            child: InkWell(
              onTap: () {},
              child: Text(
                'Tambah alamat',
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
            ),
          )
        ],
      );
    }

    Widget bottomButton() {
      return InkWell(
        onTap: () {},
        child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Pilih Alamat',
                style: whiteTextStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            )),
      );
    }

    // Widget addressCard() {
    //   return Card(
    //     elevation: 2,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //     child: Container(
    //       width: double.maxFinite,
    //       padding: const EdgeInsets.all(16),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             'label',
    //             style: primaryTextStyle.copyWith(
    //               fontSize: 12,
    //               fontWeight: bold,
    //             ),
    //           ),
    //           // const SizedBox(width: 10),
    //           // Container(
    //           //   padding: const EdgeInsets.all(4),
    //           //   decoration: BoxDecoration(
    //           //       color: secondaryColor,
    //           //       borderRadius: BorderRadius.circular(4)),
    //           //   child: Center(
    //           //     child: Text(
    //           //       'Utama',
    //           //       style: whiteTextStyle.copyWith(
    //           //         fontSize: 8,
    //           //         fontWeight: bold,
    //           //       ),
    //           //     ),
    //           //   ),
    //           // ),
    //           const SizedBox(
    //             height: 8,
    //           ),
    //           Text(
    //             'nama saya',
    //             style: primaryTextStyle.copyWith(
    //               fontSize: 14,
    //               fontWeight: bold,
    //             ),
    //           ),
    //           Text(
    //             'nomortelepon',
    //             style: subtitleTextStyle.copyWith(
    //               fontSize: 12,
    //             ),
    //           ),
    //           Text(
    //             'alamat jalan kecamatan kelurahan kota kabupaten provinsi',
    //             style: subtitleTextStyle.copyWith(
    //               fontSize: 12,
    //             ),
    //             maxLines: 2,
    //           ),
    //           const SizedBox(
    //             height: 12,
    //           ),
    //           InkWell(
    //             child: Container(
    //               padding: const EdgeInsets.all(8),
    //               decoration: BoxDecoration(
    //                 border: Border.all(color: Colors.grey.shade300),
    //                 borderRadius: BorderRadius.circular(10),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   'Ubah Alamat',
    //                   style: primaryTextStyle.copyWith(
    //                     fontSize: 12,
    //                     fontWeight: bold,
    //                     color: Colors.grey.shade600,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    Widget addressCard(Map<String, dynamic> addressData) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addressData['type'] ??
                    '', // Ubah 'label' dengan field yang sesuai
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
              // Tambahkan kode untuk menampilkan label 'Utama' jika diperlukan
              // ...
              const SizedBox(
                height: 8,
              ),
              Text(
                addressData['type'] ??
                    '', // Ubah 'name' dengan field yang sesuai
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
              ),
              Text(
                addressData['phone'] ??
                    '', // Ubah 'phone' dengan field yang sesuai
                style: subtitleTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              Text(
                addressData['additionalDetail'] ??
                    '', // Ubah 'address' dengan field yang sesuai
                style: subtitleTextStyle.copyWith(
                  fontSize: 12,
                ),
                maxLines: 2,
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  // Tambahkan aksi untuk mengubah alamat
                  // ...
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Ubah Alamat',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: bottomButton(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              Consumer<AddressScreenProvider>(
                builder: (context, addressScreenProvider, _) {
                  final addressUser = addressScreenProvider.addresUser;
                  // Looping data addressUser untuk membuat card alamat
                  return Column(
                    children: addressUser.map((addressData) {
                      return addressCard(addressData);
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

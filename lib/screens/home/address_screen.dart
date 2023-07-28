import 'package:flutter/material.dart';
import 'package:jahitin/provider/address_screen_provider.dart';
import 'package:jahitin/provider/send_location_provider.dart';
import 'package:jahitin/screens/home/add_location.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  static const routeName = '/address-screen';

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                Navigator.pushNamed(context, AddLocationScreen.routeName);
              },
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

    Widget addressCard(Map<String, dynamic> addressData) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Map<String, dynamic> selectedLocation = {
              "type": addressData['type'],
              "isSelected": true,
              "receiverName": addressData['receiverName'],
              "phone": addressData['phone'],
              "additionalDetail": addressData['additionalDetail'],
              "city": addressData['city'],
              "province": addressData['province'],
            };
            context
                .read<SendLocationProvider>()
                .setSelectedLocation(selectedLocation);
          },
          child: Container(
            decoration: addressData['isSelected']
                ? BoxDecoration(
                    color: secondaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: secondaryColor.withOpacity(0.5), width: 2))
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: primaryTextColor.withOpacity(0.5), width: 1)),
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addressData['type'] ??
                          '', // Ubah 'label' dengan field yang sesuai
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                    addressData['isSelected']
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Terpilih',
                              style: primaryTextStyle.copyWith(
                                color: backgroundColor1,
                                fontSize: 14,
                                fontWeight: bold,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  addressData['receiverName'] ??
                      '', // Ubah 'name' dengan field yang sesuai
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                Text(
                  addressData['phone'] ??
                      '', // Ubah 'phone' dengan field yang sesuai
                  style: subtitleTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                Text(
                  addressData['additionalDetail'] ??
                      '', // Ubah 'address' dengan field yang sesuai
                  style: subtitleTextStyle.copyWith(
                    fontSize: 14,
                  ),
                  maxLines: 2,
                ),
                Text(
                  '${addressData['city']}, ${addressData['province']}',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 14,
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
              Consumer<SendLocationProvider>(
                builder: (context, sendLocation, _) {
                  final sendLocations = sendLocation.sendLocation;
                  return Column(
                    children: sendLocations.map((addressData) {
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

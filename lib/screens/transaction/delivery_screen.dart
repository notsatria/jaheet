import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jahitin/screens/transaction/checkout_screen.dart';
import 'package:provider/provider.dart';

import '../../constant/theme.dart';
import '../../provider/checkout_screen_provider.dart';
import '../../provider/send_location_provider.dart';

class DeliveryScreen extends StatefulWidget {
  static const routeName = '/delivery-screen';
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  bool isExpanded = false;
  String selectedDelivery = '';
  bool isSelected = false;

  void expanded(bool clicked) {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void setSelectedOption(String option) {
    setState(() {
      selectedDelivery = option;
      isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutScreenProvider>(
      context,
      listen: false,
    );

    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Pilih tipe pengiriman',
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

    Widget dropSelect() {
      return InkWell(
        onTap: () {
          setSelectedOption('drop');
          checkoutProvider.setDelivery('drop');
        },
        child: Container(
          padding: EdgeInsets.all(defaultMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icon/drop-off.svg',
                width: 18,
                color: secondaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Drop off',
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              isSelected && selectedDelivery == 'drop'
                  ? Icon(
                      Icons.check_circle,
                      size: 16,
                      color: secondaryColor,
                    )
                  : Text(''),
            ],
          ),
        ),
      );
    }

    Widget addressCard(Map<String, dynamic> addressData) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
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
                  addressData['additionalDetail'] ??
                      '', // Ubah 'address' dengan field yang sesuai
                  style: subtitleTextStyle.copyWith(
                    fontSize: 14,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget homeSelect() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ExpansionTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.local_shipping_outlined,
                size: 20,
                color: secondaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Home delivery',
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          iconColor: Colors.grey,
          trailing: Icon(
            isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
          ),
          onExpansionChanged: expanded,
          children: [
            InkWell(
              onTap: () {
                setSelectedOption('home');
                checkoutProvider.setDelivery('home');
              },
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      'Pesanan akan diantar ke rumah anda setelah selesai',
                      style: primaryTextStyle.copyWith(fontSize: 12),
                    ),
                    const Spacer(),
                    isSelected && selectedDelivery == 'home'
                        ? Icon(
                            Icons.check_circle,
                            size: 16,
                            color: secondaryColor,
                          )
                        : Text(''),
                  ],
                ),
              ),
            ),
            Column(
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
          ],
        ),
      );
    }

    Widget bottomButton() {
      return InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, CheckoutScreen.routeName);
          checkoutProvider.setDelivery(
            checkoutProvider.getDelivery,
          );
        },
        child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Pilih pengiriman',
                style: whiteTextStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            )),
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          dropSelect(),
          homeSelect(),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(defaultMargin),
            child: bottomButton(),
          ),
        ],
      ),
    );
  }
}

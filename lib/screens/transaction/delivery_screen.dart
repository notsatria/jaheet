import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/theme.dart';

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
              },
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      'Pesanan akan diantar ke rumah anda sesuai jam kerja',
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
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          dropSelect(),
          homeSelect(),
        ],
      ),
    );
  }
}

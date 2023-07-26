import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/theme.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = 'payment-screen';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
                'Pilih pengiriman',
                style: whiteTextStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            )),
      );
    }

    Widget dropSelect() {
      return InkWell(
        onTap: () {
          setSelectedOption('cash');
          // checkoutProvider.setDelivery('drop');
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

    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          dropSelect(),
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

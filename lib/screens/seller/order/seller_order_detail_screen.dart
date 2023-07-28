import 'package:flutter/material.dart';

import '../../../constant/theme.dart';

class SellerOrderDetailScreen extends StatelessWidget {
  static const routeName = '/seller-order-detail-screen';
  const SellerOrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Detail Pesananku',
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

    Widget cardPesanan() {
      return Container(
        margin: const EdgeInsets.only(top: 6),
        child: Card(
          child: Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/produk_jahit.png',
                    width: 80, height: 80),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ATASAN',
                      style: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Baju Kemeja',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Jahit Termasuk Bahan',
                      style: primaryTextStyle.copyWith(
                        fontWeight: reguler,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Harga: Rp 100.000 - Rp 200.000',
                      style: secondaryTextStyle.copyWith(
                        fontWeight: light,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget deskripsiPesanan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Deskripsi Pesanan ',
                style: primaryTextStyle.copyWith(
                    fontWeight: semiBold, fontSize: 16),
              ),
              Text(
                '(Scroll untuk selengkapnya)',
                style: secondaryTextStyle.copyWith(
                  fontWeight: light,
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            constraints: const BoxConstraints(
              maxHeight: 150,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor3,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing '
                  'elit. Sed vitae eros vitae nisl aliquam aliquet. '
                  'Vestibulum ante ipsum primis in faucibus orci luctus '
                  'et ultrices posuere cubilia curae; Nulla facilisi. '
                  'Suspendisse potenti. Donec euismod, nisl sed '
                  'consectetur ultricies, nunc nisl ultricies nunc, '
                  'quis ultricies nisl nunc sed nisl. Donec euismod '
                  'nisl eget enim aliquam, sed aliquam nisl '
                  'pellentesque. Donec euismod, nisl sed consectetur '
                  'ultricies, nunc nisl ultricies nunc, quis ultricies '
                  'nisl nunc sed nisl. Donec euismod nisl eget enim '
                  'aliquam, sed aliquam nisl pellentesque.',
                  style: primaryTextStyle.copyWith(
                    fontWeight: light,
                    fontSize: 14,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget pengirimanPesanan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Pengiriman',
            style:
                primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.local_shipping,
                    color: alertColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Home Delivery',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    Widget alamatPemesanan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Alamat Pesanan',
            style:
                primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: Text(
                'Jl. Raya Bogor KM 30, Depok',
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                'Rumah',
                style: secondaryTextStyle.copyWith(
                  fontWeight: light,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                cardPesanan(),
                deskripsiPesanan(),
                pengirimanPesanan(),
                alamatPemesanan(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

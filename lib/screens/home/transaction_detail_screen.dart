import 'package:flutter/material.dart';
import 'package:jahitin/provider/transaction_screen_provider.dart';
import 'package:provider/provider.dart';
import '../../constant/theme.dart';

class TransactionDetailScreen extends StatelessWidget {
  static const routeName = '/transaction-screen';

  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String orderid = args['orderid'];
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: backgroundColor1,
        title: Text(
          'Detail Transaksi',
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

    Widget cardPesanan({
      required String kategori,
      required String jenis,
      required String jasa,
      required String orderid,
      required String orderStatus,
      required String hargaMin,
      required String hargaMax,
    }) {
      Color statusColor =
          Colors.grey.shade300; // Default color for "Menunggu Konfirmasi"

      switch (orderStatus) {
        case 'Menunggu Konfirmasi':
          statusColor = Colors.grey.shade300;
          break;
        case 'Diproses':
          statusColor = Colors.amber.shade200;
          break;
        case 'Menunggu Pembayaran':
          statusColor = Colors.orange.shade300;
          break;
        case 'Dikirim':
          statusColor = Colors.blue.shade300;
          break;
        case 'Selesai':
          statusColor = Colors.green.shade200;
          break;
        default:
          statusColor = Colors.grey.shade300;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: statusColor,
            ),
            height: 50,
            child: Center(
              child: Text(
                orderStatus,
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'order id: $orderid',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/produk_jahit.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$kategori ($jenis)',
                        style: primaryTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        jasa,
                        style: subtitleTextStyle.copyWith(
                          fontWeight: reguler,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Harga: Rp$hargaMin - Rp$hargaMax*',
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
        ],
      );
    }

    Widget pengirimanPesanan(String delivery) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Pengiriman',
            style: primaryTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Card(
            child: ListTile(
              title: Row(
                children: [
                  Icon(
                    delivery == 'drop'
                        ? Icons.storefront
                        : Icons.local_shipping,
                    color: alertColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    delivery == 'drop' ? 'Pick Off' : 'Home Delivery',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    Widget deskripsiPesanan(String deskripsi) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Deskripsi Pesanan ',
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 14,
                ),
              ),
              Text(
                '(Scroll untuk selengkapnya)',
                style: secondaryTextStyle.copyWith(
                  fontWeight: light,
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            constraints: const BoxConstraints(
              maxHeight: 150,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: backgroundColor3,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Text(
                  deskripsi,
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

    Widget alamatPemesanan(String alamat, String type) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Dikirim ke: ',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                        children: [
                          TextSpan(
                            text: type,
                            style: secondaryTextStyle.copyWith(
                              fontWeight: bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      alamat,
                      style: primaryTextStyle.copyWith(
                        fontWeight: reguler,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget pickoff(String alamat, String type) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Diambil di: ',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                        children: [
                          TextSpan(
                            text: type,
                            style: secondaryTextStyle.copyWith(
                              fontWeight: bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      alamat,
                      style: primaryTextStyle.copyWith(
                        fontWeight: reguler,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget payment() {
      return Container(
        margin: const EdgeInsets.all(16),
        height: 60,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Bayar Pesanan',
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    Widget tagihan() {
      return Container(
        child: Column(
          children: [
            Row(children: [
              Text(
                'Subtotal Jasa',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
              const Spacer(),
              Text(
                'Rp100.000-Rp200.000',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Text(
                'Subtotal Pengiriman',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
              const Spacer(),
              Text(
                'Rp10.000',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Text(
                'Biaya Layanan',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
              const Spacer(),
              Text(
                'Rp10.000',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Text(
                'Total Pembayaran',
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
              const Spacer(),
              Text(
                '(menunggu penjahit)',
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ]),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<TransactionScreenProvider>(
            builder: (context, transactionScreenProvider, _) {
              final detaildata = transactionScreenProvider.detailScreenData;
              final kategori = detaildata?['kategori'];
              final jenis = detaildata?['jenis'];
              final jasa = detaildata?['jasa'];
              final orderid = detaildata?['orderid'];
              final sellerName = detaildata?['alamat_penjual']['sellerName'];
              final deskripsi = detaildata?['deskripsi'];
              final orderStatus = detaildata?['order_status'];
              final delivery = detaildata?['delivery'];
              final alamatUser =
                  detaildata?['alamat_pemesan']['additionalDetail'];
              final type = detaildata?['alamat_pemesan']['type'];
              //nanti ditambahkan additionalDetail alamat penjual yah
              final kecamatan = detaildata?['alamat_penjual']['distric'];
              final kota = detaildata?['alamat_penjual']['regency'];
              final alamatPenjual = '$kecamatan, $kota';

              return Column(
                children: [
                  cardPesanan(
                    kategori: kategori,
                    jenis: jenis,
                    jasa: jasa,
                    orderid: orderid,
                    orderStatus: orderStatus,
                    hargaMax: '200.000',
                    hargaMin: '100.000',
                  ),
                  const SizedBox(height: 14),
                  deskripsiPesanan(deskripsi),
                  const SizedBox(height: 14),
                  pengirimanPesanan(delivery),
                  (delivery == 'home')
                      ? alamatPemesanan(alamatUser, type)
                      : pickoff(alamatPenjual, sellerName),
                  const Spacer(),
                  (orderStatus == 'Menunggu Pembayaran')
                      ? payment()
                      : const SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

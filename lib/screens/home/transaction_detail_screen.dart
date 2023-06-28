import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../constant/theme.dart';

class TransactionDetailScreen extends StatelessWidget {
  static const routeName = '/transaction-screen';

  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    Widget transactionItem() {
      return Card(
        child: ListTile(
          onTap: () {
            print('Cek');
          },
          leading: Image.asset('assets/images/kerah.png'),
          title: Text(
            'Menjahit Kerah',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          subtitle: Text(
            'Sen, 8 Juni 2023',
            style: secondaryTextStyle.copyWith(fontSize: 14),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: primaryTextColor,
          ),
        ),
      );
    }

    Widget createTimelineBar() {
      return Timeline.tileBuilder(
        theme: TimelineThemeData(color: subtitleTextColor),
        builder: TimelineTileBuilder.fromStyle(
          itemCount: 10,
          contentsAlign: ContentsAlign.alternating,
          contentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '6 Juni\n08.00',
                style: subtitleTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: reguler,
                ),
              ),
            );
          },
          oppositeContentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pesanan Dibuat',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    'Pesanan Dibuat',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    Widget timelineJahit() {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Timeline Jahit',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ),
                Expanded(
                  child: createTimelineBar(),
                )
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              transactionItem(),
              timelineJahit(),
            ],
          ),
        ),
      ),
    );
  }
}

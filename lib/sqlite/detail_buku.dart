import 'package:flutter/material.dart';
import 'buku.dart';

class DetailBuku extends StatefulWidget {
  final Saham saham;

  const DetailBuku({super.key, required this.saham});

  @override
  State<DetailBuku> createState() => _DetailBukuState();
}

class _DetailBukuState extends State<DetailBuku> {
  @override
  Widget build(BuildContext context) {
    final isPositive = widget.saham.change >= 0;
    final changeColor = isPositive ? Colors.green : Colors.red;
    final changePrefix = isPositive ? '+' : '';

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail ${widget.saham.ticker}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ticker: ${widget.saham.ticker}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Open: ${widget.saham.open}'),
            Text('High: ${widget.saham.high}'),
            Text('Last: ${widget.saham.last}'),
            Text(
              'Change: $changePrefix${widget.saham.change}%',
              style: TextStyle(color: changeColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

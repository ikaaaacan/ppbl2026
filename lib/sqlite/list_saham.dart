import 'package:flutter/material.dart';
import 'buku.dart';
import 'koneksi.dart';

class ListSaham extends StatefulWidget {
  const ListSaham({super.key});

  @override
  State<ListSaham> createState() => _ListSahamState();
}

class _ListSahamState extends State<ListSaham> {
  List<Saham> daftarSaham = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Saham"),
      ),
      body: FutureBuilder<List<Saham>>(
        future: SahamQueryHandler().ambilSemuaSaham(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data saham.'));
          } else {
            daftarSaham = snapshot.data!;

            return ListView.builder(
              itemCount: daftarSaham.length,
              itemBuilder: (context, index) {
                final saham = daftarSaham[index];
                final isPositive = saham.change >= 0;
                final changeColor = isPositive ? Colors.green : Colors.red;
                final changePrefix = isPositive ? '+' : '';

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Kolom kiri: ticker
                        Text(
                          saham.ticker,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Kolom kanan: detail harga
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Open: ${saham.open}'),
                            Text('High: ${saham.high}'),
                            Text('Last: ${saham.last}'),
                            Text(
                              'Change: $changePrefix${saham.change}%',
                              style: TextStyle(
                                color: changeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

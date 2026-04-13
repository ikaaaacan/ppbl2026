import 'package:flutter/material.dart';
import 'koneksi.dart';
import 'list_saham.dart';

class InputSaham extends StatelessWidget {
  InputSaham({super.key});

  final TextEditingController _tickerController = TextEditingController();
  final TextEditingController _openController = TextEditingController();
  final TextEditingController _highController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _changeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Data Saham"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _tickerController,
                decoration: const InputDecoration(
                  labelText: 'Ticker (kode saham)',
                ),
              ),
              TextField(
                controller: _openController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Open (harga pembukaan)',
                ),
              ),
              TextField(
                controller: _highController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'High (harga tertinggi)',
                ),
              ),
              TextField(
                controller: _lastController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Last (harga terbaru)',
                ),
              ),
              TextField(
                controller: _changeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Change (% perubahan)',
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  await SahamQueryHandler().tambahSaham(
                    _tickerController.text,
                    int.parse(_openController.text),
                    int.parse(_highController.text),
                    int.parse(_lastController.text),
                    double.parse(_changeController.text),
                  );

                  _tickerController.clear();
                  _openController.clear();
                  _highController.clear();
                  _lastController.clear();
                  _changeController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Data saham berhasil disimpan"),
                    ),
                  );
                },
                child: const Text("Simpan Saham"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListSaham()),
                  );
                },
                child: const Text("Lihat Data Saham"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

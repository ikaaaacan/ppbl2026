import 'package:flutter/material.dart';
import 'package:ppbl2026/state/keranjang_provider.dart';
import 'package:ppbl2026/state/second_state.dart';
import 'package:ppbl2026/state/wishlist_provider.dart';
import 'package:provider/provider.dart';

class ContohState extends StatefulWidget {
  const ContohState({super.key});

  @override
  State<ContohState> createState() => _ContohStateState();
}

class _ContohStateState extends State<ContohState> {
  // state
  late int counter = 0;
  late String nama = "DPPB";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh State Sederhana"),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<KeranjangProvider>(
              builder: (context, counterProvider, child) {
                return Text("${counterProvider.keranjangCount}");
              },
            ),

            ElevatedButton(
                onPressed: () {
                  context.read<KeranjangProvider>().increment();
                },
                child: const Text("Tambah Keranjang")
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<KeranjangProvider>().decrement();
                },
                child: const Text("Kurangi Keranjang")
            ),

            Consumer<WishlistProvider>(
              builder: (context, counterProvider, child) {
                return Text("${counterProvider.wishlistCount}");
              },
            ),

            ElevatedButton(
                onPressed: () {
                  context.read<WishlistProvider>().increment();
                },
                child: const Text("Tambah Wishlist")
            ),
            Text(nama),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    nama = "PPBL";
                  });
                },
                child: const Text("Ganti nama")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondState()
                    ),
                  );
                },
                child: const Text("Pindah halaman dua"))
          ],
        ),
      ),
    );
  }
}

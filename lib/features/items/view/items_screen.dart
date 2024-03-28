// items_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi/features/items/bloc/items_bloc.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late ItemsBloc _itemsBloc;

  @override
  void initState() {
    super.initState();
    _itemsBloc = BlocProvider.of<ItemsBloc>(context);
    _itemsBloc.add(GetItems());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemsBloc()..add(GetItems()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Items'),
        ),
        body: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, state) {
            if (state is ItemsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ItemsSuccess) {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.data[index].nama),
                  );
                },
              );
            } else if (state is ItemsFailed) {
              return const Center(child: Text("Gagal"));
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddItemDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddItemDialog() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Item Baru'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Nama Item'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: const Text('Simpan'),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  // Tambahkan logic untuk menyimpan item baru
                  // Contoh: _itemsBloc.add(AddItem(_controller.text));
                  Navigator.of(context)
                      .pop(); // Tutup dialog setelah menambahkan
                }
              },
            ),
          ],
        );
      },
    );
  }
}

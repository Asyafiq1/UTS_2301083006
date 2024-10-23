import 'package:flutter/material.dart';

void main() {
  runApp(PeminjamanApp());
}

class PeminjamanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Peminjaman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PeminjamanHome(),
    );
  }
}

class Peminjaman {
  String kode;
  String nama;
  String kodePeminjaman;
  String tanggal;
  String kodeNasabah;
  String namaNasabah;
  double jumlahPinjaman;
  int lamaPinjaman; // dalam bulan
  double bunga; // dalam persen

  Peminjaman({
    required this.kode,
    required this.nama,
    required this.kodePeminjaman,
    required this.tanggal,
    required this.kodeNasabah,
    required this.namaNasabah,
    required this.jumlahPinjaman,
    required this.lamaPinjaman,
    required this.bunga,
  });

  // Perhitungan angsuran
  double get angsuranPokok => jumlahPinjaman / lamaPinjaman;
  double get bungaTotal => jumlahPinjaman * bunga / 100;
  double get bungaPerBulan => bungaTotal / lamaPinjaman;
  double get angsuranPerBulan => bungaPerBulan + angsuranPokok;
  double get totalHutang => jumlahPinjaman + bungaTotal;
}

class PeminjamanHome extends StatefulWidget {
  @override
  _PeminjamanHomeState createState() => _PeminjamanHomeState();
}

class _PeminjamanHomeState extends State<PeminjamanHome> {
  final _formKey = GlobalKey<FormState>();

  final kodeController = TextEditingController();
  final namaController = TextEditingController();
  final kodePeminjamanController = TextEditingController();
  final tanggalController = TextEditingController();
  final kodeNasabahController = TextEditingController();
  final namaNasabahController = TextEditingController();
  final jumlahPinjamanController = TextEditingController();
  final lamaPinjamanController = TextEditingController();

  Peminjaman? _peminjaman;

  void _hitungPeminjaman() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _peminjaman = Peminjaman(
          kode: kodeController.text,
          nama: namaController.text,
          kodePeminjaman: kodePeminjamanController.text,
          tanggal: tanggalController.text,
          kodeNasabah: kodeNasabahController.text,
          namaNasabah: namaNasabahController.text,
          jumlahPinjaman: double.parse(jumlahPinjamanController.text),
          lamaPinjaman: int.parse(lamaPinjamanController.text),
          bunga: 12.0, // Bunga tetap 12%
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peminjaman'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu Peminjaman',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Hitung Peminjaman'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: kodeController,
                decoration: InputDecoration(labelText: 'Kode'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kode';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: kodePeminjamanController,
                decoration: InputDecoration(labelText: 'Kode Peminjaman'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kode peminjaman';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tanggalController,
                decoration: InputDecoration(labelText: 'Tanggal'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan tanggal';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: kodeNasabahController,
                decoration: InputDecoration(labelText: 'Kode Nasabah'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kode nasabah';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: namaNasabahController,
                decoration: InputDecoration(labelText: 'Nama Nasabah'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama nasabah';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: jumlahPinjamanController,
                decoration: InputDecoration(labelText: 'Jumlah Pinjaman'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan jumlah pinjaman';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lamaPinjamanController,
                decoration: InputDecoration(labelText: 'Lama Pinjaman (bulan)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan lama pinjaman';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _hitungPeminjaman,
                child: Text('Hitung Peminjaman'),
              ),
              SizedBox(height: 20),
              if (_peminjaman != null) ...[
                Text('Angsuran Pokok: ${_peminjaman!.angsuranPokok.toStringAsFixed(2)}'),
                Text('Bunga Total: ${_peminjaman!.bungaTotal.toStringAsFixed(2)}'),
                Text('Angsuran Per Bulan: ${_peminjaman!.angsuranPerBulan.toStringAsFixed(2)}'),
                Text('Total Hutang: ${_peminjaman!.totalHutang.toStringAsFixed(2)}'),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

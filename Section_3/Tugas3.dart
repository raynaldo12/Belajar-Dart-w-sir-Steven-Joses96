import 'dart:io';

// Import dart:io agar bisa membaca input keyboard (stdin) dan menulis teks tanpa pindah baris (stdout).

// ================================================================= //
// CATATAN BELAJAR
// ================================================================= //
// ALUR PROGRAM (urutannya: MENU dulu -> baru PILIH CABANG -> eksekusi):
//   1. Tampil menu: 1. Cek Stok, 2. Masukkan Barang, 3. Potong Barang, 4. Keluar
//   2. Pilih menu 1/2/3
//   3. Baru muncul pilihan cabang (1-5)
//   4. Menu dieksekusi di cabang yang dipilih, lalu kembali ke menu awal
//
// KONSEP PBO YANG DIPAKAI:
//   - class Cabang  = cetakan. Tiap cabang = 1 object dengan stok sendiri-sendiri.
//   - property      = data milik object (nama, stok).
//   - method        = fungsi milik object (lihatStok, tambahStok, potongStok).
//   - constructor   = fungsi yang jalan saat object dibuat: Cabang('Cabang 1').
// ================================================================= //

class Cabang {
  String nama;
  // Property: nama cabang, contoh 'Cabang 1'.

  Map<String, int> stok = {};
  // Map = pasangan kunci -> nilai. Di sini: nama barang -> jumlah stok.
  // Contoh isi: {'ban': 50, 'oli': 30}. stok['ban'] hasilnya 50.

  Cabang(this.nama);
  // Constructor. "this.nama" = parameter langsung disimpan ke property nama.

  // ========= METHOD LIHAT STOK ========= //
  void lihatStok() {
    // void = tidak mengembalikan nilai, hanya menampilkan.
    if (stok.isEmpty) {
      print('Stok $nama kosong.');
      return;
      // return pada method void = berhenti, kode di bawahnya tidak dijalankan.
    }
    print('=== Stok $nama ===');
    stok.forEach((barang, jumlah) => print('$barang : $jumlah'));
    // forEach mengulang semua pasangan di Map. "=>" penulisan singkat untuk satu perintah.
  }

  // ========= METHOD TAMBAH STOK ========= //
  void tambahStok(String barang, int jumlah) {
    stok[barang] = (stok[barang] ?? 0) + jumlah;
    // stok[barang] bisa null jika barang belum pernah ada.
    // "?? 0" artinya: jika null pakai 0. Jadi barang baru mulai dari 0 lalu ditambah jumlah.
  }

  // ========= METHOD POTONG STOK ========= //
  String? potongStok(String barang, int jumlah) {
    // Kembalian String? (boleh null):
    //   gagal    -> kembalikan PESAN ERROR
    //   berhasil -> kembalikan null (tidak ada error)

    if (!stok.containsKey(barang)) {
      return 'Barang $barang tidak ada di $nama.';
    }
    // containsKey cek apakah nama barang ada di Map. Tanda ! di depan = kebalikannya (TIDAK ada).

    if (stok[barang]! < jumlah) {
      return 'Stok tidak cukup. Sisa ${stok[barang]}.';
    }
    // Tanda ! setelah stok[barang] = "saya yakin tidak null" (aman, sudah dicek di atas).
    // Validasi: tolak jika stok yang ada lebih kecil dari jumlah yang mau dipotong.

    stok[barang] = stok[barang]! - jumlah;
    // Semua validasi lolos, baru stok dikurangi.
    return null;
  }
}

// ================================================================= //
// FUNCTION BANTU (dibuat sekali, dipanggil berulang)
// ================================================================= //

int? bacaAngka(String label) {
  stdout.write(label);
  return int.tryParse(stdin.readLineSync()?.trim() ?? '');
  // 4 langkah dari dalam ke luar:
  // 1. stdin.readLineSync() -> baca ketikan (bisa null).
  // 2. ?.trim()             -> hapus spasi awal/akhir, hanya jika tidak null.
  // 3. ?? ''                -> jika null, ganti teks kosong.
  // 4. int.tryParse()       -> ubah ke angka; jika gagal hasilnya null (bukan error).
}

String bacaTeks(String label) {
  stdout.write(label);
  return stdin.readLineSync()?.trim().toLowerCase() ?? '';
  // toLowerCase() agar 'Ban' dan 'ban' dianggap barang yang sama.
}

Cabang? pilihCabang(List<Cabang> daftarCabang) {
  // Function ini dipanggil SETELAH menu dipilih.
  // Kembalian Cabang? : object Cabang jika valid, null jika batal/tidak valid.
  print('=====================');
  print('PILIH CABANG');
  for (int i = 0; i < daftarCabang.length; i++) {
    print('${i + 1}. ${daftarCabang[i].nama}');
  }
  // i + 1 supaya nomor tampil mulai dari 1, padahal indeks list mulai dari 0.
  print('0. Batal');
  print('=====================');

  int? p = bacaAngka('Pilih cabang (0-${daftarCabang.length}) : ');

  if (p == null || p < 0 || p > daftarCabang.length) {
    print('Pilihan cabang tidak valid.');
    return null;
  }
  // Validasi: harus angka dan di rentang 0-5. "p == null ||" harus di depan
  // agar p < 0 tidak dicek saat p null.

  if (p == 0) {
    print('Dibatalkan.');
    return null;
  }

  return daftarCabang[p - 1];
  // p - 1 karena indeks mulai dari 0. Yang dikembalikan object aslinya (bukan salinan),
  // sehingga perubahan stok tersimpan.
}

// ================================================================= //
// PROGRAM UTAMA
// ================================================================= //

void main() {
  List<Cabang> daftarCabang = List.generate(
    5,
    (i) => Cabang('Cabang ${i + 1}'),
  );
  // List.generate membuat 5 object Cabang sekaligus (i = 0..4 -> nama Cabang 1..5).

  for (var c in daftarCabang) {
    c.stok['ban'] = 50;
    c.stok['oli'] = 30;
  }
  // Isi stok awal tiap cabang. Tiap cabang punya Map sendiri,
  // jadi mengubah satu cabang tidak mempengaruhi cabang lain.

  var jalan = true;
  // "Saklar" program. false = berhenti.

  while (jalan) {
    // ========= TAMPIL MENU DULU ========= //
    print('=====================');
    print('SISTEM STOK CABANG');
    print('=====================');
    print('1. Cek Stok');
    print('2. Masukkan Barang');
    print('3. Potong Barang');
    print('4. Keluar');
    print('=====================');
    stdout.write('Pilihan Menu (1/2/3/4) : ');
    var pilihMenu = stdin.readLineSync()?.trim();

    // ========= MENU 4 : KELUAR ========= //
    if (pilihMenu == '4') {
      print('Terima kasih!');
      jalan = false;
      continue;
      // Cek keluar di awal karena menu 4 tidak butuh pilih cabang.
    }

    // ========= VALIDASI MENU ========= //
    if (pilihMenu != '1' && pilihMenu != '2' && pilihMenu != '3') {
      print('Pilihan menu tidak valid.\n');
      continue;
    }
    // Jika bukan 1/2/3 (termasuk kosong atau huruf), kembali ke menu.
    // Dicek SEBELUM pilih cabang agar cabang tidak ditanyakan untuk menu yang salah.

    // ========= BARU PILIH CABANG ========= //
    Cabang? aktif = pilihCabang(daftarCabang);
    if (aktif == null) {
      print('');
      continue;
    }
    // Jika batal/tidak valid, kembali ke menu awal.

    // ========= MENU 1 : CEK STOK ========= //
    if (pilihMenu == '1') {
      aktif.lihatStok();
      // Memanggil method milik object: namaObject.namaMethod().
    }
    // ========= MENU 2 : MASUKKAN BARANG ========= //
    else if (pilihMenu == '2') {
      String barang = bacaTeks('Nama barang : ');
      int? jumlah = bacaAngka('Jumlah : ');

      if (barang.isEmpty || jumlah == null || jumlah <= 0) {
        print('Input tidak valid.\n');
        continue;
      }
      // Validasi: nama tidak boleh kosong, jumlah harus angka lebih dari 0.

      aktif.tambahStok(barang, jumlah);
      print('Stok $barang di ${aktif.nama} sekarang ${aktif.stok[barang]}.');
    }
    // ========= MENU 3 : POTONG BARANG ========= //
    else if (pilihMenu == '3') {
      String barang = bacaTeks('Nama barang : ');
      int? jumlah = bacaAngka('Jumlah dipotong : ');

      if (barang.isEmpty || jumlah == null || jumlah <= 0) {
        print('Input tidak valid.\n');
        continue;
      }

      String? error = aktif.potongStok(barang, jumlah);
      // Hasilnya null jika berhasil, atau pesan error jika gagal.
      if (error != null) {
        print(error);
      } else {
        print(
          'Berhasil. Sisa stok $barang di ${aktif.nama} : ${aktif.stok[barang]}',
        );
      }
    }

    print('');
    // Baris kosong pemisah. Setelah ini while mengulang dan menu tampil lagi.
  }
}

// ================================================================= //
// LATIHAN MANDIRI
// ================================================================= //
// 1. Tambahkan menu "Transfer stok antar cabang" (pilih cabang asal, lalu cabang tujuan).
// 2. Ubah menu 1 agar bisa melihat stok SEMUA cabang sekaligus.
// 3. Ubah 'nama' menjadi private: String _nama; lalu buat getter: String get nama => _nama;
// 4. Tambahkan login PIN di awal seperti latihan ATM.

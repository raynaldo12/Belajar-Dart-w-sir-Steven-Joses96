import 'dart:io';
  // Import library dart:io agar program bisa membaca input dari keyboard (stdin) dan menampilkan teks (stdout).

const int jumlahPos = 100;
  // Jumlah pos pencucian. Cukup ubah angka ini jika jumlah pos bertambah.

var jalan = true;
  // Variabel global sebagai "saklar" program. true = program berjalan, false = program berhenti.

  // Declare Tampilan Awal Tampilan Menu
void tampilMenu() {
  print('=====================');
  print('Jasa Pencucian Mobil');
  print('=====================');
  print('1. Tambah Antrian');
  print('2. Lihat Waiting List');
  print('3. Lihat Pos');
  print('4. Selesaikan Pos');
  print('5. Keluar');
  print('=====================');
}
  // Function tampilMenu() dibuat sekali lalu dipanggil berulang kali di dalam while.

void main() {
  // ========= DEKLARASI VARIABEL ========= //
  List<String?> pos = List.filled(jumlahPos, null);
    // List berisi 100 pos. Setiap pos menyimpan nomor plat (teks).
    // null artinya pos KOSONG. Tanda ? pada String? artinya isinya boleh null.
    // pos[0] = Pos 1, pos[1] = Pos 2, ... pos[99] = Pos 100 (indeks list mulai dari 0).
  List<String> waitingList = [];
    // List untuk menampung nomor plat mobil yang menunggu.

  // ========= PROGRAM PENCUCIAN MOBIL ========= //
  while (jalan) {
    // Perulangan while berjalan terus selama jalan bernilai true.
    tampilMenu();
    stdout.write('Pilihan Menu (1/2/3/4/5) : ');
      // Command stdout.write menampilkan teks tanpa pindah baris.
    var pilihMenu = stdin.readLineSync();
      // Variabel stdin.readLineSync() untuk membaca nomor menu yang diketik.

    // ========= MENU 1 : TAMBAH ANTRIAN ========= //
    if (pilihMenu == '1') {
      stdout.write('Input Nomor Kendaraan : ');
      String noPlat = stdin.readLineSync()?.trim().toUpperCase() ?? '';
        // Membaca plat, menghapus spasi di awal/akhir, mengubah ke huruf besar.
        // Jika hasilnya null, diganti teks kosong '' agar tidak error.

      if (noPlat.isEmpty) {
        print('Nomor kendaraan tidak boleh kosong.');
        print('');
        continue;
      }
        // Validasi 1: tolak jika plat kosong.
        // continue = kembali ke awal perulangan (menu tampil lagi).

      if (pos.contains(noPlat) || waitingList.contains(noPlat)) {
        print('Mobil $noPlat sudah terdaftar.');
        print('');
        continue;
      }
        // Validasi 2: tolak jika plat sudah ada di pos atau waiting list.
        // .contains() mengecek apakah sebuah data ada di dalam list. || artinya "atau".

      int indeksKosong = -1;
        // -1 artinya "belum ketemu pos kosong".
      for (int i = 0; i < pos.length; i++) {
        if (pos[i] == null) {
          indeksKosong = i;
          break;
        }
      }
        // Memeriksa pos satu per satu dari awal. Pos pertama yang kosong dicatat, lalu break menghentikan pencarian.

      if (indeksKosong != -1) {
        pos[indeksKosong] = noPlat;
        print('Mobil $noPlat langsung masuk ke Pos ${indeksKosong + 1}.');
          // Ada pos kosong: simpan plat ke pos tersebut. +1 karena indeks mulai dari 0 sedangkan nomor pos mulai dari 1.
      } else {
        waitingList.add(noPlat);
        print('Semua pos penuh! Mobil $noPlat dimasukkan ke Waiting List.');
          // Semua pos penuh: .add() menaruh plat di urutan paling belakang antrian.
      }
    }

    // ========= MENU 2 : LIHAT WAITING LIST ========= //
    else if (pilihMenu == '2') {
      if (waitingList.isEmpty) {
        print('Waiting list kosong.');
          // isEmpty bernilai true jika list tidak berisi data.
      } else {
        print('=== Daftar Waiting List ===');
        for (int i = 0; i < waitingList.length; i++) {
          print('${i + 1}. Plat : ${waitingList[i]}');
        }
          // for mengulang dari data pertama sampai terakhir. i + 1 agar nomor urut mulai dari 1.
      }
    }

    // ========= MENU 3 : LIHAT POS ========= //
    else if (pilihMenu == '3') {
      print('=== Status Pos Pencucian ===');
      bool adaIsi = false;
        // Penanda: apakah ada minimal 1 pos yang terisi. Awalnya false.

      for (int i = 0; i < pos.length; i++) {
        if (pos[i] != null) {
          print('Pos ${i + 1}: ${pos[i]}');
          adaIsi = true;
        }
      }
        // Hanya pos yang terisi yang ditampilkan agar layar tidak penuh tulisan "Kosong".

      if (!adaIsi) {
        print('Semua pos kosong.');
      }
    }

    // ========= MENU 4 : SELESAIKAN POS ========= //
    else if (pilihMenu == '4') {
      stdout.write('Pilih Pos yang selesai (1-$jumlahPos) : ');
      int? nomorPos = int.tryParse(stdin.readLineSync()?.trim() ?? '');
        // int.tryParse mengubah teks menjadi angka. Jika bukan angka, hasilnya null (bukan error).

      if (nomorPos == null || nomorPos < 1 || nomorPos > jumlahPos) {
        print('Pilihan Pos tidak valid.');
        print('');
        continue;
      }
        // Validasi 1: nomor pos harus angka dan berada di rentang 1 sampai jumlahPos.

      int indeks = nomorPos - 1;
        // Dikurangi 1 karena indeks list mulai dari 0.

      if (pos[indeks] == null) {
        print('Pos $nomorPos sudah kosong.');
        print('');
        continue;
      }
        // Validasi 2: tolak jika pos yang dipilih memang sedang kosong.

      print('Mobil ${pos[indeks]} di Pos $nomorPos telah selesai dicuci.');

      if (waitingList.isNotEmpty) {
        pos[indeks] = waitingList.removeAt(0);
        print('Mobil ${pos[indeks]} dari waiting list masuk ke Pos $nomorPos.');
          // removeAt(0) mengambil DAN menghapus mobil pertama di waiting list, lalu menaruhnya di pos yang baru selesai.
      } else {
        pos[indeks] = null;
          // Tidak ada yang menunggu: pos dikosongkan kembali.
      }
    }

    // ========= MENU 5 : KELUAR ========= //
    else if (pilihMenu == '5') {
      print('Terima kasih!');
      jalan = false;
        // Ubah jalan menjadi false sehingga perulangan while berhenti.
    }

    // ========= PILIHAN TIDAK DIKENAL ========= //
    else {
      print('Pilihan menu tidak valid.');
        // Jika yang diketik bukan 1 sampai 5, tampilkan pemberitahuan lalu menu tampil lagi.
    }
  }
}
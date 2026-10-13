import 'dart:io';
  // Import library dart:io agar program bisa membaca input dari keyboard (stdin) dan menampilkan teks (stdout).

  // Declare Tampilan Awal Tampilan Menu
void tampilMenu() {
  print('=====================');
  print('BANK SERBA ADA');
  print('=====================');
  print('1. Cek Saldo');
  print('2. Setor Tunai');
  print('3. Tarik Tunai');
  print('4. Keluar');
  print('=====================');
}
  // Function tampilMenu() dibuat sekali lalu dipanggil berulang kali di dalam while, supaya menu tampil lagi setiap selesai transaksi.
  // Command print() untuk menampilkan teks ke layar.

var ATM = false;
  // Variabel global bertipe boolean sebagai "saklar" mesin ATM. false = ATM mati/belum login, true = ATM menyala/sudah login.
int saldo = 2000000;
  // Variabel global bertipe int untuk menyimpan saldo awal Rp2.000.000. Dibuat di luar main() agar nilainya tetap tersimpan selama program berjalan.

void main() {
  print('=====================');
  print('BANK SERBA ADA');
  print('=====================');

  // ========= LOGIN ========= //
  var percobaan = 0;
    // Variabel untuk menghitung berapa kali PIN sudah dicoba.

  while (!ATM && percobaan < 3) {
    // Login berulang selama belum berhasil (ATM masih false) dan percobaan belum 3 kali.
    stdout.write('Masukkan PIN Anda : ');
      // Command stdout.write menampilkan teks tanpa pindah baris, sehingga ketikan muncul di samping teks.
    var password = stdin.readLineSync();
      // Variabel stdin.readLineSync() untuk membaca PIN yang diketik. Hasilnya bisa null, sehingga harus dicek dulu.

    if (password == null || password.trim().isEmpty) {
      percobaan++;
      print('Mohon masukkan PIN. Sisa percobaan : ${3 - percobaan}');
      print('');
      continue;
        // Jika PIN null atau kosong, hitung sebagai satu percobaan lalu continue kembali ke awal perulangan login.
    }

    int? passInt = int.tryParse(password.trim());
      // int.tryParse mengubah teks PIN menjadi angka. Jika berisi huruf, hasilnya null (bukan error).

    if (passInt == 112233) {
      print('');
      print('Selamat Datang');
      ATM = true;
        // Jika PIN benar, variabel ATM diubah menjadi true sehingga perulangan login berhenti dan perulangan menu bisa berjalan.
    } else {
      percobaan++;
      print('PIN salah. Sisa percobaan : ${3 - percobaan}');
      print('');
        // Jika PIN salah (termasuk null karena bukan angka), percobaan bertambah 1 dan sisa percobaan ditampilkan.
    }
  }

  if (!ATM) {
    print('Percobaan habis. Kartu diblokir.');
    return;
      // Jika 3 kali gagal, ATM masih false, tampilkan notifikasi lalu program berhenti dengan return.
  }

  // ========= PROGRAM MESIN ATM ========= //
  while (ATM) {
    // Perulangan while berjalan terus selama ATM bernilai true, sehingga menu muncul kembali setelah setiap transaksi.
    tampilMenu();
      // Memanggil function tampilMenu() untuk menampilkan daftar menu.
    stdout.write('Pilihan Menu (1/2/3/4) : ');
    var pilihMenu = stdin.readLineSync();
      // Variabel stdin.readLineSync() untuk membaca nomor menu yang diketik.

    // ========= MENU 1 : CEK SALDO ========= //
    if (pilihMenu == '1') {
      print('');
      print('=====================');
      print('SALDO SAAT INI : Rp$saldo');
        // Menampilkan isi variabel saldo. Tanda $ dipakai untuk menyisipkan nilai variabel ke dalam teks (string interpolation).
    }

    // ========= MENU 2 : SETOR TUNAI ========= //
    else if (pilihMenu == '2') {
      print('');
      stdout.write('Jumlah yang disetor : Rp');
      var setoran = stdin.readLineSync();
        // Variabel stdin.readLineSync() untuk membaca nominal setoran yang diketik.

      if (setoran == null || setoran.trim().isEmpty) {
        print('Mohon masukkan nominal.');
        print('');
        continue;
      }
        // Jika nominal null atau kosong, tampilkan notifikasi lalu kembali ke menu dengan continue.
        // (Bukan return, karena return akan mematikan seluruh program.)

      try {
        int jumlahSetoran = int.parse(setoran.trim());
          // Mengubah teks nominal menjadi angka agar bisa dihitung.

        if (jumlahSetoran <= 0) {
          print('Nominal setoran harus lebih dari 0.');
          print('');
          continue;
        }
          // Menolak setoran nol atau negatif. Tanpa ini, setoran negatif akan mengurangi saldo.

        int hasilSaldo = saldo + jumlahSetoran;
          // Variabel hasilSaldo menampung hasil penjumlahan saldo lama dengan jumlah setoran.
        saldo = hasilSaldo;
          // Memperbarui variabel saldo dengan hasil penjumlahan tadi.

        print('');
        print('Saldo sekarang : Rp$saldo');
          // Menampilkan saldo terbaru setelah setor tunai.
      } catch (e) {
        print('Input tidak valid. Harap masukkan angka');
          // Blok catch menangkap error jika nominal yang diketik bukan angka.
      }
    }

    // ========= MENU 3 : TARIK TUNAI ========= //
    else if (pilihMenu == '3') {
      print('');
      stdout.write('Jumlah yang ditarik : Rp');

      int? nominalTarik = int.tryParse(stdin.readLineSync()?.trim() ?? '');
        // Satu baris ini menjalankan 4 fungsi sekaligus, dari dalam ke luar:
        // 1. stdin.readLineSync() membaca ketikan pengguna. Hasilnya String? (bisa null).
        // 2. ?.trim() menghapus spasi di awal/akhir. Tanda ?. artinya trim() hanya dijalankan jika hasilnya tidak null.
        // 3. ?? '' artinya jika hasil sebelumnya null, pakai teks kosong '' sebagai gantinya.
        // 4. int.tryParse() mengubah teks menjadi angka. Jika gagal (huruf atau kosong), hasilnya null, bukan error.
        // Tipe int? artinya variabel ini boleh berisi angka atau null.

      if (nominalTarik == null || nominalTarik <= 0) {
        print('Nominal harus berupa angka positif.');
        print('');
        continue;
      }
        // Validasi 1: tolak jika bukan angka (null), nol, atau negatif.
        // continue = lewati sisa kode di dalam while, lalu kembali ke awal perulangan (menu tampil lagi).

      if (nominalTarik % 50000 != 0) {
        print('Mohon masukkan nominal dalam kelipatan Rp50.000.');
        print('');
        continue;
      }
        // Validasi 2: operator % menghitung sisa bagi. Jika sisa dibagi 50.000 bukan 0, berarti bukan kelipatan Rp50.000.
        // Contoh: 120.000 % 50.000 = 20.000 (ditolak), 150.000 % 50.000 = 0 (diterima).

      if (nominalTarik > saldo) {
        print('Saldo tidak cukup.');
        print('');
        continue;
      }
        // Validasi 3: tolak jika nominal yang ditarik lebih besar dari saldo.

      print('=====================');
      print('Pilih Pecahan :');
      print('1. Pecahan Rp50.000');
      print('2. Pecahan Rp100.000');
      print('=====================');
      stdout.write('Pilih Pecahan (1/2) : ');

      int? pilihanPecahan = int.tryParse(stdin.readLineSync()?.trim() ?? '');
        // Sama seperti nominalTarik: baca ketikan, hapus spasi, ubah ke angka. Jika bukan angka, hasilnya null.

      if (pilihanPecahan != 1 && pilihanPecahan != 2) {
        print('Pilihan pecahan tidak valid.');
        print('');
        continue;
      }
        // Validasi 4: pecahan harus 1 atau 2 (null/huruf juga ditolak).
        // Dicek sebelum saldo dikurangi, sehingga kalau pecahan salah, saldo tetap aman.

      print('=====================');
      print('Hasil Penarikan :');

      if (pilihanPecahan == 1) {
        print('Rp50.000 x ${nominalTarik ~/ 50000} lembar');
      }
        // Jika memilih pecahan 1: ${...} adalah string interpolation untuk ekspresi (dipakai kalau isinya perhitungan).
        // ~/ adalah pembagian bulat tanpa koma. Contoh: 250.000 ~/ 50.000 = 5 lembar.
      else {
        var lembar100 = nominalTarik ~/ 100000;
        var sisa = nominalTarik % 100000;
          // Sampai di sini pasti pecahan 2 (karena sudah divalidasi di atas).
          // lembar100 = jumlah lembar Rp100.000. sisa = nominal yang tidak habis dibagi 100.000.

        if (lembar100 > 0) {
          print('Rp100.000 x $lembar100 lembar');
        }
          // Hanya tampil jika ada lembar Rp100.000, supaya tidak muncul "Rp100.000 x 0 lembar".

        if (sisa > 0) {
          print('Rp50.000 x ${sisa ~/ 50000} lembar');
        }
          // Jika masih ada sisa (pasti kelipatan Rp50.000), sisanya dikeluarkan dalam lembar Rp50.000.
      }

      saldo -= nominalTarik;
        // Saldo baru dikurangi setelah semua validasi lolos. saldo -= x sama dengan saldo = saldo - x.
      print('=====================');
      print('Sisa saldo : Rp$saldo');
        // Menampilkan sisa saldo setelah penarikan.
    }

    // ========= MENU 4 : KELUAR ========= //
    else if (pilihMenu == '4') {
      print('Terima kasih telah menggunakan layanan kami.');
      ATM = false;
        // Jika memilih menu 4, tampilkan ucapan terima kasih dan ubah variabel ATM menjadi false sehingga perulangan while berhenti.
    }

    // ========= PILIHAN TIDAK DIKENAL ========= //
    else {
      print('Pilihan menu tidak valid.');
        // Jika yang diketik bukan 1/2/3/4 (termasuk kosong atau huruf), tampilkan pemberitahuan lalu menu tampil lagi.
    }
  }
    // Kurung kurawal penutup: while (ATM).
}
  // Kurung kurawal penutup: main().
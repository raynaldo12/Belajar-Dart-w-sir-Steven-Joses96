import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

void main() {
  var ceklogin = true;
  var jalan = true;
  var pins = 123;
  var saldo = 2000000;
  var hasil = 0;

  void login() {
//tanya user pin anda?
    stdout.writeln('Silahkan Masukan Pin Anda!');
    var pin = stdin.readLineSync()!;
//inputpin user
//jika sama dengan inputpinuser
    if (int.parse(pin) == pins) {
      ceklogin = false;
      print("Pin anda benar");
    } else {
      print("Pin Anda Salah Silahkan Coba Lagi!!!");
    }
//maka ceklogin == false
  }

  void tampilmenu() {
    print("=====================");
    print("1 = Cek Saldo");
    print("2 = Setor");
    print("3 = Tarik Tunai");
    print("=====================");
  }

  ceksaldo() {
    print("=====================");
    print("Total Saldo Anda Adalah :");
    print("$saldo");
    print("=====================");
  }

  setor() {
    stdout.writeln('Silahkan Masukan Saldo!!');
    var inputsetor = stdin.readLineSync()!;
    saldo = int.parse(inputsetor) + saldo;
    print("Saldo Anda Sekarang : $saldo");
//tanyakan ke user mau setor apa
//saldo ditambahjkan degan inputan user
  }

  tarik() {
    stdout.writeln('Silahkan inputkan Berapa Yang mau ditarik!!!');
    var inputtarik = stdin.readLineSync()!;
    if (int.parse(inputtarik) < saldo) {
      saldo = saldo - int.parse(inputtarik);
      print("================");
      print("1) Rp. 50.000");
      print("2) Rp. 100.000");

      stdout.writeln('Silahakan Pilih Pecahan(1/2)');
      var inputpecahan = stdin.readLineSync()!;
    } else {
      print("Saldo Anda Tidak Mencukupi");
    }

//tanya user tarik berapa
//tanya uuser pecahan 50/100 rb
// 250rb ~/ 100rb =2
  }

  while (jalan == true) {
    print("========================");
    print("Selamat datang di ATM");
    print("========================");

    if (ceklogin == true) {
      login();
    } else {
      tampilmenu();
      stdout.writeln('Silahkan Pilih Menu diatas!(1/2/3)');
      var inputmenu = stdin.readLineSync()!;
      switch (int.parse(inputmenu)) {
        case 1:
          ceksaldo();
          break;
        case 2:
          setor();
          break;
        case 3:
          tarik();
          break;
      }
//tanya user mau yang mana
//switch case

// case 1 : ceksaldo();
//case 2 : setor();
// case 3 : tarik();
    }
  }
}

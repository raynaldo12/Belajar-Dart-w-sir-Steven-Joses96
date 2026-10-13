
import 'dart:io' ;
void main()  {
    // Tanda seru ! itu wajib ada nilai
//     stdout.writeln('Masukkan angka 1.');
//     var input1 = stdin.readLineSync()!;

//     stdout.writeln('Masukkan angka 2');
//     var input2 = stdin.readLineSync()!;

//    var hasil = int.parse(input1) + int.parse(input2);
//    print(hasil);




// Tanda tanya ?
// String? nama;
// print (nama);


 //late
 //late String nama;
 //  nama = 'Deni';;
 //print(nama);

 // Fungsi 2:
 // 1. punya nilai  balik
 // 2. tidak punya nilai balik

 // Fungsi yuang  mengembalikan nilai string
//  String namalengkap(String? nama1, String? nama2){
//     String inputnama1  = nama1 ?? 'nama depan kosong';
//     String inputnama2  = nama2 ?? 'nama belakang kosong';

//     return inputnama1 + ' ' + inputnama2;
//  }

//  String namadepan = 'Wilson';
//  String namabelakang = 'Peter';
//  String hasil = namalengkap(null, null);   
//  print(hasil);



// Fungsi  yang mengembalikan nilai num
// num hitung(int a1, int? a2, int? a3){
//     var hasil = a1 + a2 + (a3 ?? 0);
//     return  hasil;
// }
// var hasilhitung3var = hitung(10,100,1000);
// print(hasilhitung3var);

// var hasilhitung2var = hitung(10,100,null);
// print(hasilhitung2var);

// var hasilhitung1var = hitung(10,null,null);
// print(hasilhitung1var);


// Fungsi tidak ada pengembalian nilai
// void cetaknilai(int tugas, int uts, int  uas){
//     print('nilai tugas : $tugas, nilai uts : $uts, nilai uas : $uas');
// }
// cetaknilai(100, 90, 80);


// list<map> datamhs(){
//   return [
//     {'test': '1'},
//   ];
// }


// Latihan di rumah
//user input 3 jenis data
//data pertama  tipe string(nama)
//data kedua tipe int (umur)
//data ketiga tipe num (berat)

// Fungsi yang ada pengembalian nilai list<map>
//dalam fungsi ada nerima input 3 (string  nama, int umur, double berat)
//proses dalam fungsi adalah list.add, gimana cara 3 input ini jadi map baru list.add ()
// return list<map>
//print nama saya a, umur b, berat saya c

// Fungsi list map, perubahan tipe data


List<Map> datamhs(String a, int b, double c){
  return [
    {'Nama' : a, 'Umur' : b, 'Berat' : c},
  ];
}

  stdout.writeln('Masukkan Nama');
    var input1 = stdin.readLineSync()!;
  stdout.writeln('Masukkan Umur');
    var input2 = stdin.readLineSync()!;
  stdout.writeln('Masukkan Berat');
    var input3 = stdin.readLineSync()!;

  var hasil = datamhs(input1, int.parse(input2), double.parse(input3));
    print('Nama Saya : ${hasil[0]['Nama']}, Umur : ${hasil[0]['Umur']}, Berat Saya : ${hasil[0]['Berat']}');
}
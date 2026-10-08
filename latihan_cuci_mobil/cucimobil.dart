import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
void main () {

  var jalan = true;

List waitinglist=[];
// List menu=["=====================","Welcome To Cuci Mobil Gratis","=====================","1) Tambahkan Waiting List","2) Tampilkan Waiting List","3) Tampilkan Pos List","4) Selesaikan Pos","5) Keluar Dari Aplikasi"];
Map PosA ={'plat': null};
Map PosB ={'plat': null};
Map PosC ={'plat': null};

void tambahlist(){
 stdout.writeln('Masukan Plat Number?');
    var plat = stdin.readLineSync()!;

if (PosA == null){
   PosA['plat'] = plat; 
}else if(PosB == null){
   PosB['plat'] = plat; 
}else if(PosC ==0){
   PosC['plat'] = plat; 
}else {
   waitinglist.add({'plat': plat});
}




}

showlist(){
print(waitinglist);
}



finishpos(){

}

keluar() {
  exit(0);
}

  while(jalan == true) {

  print("=============================");
  print("Welcome To Cuci Mobil Gratis");
  print("=============================");
  print("1) Tambahkan Waiting List");
  print("2) Tampilkan Waiting List");
  print("3) Tampilkan Post List");
  print("4) Selesaikan Post");
  print("5)Keluar dari Aplikasi");
 stdout.writeln('Pilih Angka untuk melihat menu (1/2/3/4/5)?');
    var input1 = stdin.readLineSync()!;
    int hasil =int.parse(input1);

  switch (hasil) {
    case 1:
    tambahlist();
    break;
    case 2:
    showlist();
    break;
    case 3:
    break;
    case 4:
    finishpos();
    break;
    case 5:
    keluar();
    break;
  }


 

  
}

}




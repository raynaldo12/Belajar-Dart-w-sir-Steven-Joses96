void main() {
  //1. Buat variabel menyimpan nilai dan hasil huruf.
  int nilai = 10; //variabel nilai 
  String nilaihuruf;

  if (nilai >= 85 && nilai <= 100) {
    nilaihuruf = 'A';
  }else if (nilai >= 70 && nilai <= 84){
    nilaihuruf = 'B';
  }else if (nilai >=55 && nilai <=69) {
    nilaihuruf = 'C';
  }else if (nilai >=0 && nilai <=54){
    nilaihuruf ='D';
  }else {
    nilaihuruf = "NILAI MU TIDAK NORMAL!!!"; //Memberikan proteksi jika angka yang dimasukan anomali.
  }

print('Nilai Mu Adalah $nilaihuruf');
}
  
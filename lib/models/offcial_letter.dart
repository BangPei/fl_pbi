class OfficialLetter {
  String? title;
  String? routeName;

  OfficialLetter({this.title, this.routeName});

  List<OfficialLetter> data() {
    return [
      OfficialLetter(title: "Surat Permohonan", routeName: "surat-permohonan"),
      OfficialLetter(title: "Surat Keterangan Lunas", routeName: "surat-lunas"),
      OfficialLetter(title: "Surat Sewa Lahan", routeName: "sewa-lahan"),
      OfficialLetter(
        title: "Formulir Pendaftaran",
        routeName: "formulir-pendaftaran",
      ),
      OfficialLetter(
        title: "Perjanjian Hak Guna Pakai",
        routeName: "guna-pakai",
      ),
      OfficialLetter(
        title: "Surat Tanda Daftar Hak Guna",
        routeName: "guna-pakai",
      ),
    ];
  }
}

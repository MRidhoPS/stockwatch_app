class Barang {
  final int barangId;
  final String namaBarang;
  final String brandBarang;
  final String warna;
  final String imgBarang;

  Barang({
    required this.barangId,
    required this.namaBarang,
    required this.brandBarang,
    required this.warna,
    required this.imgBarang,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      barangId: json['barang_id'] ?? 0,
      namaBarang: json['nama_barang'],
      brandBarang: json['brand_barang'],
      warna: json['warna'],
      imgBarang: json['img_barang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_barang': namaBarang,
      'brand_barang': brandBarang,
      'warna': warna,
      'img_barang': imgBarang,
    };
  }
}

import 'package:dio/dio.dart';
import 'package:stockwatch_app/model/barang_model.dart';

class CrudServices {
  Dio dio = Dio();
  final String baseUrl = 'http://192.168.18.17:2000/stock';

  Future<List<Barang>> getListBarang() async {
    try {
      Response response = await dio.get('$baseUrl/getBarang');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((item) => Barang.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load barang');
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      throw Exception('Failed to load barang: ${e.message}');
    }
  }

  Future<Barang> createBarang(
    String namaBarang,
    String brandBarang,
    String warna,
    String imgBarang,
  ) async {
    try {
      Response response = await dio.post('$baseUrl/createBarang', data: {
        "nama_barang": namaBarang,
        "brand_barang": brandBarang,
        "warna": warna,
        "img_barang": imgBarang,
      });

      if (response.statusCode == 201) {
        return Barang.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to add barang');
      }
    } on DioException catch (e) {
      throw Exception('Add Barang failed: ${e.message}');
    }
  }

  Future<void> deleteBarang(int barangId) async {
    try {
      Response response = await dio.delete('$baseUrl/deleteBarang/$barangId');

      if (response.statusCode == 201) {
        print('Success: ${response.data['message']}');
      } else {
        throw Exception('Failed to delete barang: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Delete Barang failed: ${e.message}');
    }
  }

  Future<Barang> updateBarang(
    int barangId,
    String namaBarang,
    String brandBarang,
    String warna,
    String imgBarang,
  ) async {
    try {
      print(
          'Updating barang: ID=$barangId, Name=$namaBarang, Brand=$brandBarang, Color=$warna, Image=$imgBarang');
      Response response =
          await dio.patch('$baseUrl/updateBarang/$barangId', data: {
        "barang_id": barangId,
        "nama_barang": namaBarang,
        "brand_barang": brandBarang,
        "warna": warna,
        "img_barang": imgBarang,
      });

      if (response.statusCode == 200) {
        return Barang.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to update barang');
      }
    } on DioException catch (e) {
      throw Exception('Update Barang failed: ${e.message}');
    }
  }
}

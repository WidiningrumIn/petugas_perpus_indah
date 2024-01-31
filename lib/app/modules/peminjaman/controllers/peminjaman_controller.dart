import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:petugas_perpus_indah/app/data/model/response_pinjam.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book.dart';
import '../../../data/provider/api_provider.dart';

class PeminjamanController extends GetxController with StateMixin<List<DataPinjam>> {
  //TODO: Implement PeminjamanController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async {
    change (null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(Endpoint.pinjam);
      if (response.statusCode == 200) {
        final ResponsePinjam responPeminjam = ResponsePinjam.fromJson(response.data);
        if (responPeminjam.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(responPeminjam.data, status: RxStatus.success());
        }
      } else{
        change (null , status: RxStatus.error("Gagal mengambil data"));
      }
    } on dio.DioException catch(e) {

      if (e.response != null) {
        if (e.response?.data != null) {
          change (null , status: RxStatus.error("dio ${e.response?.data['message']}"));
        }
      } else {
        change (null , status: RxStatus.error("cek"+(e.message ?? "")));

      }
    } catch (e) {
      change (null , status: RxStatus.error("catch"+e.toString()));
    }
  }

  void increment() => count.value++;
}

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intra_sub_mobile/app/data/kanban_response.dart';
// import 'package:intra_sub_mobile/app/data/profile_response.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/views/beranda_view.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/views/board_view.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/views/profile_view.dart';
import 'package:intra_sub_mobile/app/utils/api.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  final kanbanResponse = Rxn<KanbanResponse>();
  // final profileResponse = Rxn<ProfileResponse>();

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    BerandaView(),
    BoardView(),
    ProfileView(),
  ];

  final _getConnect = GetConnect();
  final token = GetStorage().read('token');
// print("📌 Token di DashboardController: $token");

  Future<KanbanResponse?> getTask() async {
    isLoading.value = true;
    try {
      if (token == null) {
        return Future.error("Token tidak ditemukan!");
      }

      final response = await _getConnect.get(
        BaseUrl.task,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.status.hasError) {
        return Future.error(response.statusText ?? "Error tidak diketahui");
      }

      if (response.body != null) {
        final result = KanbanResponse.fromJson(response.body);
        kanbanResponse.value = result;
        return result;
      }

      return null;
    } catch (e) {
      return Future.error("Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

//  Future<ProfileResponse?> getProfile() async {
//   try {
//     final response = await _getConnect.get(
//       BaseUrl.profile,
//       headers: {'Authorization': 'Bearer $token'},
//     );

//     if (response.status.hasError) {
//       return Future.error(response.statusText ?? "Gagal mengambil profil");
//     }

//     if (response.body != null) {
//       final result = ProfileResponse.fromJson(response.body);
//       profileResponse.value = result;
//       return result;
//     }

//     return null;
//   } catch (e) {
//     return Future.error("Terjadi kesalahan: $e");
//   }
// }


  @override
  void onInit() {
    super.onInit();
    getTask();
    // getProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

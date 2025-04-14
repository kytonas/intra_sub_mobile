import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intra_sub_mobile/app/data/profile_response.dart';
import 'package:intra_sub_mobile/app/modules/profile/controllers/profile_controller.dart';
import 'package:lottie/lottie.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  final ProfileController controller = Get.put(ProfileController());

  String getInitials(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].length >= 2) {
      return parts[0].substring(0, 2).toUpperCase();
    } else {
      return name.substring(0, 1).toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.defaultDialog(
                title: "Konfirmasi",
                middleText: "Apakah anda ingin Logout ?",
                textConfirm: "Ya",
                textCancel: "Tidak",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  controller.logout();
                  Get.back();
                },
                onCancel: () => Get.back(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FutureBuilder<ProfileResponse>(
          future: controller.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text("Loading animation failed");
                  },
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Gagal memuat profil"));
            }

            final data = snapshot.data;

            if (data == null || data.name == null || data.email == null) {
              return const Center(child: Text("Data profil tidak tersedia"));
            }

            return Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          getInitials(data.name ?? ''),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        data.name!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data.email!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

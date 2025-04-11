import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intra_sub_mobile/app/data/profile_response.dart';
import 'package:intra_sub_mobile/app/modules/profile/controllers/profile_controller.dart';
// import 'package:intra_sub_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';

class BerandaView extends GetView<ProfileController> {
  const BerandaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FutureBuilder<ProfileResponse?>(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text("Gagal memuat data profil"),
                );
              }

              final profile = snapshot.data;

              if (profile == null) {
                return const Center(child: Text("Data profil tidak tersedia"));
              }

              final name = profile.name;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // CARD FULL WIDTH
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Selamat datang di halaman dashboard, ',
                            style: const TextStyle(
                                fontSize: 18, color: Color(0xFF1F2937)),
                            children: [
                              TextSpan(
                                text: '$name!',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildClockCard(), // Pakai clock card-nya di dalam sini
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

 Widget _buildClockCard() {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        final now = DateTime.now();
        final time = DateFormat.Hms().format(now);
        final date = DateFormat("EEEE, dd MMMM yyyy", 'id_ID').format(now);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        );
      },
    );
  }

}

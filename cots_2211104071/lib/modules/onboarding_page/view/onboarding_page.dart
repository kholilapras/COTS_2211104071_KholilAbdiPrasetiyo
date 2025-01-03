import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cots_2211104071/modules/login_page/view/login_page.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToLastPage() {
    pageController.jumpToPage(onboardingData.length - 1);
  }
}

final RxList<Map<String, String>> onboardingData = RxList([
  {
    'image': 'lib/design_system/image/onboarding1.png',
    'title': 'Selamat datang di gojek!',
    'description':
        'Aplikasi yang bikin hidupmu lebih nyaman. Siap bantuin semua kebutuhanmu, kapanpun, dan di manapun.',
  },
  {
    'image': 'lib/design_system/image/onboarding2.png',
    'title': 'Transportasi & logistik',
    'description':
        'Antarin kamu jalan atau ambilin barang lebih gampang tinggal ngeklik doang~.',
  },
  {
    'image': 'lib/design_system/image/onboarding3.png',
    'title': 'Pesan makan & belanja',
    'description': 'Lagi ngidam sesuatu? Gojek beliin gak pakai lama.',
  },
]);

class OnboardingPage extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'lib/design_system/image/gojek_logo.png',
            height: kToolbarHeight - 16,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.currentPage.value = index;
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = onboardingData[index];
                    return OnboardingSlide(
                      image: data['image']!,
                      title: data['title']!,
                      description: data['description']!,
                    );
                  },
                )),
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => _buildDot(index == controller.currentPage.value),
                ),
              )),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(() {
              final isLastPage =
                  controller.currentPage.value == onboardingData.length - 1;
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: isLastPage
                        ? () {
                            Get.to(() => LoginPage());
                          }
                        : controller.nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(isLastPage ? 'Masuk' : 'Lanjut'),
                  ),
                  if (isLastPage) const SizedBox(height: 8),
                  if (isLastPage)
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Belum ada akun?, Daftar dulu',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  if (!isLastPage)
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Lewati',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                ],
              );
            }),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Dengan masuk atau mendaftar, kamu menyetujui Ketentuan layanan dan Kebijakan privasi.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 16 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingSlide extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingSlide({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

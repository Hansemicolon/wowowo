import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/translation_service.dart';
import '../models/translation_model.dart';
import 'login_screen.dart';
import 'history_screen.dart';
import 'counseling_screen.dart';
import 'adhd_test_screen.dart';
import 'company_info_screen.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _sourceController = TextEditingController();
  final TranslationService _translationService = TranslationService();
  String? _translationResult;
  bool _isLoading = false;
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // 테스트 광고 ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    _bannerAd?.load();
  }

  Future<void> _translateText() async {
    if (_sourceController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // final result = await _translationService.translateText(
      //   text: _sourceController.text,
      //   sourceLanguage: 'ko',
      //   targetLanguage: 'en',
      // );

      setState(() {
        _translationResult = "Test result";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('번역 중 오류가 발생했습니다: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double edgeinsetsAll = 20.0;
    const double textFontSize = 16.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('wowowo'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Color.fromRGBO(30, 30, 30, 1)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '사용자',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('로그인'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('번역 기록'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.psychology),
              title: const Text('심리상담'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CounselingScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('ADHD 테스트'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdhdTestScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('기업정보'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CompanyInfoScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(edgeinsetsAll),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child:
                      TextField(
                        controller: _sourceController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                          hintText: '번역할 텍스트를 입력하세요',
                          contentPadding: EdgeInsets.all(edgeinsetsAll),
                          focusedBorder: InputBorder.none,       // 포커스 상태(파란색 선) 없애기
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _translateText,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                        '번역하기',
                        style: TextStyle(color: Colors.black26),),
                    ),
                    const SizedBox(height: 16),
                    if (_translationResult != null)
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(edgeinsetsAll),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '여기 복붙 버튼 있으면 좋겠네 그리고 뭘 넣지',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    _translationResult!,
                                    style: const TextStyle(fontSize: textFontSize),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (_isAdLoaded)
              Container(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }
}
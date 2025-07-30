import 'package:flutter/material.dart';
import '../widgets/banner_ad_widget.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기업정보'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.business,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '회사 소개',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '우리 회사는 혁신적인 기술과 서비스로 사용자들의 삶을 더 나은 방향으로 이끌어가는 것을 목표로 합니다.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '주소',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '서울특별시 강남구 테헤란로 123',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '연락처',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '전화: 02-123-4567\n이메일: info@company.com',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const BannerAdWidget(),
        ],
      ),
    );
  }
} 
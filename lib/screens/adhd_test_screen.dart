import 'package:flutter/material.dart';
import '../widgets/banner_ad_widget.dart';

class AdhdTestScreen extends StatelessWidget {
  const AdhdTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADHD 테스트'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ADHD 자가진단 테스트',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '다음 질문들에 대해 0-3점 사이로 답변해주세요.\n'
                    '0: 전혀 그렇지 않다\n'
                    '1: 가끔 그렇다\n'
                    '2: 자주 그렇다\n'
                    '3: 매우 자주 그렇다',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10, // 임시 질문 수
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '질문 ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    4,
                                    (i) => ElevatedButton(
                                      onPressed: () {
                                        // TODO: 점수 저장
                                      },
                                      child: Text('$i'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: 결과 계산 및 표시
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('결과 보기'),
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
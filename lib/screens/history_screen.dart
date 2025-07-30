import 'package:flutter/material.dart';
import '../widgets/banner_ad_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('번역 기록'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // 임시 데이터
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('번역 기록 ${index + 1}'),
                    subtitle: Text('2025-04-${index + 10}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: 상세 기록 보기
                    },
                  ),
                );
              },
            ),
          ),
          const BannerAdWidget(),
        ],
      ),
    );
  }
} 
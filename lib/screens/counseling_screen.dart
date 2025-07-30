import 'package:flutter/material.dart';
import '../widgets/banner_ad_widget.dart';

class CounselingScreen extends StatelessWidget {
  const CounselingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('심리상담'),
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
                    '전문 상담사와 상담하기',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5, // 임시 데이터
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text('상담사 ${index + 1}'),
                            subtitle: Text('전문 분야: ${index % 2 == 0 ? '스트레스' : '불안'}'),
                            trailing: ElevatedButton(
                              onPressed: () {
                                // TODO: 상담 예약하기
                              },
                              child: const Text('상담 예약'),
                            ),
                          ),
                        );
                      },
                    ),
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
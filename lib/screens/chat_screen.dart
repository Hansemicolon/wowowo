import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final String _baseUrl = 'http://localhost:8000';

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/messages'));
      if (response.statusCode == 200) {
        final List<dynamic> messagesJson = json.decode(response.body);
        setState(() {
          _messages.clear();
          for (var message in messagesJson) {
            _messages.add(
              ChatMessage(
                text: message['text'],
                isMe: message['is_me'],
              ),
            );
          }
        });
      }
    } catch (e) {
      print('메시지 로드 중 오류 발생: $e');
    }
  }

  Future<void> _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    _messageController.clear();

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/messages'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'text': text,
          'is_me': true,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _messages.add(
            ChatMessage(
              text: text,
              isMe: true,
            ),
          );
          _messages.add(
            ChatMessage(
              text: responseData['text'],
              isMe: responseData['is_me'],
            ),
          );
        });

        // 자동 스크롤
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    } catch (e) {
      print('메시지 전송 중 오류 발생: $e');
    }

    // 입력창에 포커스 유지
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        hintText: '메시지를 입력하세요...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.teal,
                    onPressed: () => _handleSubmitted(_messageController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
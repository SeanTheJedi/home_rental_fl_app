import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../models/message_model.dart';
import '../../core/constants/color_constants.dart';

class ChatDetailScreen extends StatefulWidget {
  final Message message;

  const ChatDetailScreen({super.key, required this.message});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  // Using a list to hold the conversation state for the UI
  final List<Message> _chatMessages = [];

  @override
  void initState() {
    super.initState();
    // Add the initial message passed from the list to start the UI
    _chatMessages.add(widget.message);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the name of the person you are talking to
    final otherPartyName = widget.message.senderName;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                otherPartyName[0].toUpperCase(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              otherPartyName,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. The Scrollable Chat List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              reverse: true, // Start rendering from the bottom
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final msg = _chatMessages[index];
                // For UI testing, assuming the current user didn't send the initial message
                final isMyMessage = false;

                return _buildChatBubble(msg, isMyMessage);
              },
            ),
          ),

          // 2. The Text Input Area
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Helper widget to draw individual message bubbles
  Widget _buildChatBubble(Message msg, bool isMyMessage) {
    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isMyMessage ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isMyMessage ? 16.r : 0),
            bottomRight: Radius.circular(isMyMessage ? 0 : 16.r),
          ),
          boxShadow: [
            if (!isMyMessage)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Text(
          msg.content,
          style: TextStyle(
            color: isMyMessage ? Colors.white : AppColors.textPrimary,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  // Helper widget to draw the text field and send button
  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: () {
                // Clear the text field when send is pressed
                if (_messageController.text.isNotEmpty) {
                  _messageController.clear();
                }
              },
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
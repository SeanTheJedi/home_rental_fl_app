import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/common/widgets/page_layout.dart';
import '../../core/constants/color_constants.dart';
import '../../models/message_model.dart';
import 'widgets/message_card.dart';

class MessagesScreen extends StatelessWidget {
  final bool isLandlord;
  final String userId;

  const MessagesScreen({
    super.key,
    required this.isLandlord,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    // Filter messages for the logged-in user
    final userMessages = Message.dummyMessages
        .where((m) => m.senderId == userId || m.receiverId == userId)
        .toList();

    return PageLayout(
      title: 'Messages',
      body: Container(
        color: AppColors.surface, // Adjust to AppColors.background if needed
        child: userMessages.isEmpty
            ? _buildEmptyState(context, isLandlord)
            : CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
                child: Text(
                  'Recent Messages',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final message = userMessages[index];
                  return MessageCard(
                    message: message,
                    isLandlord: isLandlord,
                    userId: userId,
                  );
                },
                childCount: userMessages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // The UI shown when the user has 0 messages
  Widget _buildEmptyState(BuildContext context, bool isLandlord) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 48.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'No Messages Yet',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start chatting with property owners',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 24.h),
          TextButton(
            onPressed: () {
              // Navigate to Home or Properties list
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              backgroundColor: AppColors.primary.withOpacity(0.08),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              'Browse Properties',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
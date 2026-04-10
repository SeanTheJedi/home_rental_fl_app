import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../models/message_model.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final bool isLandlord;
  final String userId;

  const MessageCard({
    super.key,
    required this.message,
    required this.isLandlord,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the name of the person you are chatting with
    final otherPartyName = message.senderId == userId
        ? message.receiverName
        : message.senderName;

    // Check if the message is unread and meant for you
    final isUnread = !message.isRead && message.receiverId == userId;

    // Time formatting logic
    final time = DateTime.now().difference(message.timestamp).inHours < 24
        ? '${DateTime.now().difference(message.timestamp).inHours}h ago'
        : '${DateTime.now().difference(message.timestamp).inDays}d ago';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: isUnread
              ? AppColors.primary.withOpacity(0.3)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          // Navigate to Chat Detail Screen
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24.r,
                backgroundColor: isUnread
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                child: Text(
                  otherPartyName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isUnread ? AppColors.primary : Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // Message Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          otherPartyName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: isUnread
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isUnread
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            fontWeight: isUnread
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      message.content,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isUnread
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        fontWeight:
                        isUnread ? FontWeight.w500 : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
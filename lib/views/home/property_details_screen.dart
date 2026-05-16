import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_application/controllers/auth_controller.dart';
import 'package:home_rental_application/controllers/booking_controller.dart';
import 'package:home_rental_application/controllers/property_controller.dart';
import 'package:home_rental_application/core/constants/color_constants.dart';
import 'package:home_rental_application/models/booking_model.dart';
import 'package:home_rental_application/models/property_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final Property property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  DateTimeRange? _selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  double _calculateTotalPrice() {
    if (_selectedDateRange == null) return widget.property.price;
    final nights = _selectedDateRange!.duration.inDays;
    return widget.property.price * (nights > 0 ? nights : 1);
  }

  void _handleBooking() async {
    if (_selectedDateRange == null) {
      _selectDateRange(context);
      return;
    }

    final authController = Provider.of<AuthController>(context, listen: false);
    final bookingController = Provider.of<BookingController>(context, listen: false);

    if (authController.currentUser == null) {
      context.go('/auth');
      return;
    }

    try {
      final newBooking = Booking(
        id: '', // Firestore will generate this
        userId: authController.currentUser!.id,
        property: widget.property,
        checkIn: _selectedDateRange!.start,
        checkOut: _selectedDateRange!.end,
        totalPrice: _calculateTotalPrice(),
        status: BookingStatus.upcoming,
      );

      await bookingController.createBooking(newBooking);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Booking successful!'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/bookings');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create booking: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final propertyController = Provider.of<PropertyController>(context);
    final bookingController = Provider.of<BookingController>(context);
    final authController = Provider.of<AuthController>(context);
    
    final isFav = propertyController.isFavorite(widget.property.id);
    final activeBooking = bookingController.getActiveBookingForProperty(widget.property.id);
    final isBooked = activeBooking != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400.h,
                pinned: true,
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          if (authController.currentUser != null) {
                            propertyController.toggleFavorite(widget.property.id);
                          }
                        },
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'property-image-${widget.property.id}',
                    child: CachedNetworkImage(
                      imageUrl: widget.property.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isBooked) _buildBookingStatusBanner(activeBooking),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.property.title,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20.sp),
                              SizedBox(width: 4.w),
                              Text(
                                widget.property.averageRating.toString(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.primary, size: 18.sp),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              widget.property.location,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(child: _buildFacilityItem(Icons.king_bed_outlined, '${widget.property.bedrooms} Bed')),
                          SizedBox(width: 8.w),
                          Expanded(child: _buildFacilityItem(Icons.bathtub_outlined, '${widget.property.bathrooms} Bath')),
                          SizedBox(width: 8.w),
                          Expanded(child: _buildFacilityItem(Icons.square_foot_outlined, '1.2k sqft')),
                        ],
                      ),
                      SizedBox(height: 32.h),

                      // Date Picker Trigger (Hide if already booked)
                      if (!isBooked)
                        GestureDetector(
                          onTap: () => _selectDateRange(context),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, color: AppColors.primary, size: 20.sp),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Select Dates',
                                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                                    ),
                                    Text(
                                      _selectedDateRange == null
                                          ? 'Choose your stay period'
                                          : '${DateFormat('dd/MM').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM').format(_selectedDateRange!.end)}',
                                      style: TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Icon(Icons.edit_outlined, color: AppColors.textSecondary, size: 18.sp),
                              ],
                            ),
                          ),
                        ),
                      
                      if (isBooked) SizedBox(height: 16.h),

                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        widget.property.description.isEmpty 
                          ? 'This property offers a perfect blend of comfort and style. Located in a prime neighborhood, it features modern amenities and spacious interiors ideal for families or individuals looking for a high-quality living experience.'
                          : widget.property.description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: 120.h),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBooked ? 'Paid' : (_selectedDateRange == null ? 'Price' : 'Total Price'),
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                        ),
                        Text(
                          isBooked 
                            ? '\$${activeBooking.totalPrice.toStringAsFixed(0)}'
                            : '\$${_calculateTotalPrice().toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 32.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isBooked 
                          ? () => context.go('/bookings')
                          : (bookingController.isLoading ? null : _handleBooking),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isBooked ? Colors.green : AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: bookingController.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : Text(
                                isBooked 
                                  ? 'View Booking' 
                                  : (_selectedDateRange == null ? 'Select Dates' : 'Book Now'),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingStatusBanner(Booking booking) {
    final checkIn = DateFormat('MMM dd').format(booking.checkIn);
    final checkOut = DateFormat('MMM dd').format(booking.checkOut);
    
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booked Successfully',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  'Your stay: $checkIn - $checkOut',
                  style: TextStyle(
                    color: Colors.green.shade600,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityItem(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18.sp, color: AppColors.primary),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

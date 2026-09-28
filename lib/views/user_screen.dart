import 'package:assignment/controllers/firebase_controller.dart';
import 'package:assignment/controllers/user_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text(
          'Users',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          // Logout (required by the assignment)
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () => Get.find<AuthController>().logout(),
          ),
        ],
      ),

      // ================= ADD USER =================
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/login'),
        backgroundColor: const Color(0xFFE8DEF8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),

      // ================= BODY =================
      body: Obx(() {
        // Initial loading
        if (controller.isLoading.value && controller.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (controller.users.isEmpty &&
            controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50),
                  const SizedBox(height: 12),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.fetchUsers,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // Empty
        if (controller.users.isEmpty) {
          return const Center(child: Text('No users found'));
        }

        final bool hasMore = controller.currentPage < controller.totalPages;

        // User list
        return RefreshIndicator(
          onRefresh: controller.refreshUsers,
          child: NotificationListener<Notification>(
            // PAGINATION: when the user scrolls near the bottom
            // (or the list is too short to scroll), load the next page.
            onNotification: (notification) {
              ScrollMetrics? metrics;

              if (notification is ScrollNotification) {
                metrics = notification.metrics;
              } else if (notification is ScrollMetricsNotification) {
                metrics = notification.metrics;
              }

              if (metrics != null &&
                  metrics.axis == Axis.vertical &&
                  metrics.extentAfter < 300) {
                controller.loadNextPage();
              }

              return false;
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              // +1 row at the bottom: loader while loading, message at the end
              itemCount: controller.users.length +
                  ((controller.isPaginationLoading.value || !hasMore) ? 1 : 0),
              itemBuilder: (context, index) {
                // Bottom row
                if (index == controller.users.length) {
                  if (controller.isPaginationLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'No more users',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  );
                }

                final user = controller.users[index];

                return InkWell(
                  onTap: () => Get.toNamed('/login'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // First name
                        Text(
                          user.firstName ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),

                        // Last name
                        Text(
                          user.lastName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Email
                        Text(
                          user.email ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Avatar
                        CachedNetworkImage(
                          imageUrl: user.avatar ?? '',
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) {
                            return CircleAvatar(
                              radius: 55,
                              backgroundImage: imageProvider,
                            );
                          },
                          placeholder: (context, url) {
                            return const CircleAvatar(
                              radius: 55,
                              backgroundColor: Color(0xFFEFEFEF),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return const CircleAvatar(
                              radius: 55,
                              backgroundColor: Color(0xFFEFEFEF),
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
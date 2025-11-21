import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../../features/announcements/data/announcement_repository.dart';

class GlobalTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const GlobalTopNavBar({
    super.key,
    required this.title,
    this.onMenuTap,
    this.onNotificationTap,
    this.onAvatarTap,
    this.trailing,
  });

  final String title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(
                  Icons.menu_rounded,
                  color: AppColors.textPrimaryLight,
                ),
                tooltip: '開啟選單',
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed:
                        onNotificationTap ??
                        () => GoRouter.of(context).push('/announcements'),
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.textPrimaryLight,
                    ),
                    tooltip: '通知',
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: onAvatarTap,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary.withValues(
                        alpha: 0.12,
                      ),
                      child: const Icon(Icons.person, color: AppColors.primary),
                    ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: 8),
                    trailing!,
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyMarquee extends ConsumerStatefulWidget {
  const EmergencyMarquee({super.key, this.height = 52});

  final double height;

  @override
  ConsumerState<EmergencyMarquee> createState() => _EmergencyMarqueeState();
}

class _EmergencyMarqueeState extends ConsumerState<EmergencyMarquee>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  String _lastRenderedText = '';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _startScroll() {
    if (!mounted) return;
    if (!_scrollController.hasClients ||
        _scrollController.position.maxScrollExtent <= 0) {
      return;
    }
    _scrollController.jumpTo(0);
    _scrollController
        .animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 12),
          curve: Curves.linear,
        )
        .whenComplete(() {
          if (!mounted) return;
          _startScroll();
        });
  }

  @override
  Widget build(BuildContext context) {
    final announcementAsync = ref.watch(activeEmergencyAnnouncementProvider);
    return announcementAsync.maybeWhen(
      data: (announcement) {
        if (announcement == null || announcement.body.isEmpty) {
          return const SizedBox.shrink();
        }
        if (_lastRenderedText != announcement.body) {
          _lastRenderedText = announcement.body;
          WidgetsBinding.instance.addPostFrameCallback((_) => _startScroll());
        }
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Material(
            elevation: 4,
            color: AppColors.error,
            child: SizedBox(
              height: widget.height,
              child: Stack(
                children: [
                  ListView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.campaign_rounded,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            announcement.body,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Text(
                            announcement.title,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Container(
                        width: 18,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.error,
                              AppColors.error.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Container(
                        width: 18,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              AppColors.error,
                              AppColors.error.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}

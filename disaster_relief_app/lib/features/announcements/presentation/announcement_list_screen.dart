import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/role.dart';
import '../../../core/auth/role_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/global_chrome.dart';
import '../../../l10n/app_localizations.dart';
import '../data/announcement_repository.dart';
import 'announcement_controller.dart';

class AnnouncementListScreen extends ConsumerWidget {
  const AnnouncementListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final announcementsAsync = ref.watch(announcementsProvider);
    final role = ref.watch(currentUserRoleProvider).valueOrNull ?? AppRole.user;
    final canManage = role.canManageAnnouncements;

    return Scaffold(
      appBar: GlobalTopNavBar(
        title: l10n.announcements,
        onAvatarTap: () => context.push('/profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: announcementsAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return EmptyState(
                icon: Icons.campaign_outlined,
                title: '尚無公告',
                message: '目前沒有公告，管理員可建立新公告。',
              );
            }
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final announcement = items[index];
                return _AnnouncementCard(
                  announcement: announcement,
                  canManage: canManage,
                  onEdit: () =>
                      _openEditor(context, ref, existing: announcement),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => EmptyState(
            icon: Icons.error_outline,
            title: l10n.loadFailed,
            message: error.toString(),
          ),
        ),
      ),
      floatingActionButton: canManage
          ? FloatingActionButton.extended(
              onPressed: () => _openEditor(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('新增公告'),
            )
          : null,
    );
  }

  Future<void> _openEditor(
    BuildContext context,
    WidgetRef ref, {
    AnnouncementModel? existing,
  }) async {
    final titleController = TextEditingController(text: existing?.title ?? '');
    final bodyController = TextEditingController(text: existing?.body ?? '');
    String type = existing?.type ?? 'general';
    bool isActive = existing?.isActive ?? true;
    bool isPinned = existing?.isPinned ?? false;
    DateTime? startsAt = existing?.startsAt ?? DateTime.now();
    DateTime? endsAt = existing?.endsAt;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          existing == null ? '新增公告' : '編輯公告',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: '標題',
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: bodyController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        labelText: '內容',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.notes),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: type,
                      items: const [
                        DropdownMenuItem(value: 'general', child: Text('一般')),
                        DropdownMenuItem(value: 'emergency', child: Text('緊急')),
                      ],
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() => type = v);
                      },
                      decoration: const InputDecoration(
                        labelText: '類型',
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('啟用'),
                            value: isActive,
                            onChanged: (v) => setState(() => isActive = v),
                          ),
                        ),
                        Expanded(
                          child: SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('置頂'),
                            value: isPinned,
                            onChanged: (v) => setState(() => isPinned = v),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: startsAt ?? DateTime.now(),
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2030),
                              );
                              if (picked != null) {
                                setState(() => startsAt = picked);
                              }
                            },
                            icon: const Icon(Icons.schedule),
                            label: Text('開始：${_formatDate(startsAt)}'),
                          ),
                        ),
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: endsAt ?? DateTime.now(),
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2035),
                              );
                              if (picked != null) {
                                setState(() => endsAt = picked);
                              }
                            },
                            icon: const Icon(Icons.calendar_today_outlined),
                            label: Text(
                              endsAt == null
                                  ? '結束：未設定'
                                  : '結束：${_formatDate(endsAt)}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final title = titleController.text.trim();
                          final body = bodyController.text.trim();
                          if (title.isEmpty || body.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('請輸入標題與內容')),
                            );
                            return;
                          }
                          try {
                            await ref
                                .read(announcementControllerProvider)
                                .upsert(
                                  id: existing?.id,
                                  title: title,
                                  body: body,
                                  type: type,
                                  isActive: isActive,
                                  isPinned: isPinned,
                                  startsAt: startsAt,
                                  endsAt: endsAt,
                                );
                            if (context.mounted) Navigator.of(context).pop();
                          } catch (e) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text('儲存失敗：$e')));
                          }
                        },
                        child: Text(existing == null ? '建立公告' : '更新公告'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    titleController.dispose();
    bodyController.dispose();
  }
}

class _AnnouncementCard extends ConsumerWidget {
  const _AnnouncementCard({
    required this.announcement,
    required this.canManage,
    required this.onEdit,
  });

  final AnnouncementModel announcement;
  final bool canManage;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEmergency = announcement.type == 'emergency';
    final accent = isEmergency ? AppColors.error : AppColors.primary;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isEmergency ? '緊急' : '一般',
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (announcement.isPinned)
                  const Icon(
                    Icons.push_pin,
                    size: 18,
                    color: AppColors.warning,
                  ),
                const Spacer(),
                if (canManage)
                  IconButton(
                    tooltip: '編輯',
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: onEdit,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              announcement.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              announcement.body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textSecondaryLight,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _InfoChip(
                  icon: Icons.schedule,
                  label: '自 ${_formatDate(announcement.startsAt)}',
                ),
                _InfoChip(
                  icon: Icons.event_available,
                  label: announcement.endsAt == null
                      ? '無結束'
                      : '至 ${_formatDate(announcement.endsAt)}',
                ),
                _InfoChip(
                  icon: Icons.check_circle,
                  label: announcement.isActive ? '啟用中' : '未啟用',
                  color: announcement.isActive
                      ? AppColors.success
                      : AppColors.textSecondaryLight,
                ),
              ],
            ),
            if (canManage) ...[
              const Divider(height: 18),
              Row(
                children: [
                  Expanded(
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text('啟用'),
                      value: announcement.isActive,
                      onChanged: (v) => _updateFlag(ref, context, isActive: v),
                    ),
                  ),
                  IconButton(
                    tooltip: announcement.isPinned ? '取消置頂' : '置頂此公告',
                    icon: Icon(
                      announcement.isPinned
                          ? Icons.push_pin_outlined
                          : Icons.push_pin,
                    ),
                    onPressed: () => _updateFlag(
                      ref,
                      context,
                      isPinned: !announcement.isPinned,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _updateFlag(
    WidgetRef ref,
    BuildContext context, {
    bool? isActive,
    bool? isPinned,
  }) async {
    try {
      await ref
          .read(announcementControllerProvider)
          .updateFlags(
            id: announcement.id,
            type: announcement.type,
            isActive: isActive,
            isPinned: isPinned,
          );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('更新失敗：$e')));
    }
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, this.color});

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        icon,
        size: 16,
        color: color ?? AppColors.textSecondaryLight,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: color ?? AppColors.textSecondaryLight,
          fontSize: 12,
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
    );
  }
}

String _formatDate(DateTime? date) {
  if (date == null) return '--';
  return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
}

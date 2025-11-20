enum AppRole { root, superadmin, admin, leader, superuser, user, visitor }

AppRole roleFromString(String? value) {
  final normalized = (value ?? '').toLowerCase();
  switch (normalized) {
    case 'root':
      return AppRole.root;
    case 'superadmin':
      return AppRole.superadmin;
    case 'admin':
      return AppRole.admin;
    case 'leader':
      return AppRole.leader;
    case 'superuser':
      return AppRole.superuser;
    case 'visitor':
      return AppRole.visitor;
    default:
      return AppRole.user;
  }
}

extension AppRoleX on AppRole {
  int get rank {
    switch (this) {
      case AppRole.visitor:
        return 0;
      case AppRole.user:
        return 1;
      case AppRole.superuser:
        return 2;
      case AppRole.leader:
        return 3;
      case AppRole.admin:
        return 4;
      case AppRole.superadmin:
        return 5;
      case AppRole.root:
        return 6;
    }
  }

  String get label {
    switch (this) {
      case AppRole.root:
        return 'Root';
      case AppRole.superadmin:
        return 'Superadmin';
      case AppRole.admin:
        return 'Admin';
      case AppRole.leader:
        return 'Leader';
      case AppRole.superuser:
        return 'Superuser';
      case AppRole.user:
        return 'User';
      case AppRole.visitor:
        return 'Visitor';
    }
  }

  bool get isAdminOrAbove => rank >= AppRole.admin.rank;
  bool get isLeaderOrAbove => rank >= AppRole.leader.rank;
  bool get isAuthenticated => this != AppRole.visitor;

  bool get canManageAnnouncements => isAdminOrAbove;
  bool get canManagePriority => isLeaderOrAbove;
  bool get canReviewUsers => isAdminOrAbove;
  bool get canHostShuttle => rank >= AppRole.superuser.rank;

  bool allows(AppRole minimum) => rank >= minimum.rank;
}

String maskPhone(String phone) {
  final sanitized = phone.replaceAll(RegExp(r'[^0-9+]'), '');
  if (sanitized.length < 7) return sanitized;

  // Handle Taiwan pattern like +886-9xx-xxx-xxx
  if (sanitized.startsWith('+886') && sanitized.length >= 10) {
    final prefix = sanitized.substring(0, 8); // +8869xx
    final suffix = sanitized.substring(sanitized.length - 3);
    return '$prefix***$suffix';
  }

  final leading = sanitized.substring(0, 3);
  final trailing = sanitized.substring(sanitized.length - 3);
  return '$leading***$trailing';
}

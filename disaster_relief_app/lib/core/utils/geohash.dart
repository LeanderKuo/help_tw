const _base32 = '0123456789bcdefghjkmnpqrstuvwxyz';

String encodeGeohash(double latitude, double longitude, {int precision = 6}) {
  final normalizedLat = latitude.clamp(-90.0, 90.0);
  final normalizedLng = longitude.clamp(-180.0, 180.0);

  var minLat = -90.0;
  var maxLat = 90.0;
  var minLng = -180.0;
  var maxLng = 180.0;

  var isEven = true;
  var bit = 0;
  var ch = 0;
  final buffer = StringBuffer();
  const bits = [16, 8, 4, 2, 1];

  while (buffer.length < precision) {
    if (isEven) {
      final mid = (minLng + maxLng) / 2;
      if (normalizedLng > mid) {
        ch |= bits[bit];
        minLng = mid;
      } else {
        maxLng = mid;
      }
    } else {
      final mid = (minLat + maxLat) / 2;
      if (normalizedLat > mid) {
        ch |= bits[bit];
        minLat = mid;
      } else {
        maxLat = mid;
      }
    }

    isEven = !isEven;
    if (bit < 4) {
      bit++;
    } else {
      buffer.write(_base32[ch]);
      bit = 0;
      ch = 0;
    }
  }

  return buffer.toString();
}

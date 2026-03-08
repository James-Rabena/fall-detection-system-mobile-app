class ActivityLog {
  final String activity;
  final String time;
  final String status;

  const ActivityLog({
    required this.activity,
    required this.time,
    required this.status,
  });
}

class SystemStatus {
  final bool isSystemActive;
  final bool isDeviceConnected;

  const SystemStatus({
    required this.isSystemActive,
    required this.isDeviceConnected,
  });
}

class VitalStats {
  final String battery;
  final String signal;

  const VitalStats({
    required this.battery,
    required this.signal,
  });
}

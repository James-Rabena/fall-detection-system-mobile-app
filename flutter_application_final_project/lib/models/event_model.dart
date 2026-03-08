enum EventType {
  fallDetected,
  inactivityAlert,
  systemCheck,
  lowBattery,
  connectivityLost,
  normalMovement,
}

enum Severity {
  high,
  medium,
  low,
}

enum EventStatus {
  resolved,
  falseAlarm,
  completed,
  charged,
  restored,
  pending,
}

class Event {
  final String id;
  final EventType type;
  final DateTime dateTime;
  final Severity severity;
  final EventStatus status;

  const Event({
    required this.id,
    required this.type,
    required this.dateTime,
    required this.severity,
    required this.status,
  });

  String get typeLabel {
    switch (type) {
      case EventType.fallDetected:
        return 'Fall Detected';
      case EventType.inactivityAlert:
        return 'Inactivity Alert';
      case EventType.systemCheck:
        return 'System Check';
      case EventType.lowBattery:
        return 'Low Battery';
      case EventType.connectivityLost:
        return 'Connectivity Lost';
      case EventType.normalMovement:
        return 'Normal Movement';
    }
  }

  String get severityLabel {
    switch (severity) {
      case Severity.high:
        return 'High';
      case Severity.medium:
        return 'Medium';
      case Severity.low:
        return 'Low';
    }
  }

  String get statusLabel {
    switch (status) {
      case EventStatus.resolved:
        return 'Resolved';
      case EventStatus.falseAlarm:
        return 'False Alarm';
      case EventStatus.completed:
        return 'Completed';
      case EventStatus.charged:
        return 'Charged';
      case EventStatus.restored:
        return 'Restored';
      case EventStatus.pending:
        return 'Pending';
    }
  }

  String get formattedDate {
    return '${dateTime.toString().split(' ')[0]} • ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
  }
}

class WeeklyActivityData {
  final String day;
  final int value;

  const WeeklyActivityData({
    required this.day,
    required this.value,
  });
}

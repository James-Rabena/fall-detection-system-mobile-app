import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventsTable extends StatefulWidget {
  const EventsTable({
    super.key,
    required this.events,
  });

  final List<Event> events;

  @override
  State<EventsTable> createState() => _EventsTableState();
}

class _EventsTableState extends State<EventsTable> {
  static const int _rowsPerPage = 5;

  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _currentPage = 0;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Event> get _filteredEvents {
    final query = _searchController.text.trim().toLowerCase();

    final sortedEvents = [...widget.events]
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    if (query.isEmpty) return sortedEvents;

    return sortedEvents.where((event) {
      final text = [
        _eventTypeLabel(event.type),
        event.id,
        _severityLabel(event.severity),
        _statusLabel(event.status),
        _formatDateTime(event.dateTime),
      ].join(' ').toLowerCase();

      return text.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredEvents;
    final totalPages = (filtered.length / _rowsPerPage).ceil().clamp(1, 9999);
    final pageIndex = _currentPage >= totalPages ? totalPages - 1 : _currentPage;

    final start = pageIndex * _rowsPerPage;
    final end = (start + _rowsPerPage) > filtered.length
        ? filtered.length
        : start + _rowsPerPage;

    final visibleRows = filtered.sublist(start, end);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD9E2EC)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140F172A),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFD9E2EC)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Color(0xFF94A3B8),
                  ),
                  hintText: 'Search events...',
                  hintStyle: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE5EAF1)),
          LayoutBuilder(
            builder: (context, constraints) {
              final tableWidth = constraints.maxWidth < 900 ? 900.0 : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: tableWidth,
                  child: Column(
                    children: [
                      _buildHeaderRow(),
                      ...visibleRows.map(_buildDataRow),
                      _buildFooter(
                        start: filtered.isEmpty ? 0 : start + 1,
                        end: end,
                        total: filtered.length,
                        canGoBack: pageIndex > 0,
                        canGoNext: pageIndex < totalPages - 1,
                        onPrevious: () {
                          if (pageIndex == 0) return;
                          setState(() => _currentPage = pageIndex - 1);
                        },
                        onNext: () {
                          if (pageIndex >= totalPages - 1) return;
                          setState(() => _currentPage = pageIndex + 1);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      color: const Color(0xFFF8FAFC),
      child: const Row(
        children: [
          Expanded(
            flex: 30,
            child: Text(
              'Event Type',
              style: _headerTextStyle,
            ),
          ),
          Expanded(
            flex: 36,
            child: Text(
              'Date & Time',
              style: _headerTextStyle,
            ),
          ),
          Expanded(
            flex: 16,
            child: Text(
              'Severity',
              style: _headerTextStyle,
            ),
          ),
          Expanded(
            flex: 18,
            child: Text(
              'Status',
              style: _headerTextStyle,
            ),
          ),
          Expanded(
            flex: 10,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Actions',
                style: _headerTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(Event event) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFEAF0F6)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 30,
            child: Row(
              children: [
                Icon(
                  _eventIcon(event.type),
                  size: 18,
                  color: _eventIconColor(event.type),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    _eventTypeLabel(event.type),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 36,
            child: Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 16,
                  color: Color(0xFF94A3B8),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDateTime(event.dateTime),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 16,
            child: _Tag(
              label: _severityLabel(event.severity),
              backgroundColor: _severityBackground(event.severity),
              textColor: _severityTextColor(event.severity),
            ),
          ),
          Expanded(
            flex: 18,
            child: _Tag(
              label: _statusLabel(event.status),
              backgroundColor: const Color(0xFFE8F7EF),
              textColor: const Color(0xFF08A66C),
            ),
          ),
          Expanded(
            flex: 10,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF2563EB),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Details',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter({
    required int start,
    required int end,
    required int total,
    required bool canGoBack,
    required bool canGoNext,
    required VoidCallback onPrevious,
    required VoidCallback onNext,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFEAF0F6)),
        ),
      ),
      child: Row(
        children: [
          Text(
            total == 0
                ? 'Showing 0 events'
                : 'Showing $start-$end of $total events',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: canGoBack ? onPrevious : null,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF64748B),
              side: const BorderSide(color: Color(0xFFD9E2EC)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Previous'),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: canGoNext ? onNext : null,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2563EB),
              side: const BorderSide(color: Color(0xFFD9E2EC)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  static String _eventTypeLabel(EventType type) {
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

  static String _severityLabel(Severity severity) {
    switch (severity) {
      case Severity.high:
        return 'High';
      case Severity.medium:
        return 'Medium';
      case Severity.low:
        return 'Low';
    }
  }

  static String _statusLabel(EventStatus status) {
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
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  static IconData _eventIcon(EventType type) {
    switch (type) {
      case EventType.fallDetected:
        return Icons.warning_amber_rounded;
      case EventType.inactivityAlert:
        return Icons.timelapse_rounded;
      case EventType.systemCheck:
        return Icons.check_circle_outline_rounded;
      case EventType.lowBattery:
        return Icons.battery_alert_outlined;
      case EventType.connectivityLost:
        return Icons.wifi_off_rounded;
      case EventType.normalMovement:
        return Icons.directions_walk_rounded;
    }
  }

  static Color _eventIconColor(EventType type) {
    switch (type) {
      case EventType.fallDetected:
        return const Color(0xFFFF4D4F);
      default:
        return const Color(0xFF2563EB);
    }
  }

  static Color _severityBackground(Severity severity) {
    switch (severity) {
      case Severity.high:
        return const Color(0xFFFFF1F2);
      case Severity.medium:
        return const Color(0xFFFFF7E8);
      case Severity.low:
        return const Color(0xFFF8FAFC);
    }
  }

  static Color _severityTextColor(Severity severity) {
    switch (severity) {
      case Severity.high:
        return const Color(0xFFE11D48);
      case Severity.medium:
        return const Color(0xFFD97706);
      case Severity.low:
        return const Color(0xFF475569);
    }
  }

  static String _formatDateTime(DateTime value) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final month = months[value.month - 1];
    final day = value.day;
    final year = value.year;

    final hour = value.hour == 0
        ? 12
        : value.hour > 12
            ? value.hour - 12
            : value.hour;

    final minute = value.minute.toString().padLeft(2, '0');
    final period = value.hour >= 12 ? 'PM' : 'AM';

    return '$month $day, $year • $hour:$minute $period';
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

const TextStyle _headerTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: Color(0xFF334155),
);
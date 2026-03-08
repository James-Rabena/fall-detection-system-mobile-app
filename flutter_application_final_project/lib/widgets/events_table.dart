import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/event_model.dart';
import 'event_row.dart';

class EventsTable extends StatefulWidget {
  final List<Event> events;
  final Function(String)? onSearch;
  final VoidCallback? onExportCSV;

  const EventsTable({
    Key? key,
    required this.events,
    this.onSearch,
    this.onExportCSV,
  }) : super(key: key);

  @override
  State<EventsTable> createState() => _EventsTableState();
}

class _EventsTableState extends State<EventsTable> {
  late List<Event> filteredEvents;
  int currentPage = 1;
  final int itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
    filteredEvents = widget.events;
  }

  int get totalPages => (filteredEvents.length / itemsPerPage).ceil();

  List<Event> get paginatedEvents {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return filteredEvents.sublist(
      startIndex,
      endIndex > filteredEvents.length ? filteredEvents.length : endIndex,
    );
  }

  void _filterEvents(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredEvents = widget.events;
      } else {
        filteredEvents = widget.events
            .where((event) =>
                event.typeLabel.toLowerCase().contains(query.toLowerCase()) ||
                event.statusLabel.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      currentPage = 1;
    });
    widget.onSearch?.call(query);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search and Filter
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextField(
                    onChanged: _filterEvents,
                    decoration: InputDecoration(
                      hintText: 'Search events...',
                      hintStyle: const TextStyle(
                        color: AppColors.textLight,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.textLight,
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  // Filter logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter opened')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: AppColors.textMedium,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: widget.onExportCSV,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Export CSV',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Events List
        if (paginatedEvents.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: paginatedEvents.length,
            itemBuilder: (context, index) {
              return EventRow(
                event: paginatedEvents[index],
                onDetailsPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Details for ${paginatedEvents[index].typeLabel}'),
                    ),
                  );
                },
              );
            },
          )
        else
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: const [
                Icon(
                  Icons.search_off,
                  size: 48,
                  color: AppColors.textLight,
                ),
                SizedBox(height: 16),
                Text(
                  'No events found',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
        // Pagination
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing ${((currentPage - 1) * itemsPerPage) + 1}-${(currentPage * itemsPerPage) > filteredEvents.length ? filteredEvents.length : (currentPage * itemsPerPage)} of ${filteredEvents.length} events',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMedium,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: currentPage > 1
                        ? () {
                            setState(() {
                              currentPage--;
                            });
                          }
                        : null,
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: currentPage > 1
                            ? AppColors.primary
                            : AppColors.textLight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: currentPage < totalPages
                        ? () {
                            setState(() {
                              currentPage++;
                            });
                          }
                        : null,
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: currentPage < totalPages
                            ? AppColors.primary
                            : AppColors.textLight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

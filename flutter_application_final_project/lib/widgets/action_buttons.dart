import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: textColor, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onEmergencyCall;
  final VoidCallback onCheckVitals;
  final VoidCallback onNotifyRelatives;

  const ActionButtonsRow({
    Key? key,
    required this.onEmergencyCall,
    required this.onCheckVitals,
    required this.onNotifyRelatives,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          ActionButton(
            icon: Icons.phone,
            label: 'Emergency Call',
            backgroundColor: Color(0xFFFFE0E0),
            textColor: AppColors.dangerRed,
            onPressed: onEmergencyCall,
          ),
          ActionButton(
            icon: Icons.favorite,
            label: 'Check Vitals',
            backgroundColor: Color(0xFFE3F2FD),
            textColor: AppColors.primary,
            onPressed: onCheckVitals,
          ),
          ActionButton(
            icon: Icons.people,
            label: 'Notify Relatives',
            backgroundColor: Color(0xFFF3E5F5),
            textColor: Color(0xFF7B1FA2),
            onPressed: onNotifyRelatives,
          ),
        ],
      ),
    );
  }
}

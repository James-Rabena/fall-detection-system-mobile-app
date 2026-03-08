# GyroStep - Fall Detection System Mobile App

A clean, modern Flutter mobile application for fall detection monitoring. This project implements a professional UI design from Figma with organized, maintainable code structure.

## Project Structure

```
lib/
├── main.dart                 # Application entry point & theme setup
├── constants/
│   └── app_colors.dart      # Centralized color definitions
├── models/
│   └── activity_model.dart  # Data models (ActivityLog, SystemStatus, VitalStats)
├── screens/
│   └── home_screen.dart     # Main dashboard screen with responsive layout
└── widgets/
    ├── action_buttons.dart  # Emergency, Vitals, and Notify buttons
    ├── recent_activity.dart # Activity log display component
    ├── sidebar.dart         # Navigation sidebar with menu
    ├── status_card.dart     # Status display card with battery/signal
    └── top_bar.dart         # Application top bar
```

## Features

### 1. **Responsive Design**
   - Desktop layout with sidebar navigation
   - Mobile layout with drawer navigation
   - Automatic layout switching based on screen size

### 2. **Dashboard Components**
   - **Status Card**: Displays system status (Safe/Warning/Alert) with battery and signal indicators
   - **Action Buttons**: Quick access to Emergency Call, Check Vitals, and Notify Relatives
   - **Recent Activity**: Shows timestamped activity logs with status indicators
   - **Sidebar Navigation**: Menu items for Dashboard, History, Relatives, and Profile
   - **System Status**: Shows system active and device connection status

### 3. **Clean Architecture**
   - Separated concerns: screens, widgets, models, constants
   - Reusable widget components
   - Centralized color management
   - Type-safe data models

## Color Scheme

The app uses a professional color palette:
- **Primary**: Blue (#1E88E5)
- **Secondary**: Teal (#26A69A)
- **Status Green**: #26A69A (Safe)
- **Warning Orange**: #FFA726
- **Danger Red**: #EF5350
- **Backgrounds**: Light gray (#F5F5F5), White (#FFFFFF)

## Getting Started

### Prerequisites
- Flutter 3.10.7 or higher
- Dart SDK (included with Flutter)
- Android Studio / Xcode for emulator

### Installation

1. **Clone the repository**
   ```bash
   cd flutter_application_final_project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

4. **Build for release** (Optional)
   ```bash
   flutter build apk       # For Android
   flutter build ios       # For iOS
   flutter build web       # For Web
   ```

## Code Organization Best Practices

### Constants
All color definitions are centralized in `constants/app_colors.dart` for easy theme customization.

### Models
Data structures are defined in `models/activity_model.dart` ensuring type safety and consistency.

### Widgets
Reusable UI components are organized in the `widgets/` folder:
- Each widget is self-contained and configurable
- Components accept callbacks for user interactions
- Proper state management using StatefulWidget where needed

### Screens
Main application screens are in `screens/` folder:
- `HomeScreen` handles both mobile and desktop layouts
- Responsive design using `MediaQuery`
- State management for navigation and user interactions

## Customization

### Changing Colors
Edit `lib/constants/app_colors.dart` to modify the color scheme across the entire app.

### Modifying Dashboard Content
Update `lib/screens/home_screen.dart`:
- Modify `recentActivities` list to change activity data
- Update status values in `StatusCard` widget

### Adding New Screens
1. Create a new file in `lib/screens/`
2. Import and add to navigation in `Sidebar`
3. Handle navigation logic in screen state

### Adding New Widgets
1. Create a new file in `lib/widgets/`
2. Design component with proper parameters
3. Use StatelessWidget for presentational components
4. Use StatefulWidget only when local state is needed

## Responsive Design Notes

- **Mobile** (< 800px width): Uses drawer navigation
- **Desktop** (≥ 800px width): Uses sidebar navigation
- Both layouts share the same components for consistency

## Future Enhancements

- [ ] Real-time data integration with backend
- [ ] User authentication
- [ ] Notifications system
- [ ] Detailed activity analytics
- [ ] Settings and preferences screen
- [ ] Dark mode support
- [ ] Multi-language support
- [ ] Offline data persistence

## Dependencies

- `flutter`: Core framework
- `cupertino_icons`: iOS-style icons

See `pubspec.yaml` for full dependency list.

## Contributing

1. Maintain the existing folder structure
2. Follow Flutter naming conventions
3. Use const constructors where possible
4. Add comments for complex logic
5. Test responsive layouts on multiple screen sizes

## License

This project is part of the Fall Detection System initiative.

## Support

For issues or questions about the project structure, refer to the code comments or create an issue in the repository.

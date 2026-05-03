# Ma Clinique - Complete Medical Clinic Management System

A comprehensive Flutter-based medical clinic management system with three integrated applications for doctors, patients, and clinic administration.

## 🏥 Overview

Ma Clinique is a modern healthcare management solution that streamlines clinic operations through three specialized applications:

- **Doctors App** - For medical practitioners to manage patients and appointments
- **Patient App** - For patients to book appointments and manage their healthcare
- **Reception Dashboard** - For clinic staff to manage daily operations and analytics

## ✨ Features

### Doctors App
- 👨‍⚕️ Patient profile management
- 📅 Appointment scheduling and management
- 📋 Medical history tracking
- 💊 Treatment planning
- 🔔 Real-time notifications

### Patient App
- 📱 Easy appointment booking
- 🏥 Clinic information and services
- 💬 Secure messaging with doctors
- 📊 Personal health dashboard
- 🔔 Appointment reminders

### Reception Dashboard
- 📊 Real-time clinic analytics
- 👥 Patient database management
- 📅 Calendar and scheduling
- 💰 Revenue tracking
- 📈 Performance reports
- 🔄 Multi-clinic support

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode
- Firebase account
- Node.js and npm (for build tools)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/ma-clinique.git
   cd ma-clinique
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` for Android
   - Add your `GoogleService-Info.plist` for iOS
   - Update Firebase configuration in each app

4. **Run the apps**
   ```bash
   # Doctors App
   cd "Doctors App/ma_doctor"
   flutter run

   # Patient App
   cd "Patient/ma_clinique_web"
   flutter run

   # Reception Dashboard
   cd "Reception Dashboard/flaw3"
   flutter run
   ```

## 🛠️ Build System

This project includes a comprehensive build system with automated versioning.

### Build All Apps

```bash
# Build all apps for Android release
./build.sh build all release android

# Build all apps for iOS release (macOS only)
./build.sh build all release ios

# Build all apps for Web release
./build.sh build all release web
```

### Build Specific App

```bash
# Build doctors app
./build.sh build doctors release android

# Build patient app
./build.sh build patient debug ios

# Build reception dashboard
./build.sh build reception profile web
```

### Build with Version Increment

```bash
# Build and increment version
./build.sh build all release android -i
```

### Version Management

```bash
# Show all versions
./build.sh version

# Increment specific app version
./build.sh version doctors patch    # Patch version
./build.sh version patient minor    # Minor version
./build.sh version reception major   # Major version
```

### Clean Apps

```bash
# Clean all apps
./build.sh clean all

# Clean specific app
./build.sh clean doctors
```

## 📱 App Structure

```
Ma Clinique/
├── Doctors App/
│   └── ma_doctor/          # Doctors application
├── Patient/
│   └── ma_clinique_web/    # Patient application
├── Reception Dashboard/
│   └── flaw3/              # Reception dashboard
├── build.sh                # Unified build script
├── version.json            # Version management
├── BUILD_README.md         # Build system documentation
├── QUICK_START.md          # Quick reference guide
└── README.md               # This file
```

## 🎨 Design System

The project uses a unified design system across all applications:

- **Primary Color**: Medical Green (#2E7D32)
- **Secondary Color**: Warm Rose (#CF948D)
- **Accent Color**: Warm Orange (#EE8B60)
- **Typography**: Inter font family
- **Components**: Reusable UI component library

## 🔧 Technology Stack

### Core Technologies
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Firebase**: Backend services
- **SQLite**: Local database

### Key Packages
- `flutter_bloc`: State management
- `cloud_firestore`: Database
- `firebase_auth`: Authentication
- `go_router`: Navigation
- `cached_network_image`: Image caching
- `table_calendar`: Calendar components

### Firebase Services
- **Firestore**: NoSQL database
- **Authentication**: User authentication
- **Cloud Messaging**: Push notifications
- **Analytics**: User analytics
- **Performance**: Performance monitoring

## 📊 Architecture

The applications follow Clean Architecture principles:

```
┌─────────────────────────────────────────┐
│           Presentation Layer             │
│  (Widgets, BLoCs, UI Components)         │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│            Domain Layer                 │
│  (Use Cases, Entities, Value Objects)   │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│            Data Layer                   │
│  (Repositories, Data Sources, DTOs)    │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│         Infrastructure Layer            │
│  (Firebase, SQLite, Network, Storage)   │
└─────────────────────────────────────────┘
```

## 🔐 Security & Compliance

### Data Security
- AES-256 encryption for sensitive data
- TLS 1.3 for network communications
- Secure key storage
- HIPAA compliance measures

### Authentication
- Multi-factor authentication support
- Biometric authentication (Face ID/Touch ID)
- Secure token management
- Role-based access control

### Privacy
- GDPR compliance
- Data minimization principles
- User consent management
- Audit logging

## 🌐 Deployment

### Android
```bash
./build.sh build all release android -i
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS
```bash
./build.sh build all release ios -i
# Output: build/ios/
```

### Web
```bash
./build.sh build all release web -i
# Output: build/web/
```

## 📈 Performance Optimization

- Lazy loading for images and data
- Pagination for large lists
- Caching strategies
- Code splitting
- Tree shaking for reduced bundle size

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Widget Tests
```bash
flutter test test/widget/
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Versioning

We use semantic versioning for all applications: `MAJOR.MINOR.PATCH+BUILD`

- **MAJOR**: Incompatible API changes
- **MINOR**: New functionality, backwards compatible
- **PATCH**: Bug fixes, backwards compatible
- **BUILD**: Incremental build number

## 📄 License

This project is proprietary software. All rights reserved.

## 👥 Team

- **Development Team**: Ma Clinique Development Team
- **Design**: UI/UX Design Team
- **Product Management**: Product Team

## 📞 Support

For support and questions:
- Email: support@maclinique.com
- Documentation: [BUILD_README.md](BUILD_README.md)
- Quick Start: [QUICK_START.md](QUICK_START.md)

## 🗺️ Roadmap

### Phase 1: Foundation ✅
- [x] Core application development
- [x] Firebase integration
- [x] Basic authentication
- [x] Build system setup

### Phase 2: Enhancement 🚧
- [ ] Advanced analytics
- [ ] Multi-clinic support
- [ ] Enhanced notifications
- [ ] Performance optimization

### Phase 3: Expansion 📋
- [ ] Telemedicine integration
- [ ] Payment gateway integration
- [ ] Advanced reporting
- [ ] AI-powered features

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for the backend services
- Open source community for various packages

---

**Built with ❤️ for better healthcare management**

**Last Updated**: 2026-05-03
**Version**: 1.0.0
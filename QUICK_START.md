# Ma Clinique Build System - Quick Reference

## 🚀 Common Commands

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

# Build specific app with version increment
./build.sh build doctors release android -i
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

## 📱 App Keys

| Key | App Name |
|-----|----------|
| `doctors` | Doctors App |
| `patient` | Patient App |
| `reception` | Reception Dashboard |

## 🎯 Build Types

| Type | Description | Use Case |
|------|-------------|----------|
| `debug` | Fast compilation with debugging | Development |
| `profile` | Optimized for performance profiling | Performance testing |
| `release` | Fully optimized for production | Production deployments |

## 🌐 Platforms

| Platform | Output | Requirements |
|----------|--------|--------------|
| `android` | APK files | Android SDK |
| `ios` | iOS app bundle | macOS + Xcode |
| `web` | Web application | None |

## 📋 Examples

### Development Workflow
```bash
# Clean and build for development
./build.sh clean all
./build.sh build all debug android

# Test on iOS
./build.sh build doctors debug ios
```

### Release Workflow
```bash
# Build release with version increment
./build.sh build all release android -i

# Check versions
./build.sh version
```

### Multi-Platform Release
```bash
# Build for all platforms
./build.sh build all release android -i
./build.sh build all release ios -i
./build.sh build all release web -i
```

## 🔧 Troubleshooting

### Script Not Executable
```bash
chmod +x build.sh
```

### Flutter Not Found
```bash
export PATH="$PATH:/path/to/flutter/bin"
```

### View Build Logs
```bash
# Logs are stored in build_logs/ directory
ls -la build_logs/
cat build_logs/build_*.log
```

## 📊 Version Format

Versions follow semantic versioning: `MAJOR.MINOR.PATCH+BUILD`

- **MAJOR**: Incompatible changes
- **MINOR**: New features (backwards compatible)
- **PATCH**: Bug fixes (backwards compatible)
- **BUILD**: Incremental build number

## 📁 Output Locations

### Android
```
Doctors App/ma_doctor/build/app/outputs/flutter-apk/app-release.apk
Patient/ma_clinique_web/build/app/outputs/flutter-apk/app-release.apk
Reception Dashboard/flaw3/build/app/outputs/flutter-apk/app-release.apk
```

### iOS
```
Doctors App/ma_doctor/build/ios/
Patient/ma_clinique_web/build/ios/
Reception Dashboard/flaw3/build/ios/
```

### Web
```
Doctors App/ma_doctor/build/web/
Patient/ma_clinique_web/build/web/
Reception Dashboard/flaw3/build/web/
```

---

**For detailed documentation, see BUILD_README.md**
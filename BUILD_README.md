# Ma Clinique - Unified Build System

Comprehensive build script with automated versioning for all Ma Clinique applications.

## 🏗️ Overview

This build system provides a unified approach to building all Ma Clinique applications with:
- **Automated versioning** - Semantic versioning with build numbers
- **Multi-app support** - Build Doctors, Patient, and Reception apps together
- **Multi-platform** - Android, iOS, and Web builds
- **Multiple build types** - Debug, Profile, and Release configurations
- **Logging** - Detailed build logs for troubleshooting
- **Error handling** - Comprehensive error checking and reporting

## 📱 Supported Applications

| App Key | App Name | Path |
|---------|----------|------|
| `doctors` | Doctors App | `Doctors App/ma_doctor` |
| `patient` | Patient App | `Patient/ma_clinique_web` |
| `reception` | Reception Dashboard | `Reception Dashboard/flaw3` |

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- For iOS builds: macOS with Xcode
- For Android builds: Android SDK and build tools
- jq (JSON processor) for version management

### Installation

The build script is already set up in your project. Just make sure it's executable:

```bash
chmod +x build.sh
```

## 📖 Usage

### Basic Commands

#### Build All Apps (Release Android)
```bash
./build.sh build all release android
```

#### Build Specific App
```bash
./build.sh build doctors release android
./build.sh build patient debug ios
./build.sh build reception profile web
```

#### Build with Version Increment
```bash
./build.sh build all release android -i
```

#### View Current Versions
```bash
./build.sh version
```

#### Increment Specific App Version
```bash
./build.sh version doctors patch    # Increment patch version
./build.sh version patient minor    # Increment minor version
./build.sh version reception major   # Increment major version
```

#### Clean Apps
```bash
./build.sh clean all              # Clean all apps
./build.sh clean doctors          # Clean specific app
```

#### List Available Apps
```bash
./build.sh list
```

## 🎯 Command Reference

### Build Command

```bash
./build.sh build [APP] [BUILD_TYPE] [PLATFORM] [OPTIONS]
```

**Arguments:**
- `APP`: App key (`doctors`, `patient`, `reception`) or `all`
- `BUILD_TYPE`: Build type (`debug`, `profile`, `release`) - default: `release`
- `PLATFORM`: Target platform (`android`, `ios`, `web`) - default: `android`

**Options:**
- `-i, --increment`: Increment version before building
- `-v, --verbose`: Enable verbose output

### Version Command

```bash
./build.sh version [APP] [TYPE]
```

**Arguments:**
- `APP`: App key (`doctors`, `patient`, `reception`) - omit to show all versions
- `TYPE`: Version increment type (`major`, `minor`, `patch`) - default: `patch`

### Clean Command

```bash
./build.sh clean [APP]
```

**Arguments:**
- `APP`: App key (`doctors`, `patient`, `reception`) or `all`

## 📋 Build Types

### Debug
- Fast compilation with debugging symbols
- Not optimized for performance
- Includes debugging information
- **Use for:** Development and testing

### Profile
- Optimized for performance profiling
- Includes some debugging information
- Faster than release builds
- **Use for:** Performance testing and analysis

### Release
- Fully optimized for production
- No debugging information
- Smaller app size
- **Use for:** Production deployments

## 🌐 Platforms

### Android
- Generates APK files
- Output: `build/app/outputs/flutter-apk/app-<build_type>.apk`
- Supports all build types

### iOS
- Generates iOS app bundle
- Requires macOS and Xcode
- Output: `build/ios/`
- **Note:** iOS builds can only be performed on macOS

### Web
- Generates web application
- Output: `build/web/`
- Supports all build types
- Can be deployed to any web server

## 📊 Version Management

### Version Format

The build system uses semantic versioning: `MAJOR.MINOR.PATCH+BUILD`

- **MAJOR**: Incompatible API changes
- **MINOR**: New functionality, backwards compatible
- **PATCH**: Bug fixes, backwards compatible
- **BUILD**: Incremental build number

### Version File

Versions are stored in `version.json`:

```json
{
  "version": "1.0.0",
  "build": 1,
  "apps": {
    "doctors": {
      "version": "1.0.0",
      "build": 1,
      "last_updated": "20260503_120000"
    },
    "patient": {
      "version": "1.0.0",
      "build": 1,
      "last_updated": "20260503_120000"
    },
    "reception": {
      "version": "1.0.0",
      "build": 1,
      "last_updated": "20260503_120000"
    }
  },
  "last_updated": "20260503_120000"
}
```

### Automatic Version Updates

When you build with the `-i` flag, the script:
1. Increments the app version (patch by default)
2. Updates the build number
3. Modifies `pubspec.yaml` with the new version
4. Updates `version.json` with timestamp

## 📝 Build Logs

Build logs are stored in the `build_logs/` directory:

```
build_logs/
├── build_20260503_120000.log    # Build log with timestamp
├── build_20260503_130000.log    # Another build log
└── ...
```

Each log contains:
- Timestamp and build information
- Detailed build output
- Error messages and warnings
- Success/failure status

## 🔧 Advanced Usage

### Building for Multiple Platforms

```bash
# Build all apps for all platforms
./build.sh build all release android
./build.sh build all release ios
./build.sh build all release web
```

### Building with Different Version Increments

```bash
# Major version increment
./build.sh build doctors release android -i
./build.sh version doctors major

# Minor version increment
./build.sh build patient release android -i
./build.sh version patient minor

# Patch version increment (default)
./build.sh build reception release android -i
./build.sh version reception patch
```

### Verbose Mode for Debugging

```bash
./build.sh build doctors debug android -v
```

## 🛠️ Troubleshooting

### Flutter Not Found

**Error:** `Flutter is not installed or not in PATH`

**Solution:** Make sure Flutter is installed and in your PATH:
```bash
export PATH="$PATH:/path/to/flutter/bin"
```

### App Directory Not Found

**Error:** `App directory not found: /path/to/app`

**Solution:** Check that the app path in the script matches your actual project structure.

### iOS Build on Non-Mac

**Warning:** `iOS builds can only be performed on macOS. Skipping iOS build.`

**Solution:** iOS builds require macOS. Skip iOS builds on other platforms.

### Version File Issues

**Error:** Issues with version.json

**Solution:** Delete `version.json` and let the script recreate it:
```bash
rm version.json
./build.sh version  # Will recreate the file
```

## 📦 Output Locations

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

## 🔄 CI/CD Integration

### GitHub Actions Example

```yaml
name: Build Ma Clinique Apps

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: macos-latest

    steps:
    - uses: actions/checkout@v2
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.0.0'
    
    - name: Build All Apps
      run: |
        chmod +x build.sh
        ./build.sh build all release android -i
    
    - name: Upload APKs
      uses: actions/upload-artifact@v2
      with:
        name: release-apks
        path: '**/build/app/outputs/flutter-apk/*.apk'
```

## 🎨 Customization

### Adding New Apps

Edit the `APPS` array in `build.sh`:

```bash
declare -A APPS=(
    ["doctors"]="Doctors App/ma_doctor"
    ["patient"]="Patient/ma_clinique_web"
    ["reception"]="Reception Dashboard/flaw3"
    ["new_app"]="Path/to/new/app"  # Add new app here
)
```

### Modifying Build Types

Edit the `BUILD_TYPES` array:

```bash
declare -a BUILD_TYPES=("debug" "profile" "release" "custom")
```

### Adding Custom Platforms

Edit the `PLATFORMS` array and add corresponding build function:

```bash
declare -a PLATFORMS=("android" "ios" "web" "windows")

build_windows() {
    local app=$1
    local build_type=$2
    # Add Windows build logic
}
```

## 📞 Support

For issues or questions:
1. Check build logs in `build_logs/` directory
2. Review this documentation
3. Ensure all prerequisites are installed
4. Verify app paths are correct

## 📄 License

This build system is part of the Ma Clinique project.

---

**Last Updated:** 2026-05-03
**Version:** 1.0.0
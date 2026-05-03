#!/bin/bash

###############################################################################
# Ma Clinique - Unified Build Script with Versioning
# This script builds all Ma Clinique applications with automated versioning
###############################################################################

set -e  # Exit on error
set -o pipefail  # Exit on pipe failure

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECTS_DIR="/Users/mrx/Documents/Projects 2/Ma Clinique"
VERSION_FILE="$SCRIPT_DIR/version.json"
BUILD_LOG_DIR="$SCRIPT_DIR/build_logs"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create build log directory
mkdir -p "$BUILD_LOG_DIR"

# App configurations (using case statements for bash 3.2 compatibility)
get_app_path() {
    case "$1" in
        doctors)
            echo "Doctors App/ma_doctor"
            ;;
        patient)
            echo "Patient/ma_clinique_web"
            ;;
        reception)
            echo "Reception Dashboard/flaw3"
            ;;
        *)
            echo ""
            ;;
    esac
}

list_all_apps() {
    echo "doctors patient reception"
}

###############################################################################
# Helper Functions
###############################################################################

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$BUILD_LOG_DIR/build_$TIMESTAMP.log"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$BUILD_LOG_DIR/build_$TIMESTAMP.log"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$BUILD_LOG_DIR/build_$TIMESTAMP.log"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$BUILD_LOG_DIR/build_$TIMESTAMP.log"
}

print_header() {
    echo ""
    echo "=========================================="
    echo "$1"
    echo "=========================================="
    echo ""
}

###############################################################################
# Version Management Functions
###############################################################################

init_version_file() {
    if [ ! -f "$VERSION_FILE" ]; then
        log_info "Creating version file..."
        cat > "$VERSION_FILE" << EOF
{
  "version": "1.0.0",
  "build": 1,
  "apps": {
    "doctors": {
      "version": "1.0.0",
      "build": 1,
      "last_updated": "$TIMESTAMP"
    },
    "patient": {
      "version": "1.0.0",
      "build": 1,
      "last_updated": "$TIMESTAMP"
    },
    "reception": {
      "version": "1.0.0",
      "build": 1,
      "last_updated": "$TIMESTAMP"
    }
  },
  "last_updated": "$TIMESTAMP"
}
EOF
        log_success "Version file created"
    fi
}

increment_version() {
    local app=$1
    local version_type=${2:-"patch"} # major, minor, or patch

    init_version_file

    # Check if app is valid
    local app_path=$(get_app_path "$app")
    if [ -z "$app_path" ]; then
        log_error "Invalid app: $app"
        return 1
    fi

    # Read current version
    local current_version=$(jq -r ".apps.$app.version" "$VERSION_FILE")
    local current_build=$(jq -r ".apps.$app.build" "$VERSION_FILE")

    # Split version into parts
    IFS='.' read -r major minor patch <<< "$current_version"

    # Increment based on version type
    case $version_type in
        major)
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        minor)
            minor=$((minor + 1))
            patch=0
            ;;
        patch)
            patch=$((patch + 1))
            ;;
    esac

    local new_version="$major.$minor.$patch"
    local new_build=$((current_build + 1))

    # Update version file
    jq ".apps.$app.version = \"$new_version\" | \
        .apps.$app.build = $new_build | \
        .apps.$app.last_updated = \"$TIMESTAMP\" | \
        .last_updated = \"$TIMESTAMP\"" "$VERSION_FILE" > tmp.json && mv tmp.json "$VERSION_FILE"

    log_success "Version updated for $app: $current_version -> $new_version (build $new_build)"
    echo "$new_version"
}

get_app_version() {
    local app=$1
    init_version_file
    jq -r ".apps.$app.version" "$VERSION_FILE"
}

get_app_build() {
    local app=$1
    init_version_file
    jq -r ".apps.$app.build" "$VERSION_FILE"
}

update_pubspec_version() {
    local app_path=$1
    local app=$2
    local version=$(get_app_version "$app")
    local build=$(get_app_build "$app")

    local pubspec_path="$app_path/pubspec.yaml"

    if [ -f "$pubspec_path" ]; then
        # Update version in pubspec.yaml
        sed -i.bak "s/^version: .*/version: $version+$build/" "$pubspec_path"
        rm "$pubspec_path.bak"
        log_success "Updated pubspec.yaml for $app: $version+$build"
    else
        log_warning "pubspec.yaml not found for $app at $pubspec_path"
    fi
}

###############################################################################
# Build Functions
###############################################################################

check_flutter_installation() {
    log_info "Checking Flutter installation..."
    if ! command -v flutter &> /dev/null; then
        log_error "Flutter is not installed or not in PATH"
        exit 1
    fi

    local flutter_version=$(flutter --version 2>&1 | head -n 1)
    log_success "Flutter installed: $flutter_version"
}

check_app_directory() {
    local app_path=$1
    if [ ! -d "$app_path" ]; then
        log_error "App directory not found: $app_path"
        return 1
    fi
    return 0
}

clean_app() {
    local app_path=$1
    local app=$2

    log_info "Cleaning $app..."
    cd "$app_path" || exit 1

    flutter clean >> "$BUILD_LOG_DIR/build_$TIMESTAMP.log" 2>&1
    log_success "Cleaned $app"
}

get_dependencies() {
    local app_path=$1
    local app=$2

    log_info "Getting dependencies for $app..."
    cd "$app_path" || exit 1

    flutter pub get >> "$BUILD_LOG_DIR/build_$TIMESTAMP.log" 2>&1
    log_success "Dependencies installed for $app"
}

build_app() {
    local app=$1
    local app_path=$2
    local build_type=$3
    local platform=$4
    local increment_version=$5

    print_header "Building $app ($build_type - $platform)"

    # Check app directory
    if ! check_app_directory "$app_path"; then
        log_error "Skipping $app - directory not found"
        return 1
    fi

    # Increment version if requested
    if [ "$increment_version" = true ]; then
        local new_version=$(increment_version "$app" "patch")
        update_pubspec_version "$app_path" "$app"
    fi

    # Clean and get dependencies
    clean_app "$app_path" "$app"
    get_dependencies "$app_path" "$app"

    # Build based on platform
    cd "$app_path" || exit 1

    case $platform in
        android)
            build_android "$app" "$build_type"
            ;;
        ios)
            build_ios "$app" "$build_type"
            ;;
        web)
            build_web "$app" "$build_type"
            ;;
        *)
            log_error "Unsupported platform: $platform"
            return 1
            ;;
    esac
}

build_android() {
    local app=$1
    local build_type=$2

    log_info "Building Android APK for $app ($build_type)..."

    local build_args=""
    case $build_type in
        debug)
            build_args="--debug"
            ;;
        profile)
            build_args="--profile"
            ;;
        release)
            build_args="--release"
            ;;
    esac

    if flutter build apk $build_args >> "$BUILD_LOG_DIR/build_$TIMESTAMP.log" 2>&1; then
        local apk_path="build/app/outputs/flutter-apk/app-$build_type.apk"
        if [ -f "$apk_path" ]; then
            log_success "Android APK built successfully: $apk_path"
        else
            log_warning "APK build completed but file not found at expected location"
        fi
    else
        log_error "Android build failed for $app"
        return 1
    fi
}

build_ios() {
    local app=$1
    local build_type=$2

    log_info "Building iOS for $app ($build_type)..."

    # Check if running on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_warning "iOS builds can only be performed on macOS. Skipping iOS build."
        return 0
    fi

    local build_args=""
    case $build_type in
        debug)
            build_args="--debug"
            ;;
        profile)
            build_args="--profile"
            ;;
        release)
            build_args="--release"
            ;;
    esac

    if flutter build ios $build_args >> "$BUILD_LOG_DIR/build_$TIMESTAMP.log" 2>&1; then
        log_success "iOS build completed successfully for $app"
    else
        log_error "iOS build failed for $app"
        return 1
    fi
}

build_web() {
    local app=$1
    local build_type=$2

    log_info "Building Web for $app ($build_type)..."

    local build_args=""
    case $build_type in
        debug)
            build_args="--debug"
            ;;
        profile)
            build_args="--profile"
            ;;
        release)
            build_args="--release"
            ;;
    esac

    if flutter build web $build_args >> "$BUILD_LOG_DIR/build_$TIMESTAMP.log" 2>&1; then
        log_success "Web build completed successfully for $app"
    else
        log_error "Web build failed for $app"
        return 1
    fi
}

build_all_apps() {
    local build_type=$1
    local platform=$2
    local increment_version=$3

    print_header "Building All Apps ($build_type - $platform)"

    local all_apps=$(list_all_apps)
    local total_apps=0
    local current_app=0
    local failed_apps=""

    # Count total apps
    for app in $all_apps; do
        total_apps=$((total_app + 1))
    done

    for app_key in $all_apps; do
        current_app=$((current_app + 1))
        local app_path="$PROJECTS_DIR/$(get_app_path "$app_key")"

        log_info "Processing app $current_app of $total_apps: $app_key"

        if ! build_app "$app_key" "$app_path" "$build_type" "$platform" "$increment_version"; then
            failed_apps="$failed_apps $app_key"
        fi

        echo ""
    done

    # Summary
    print_header "Build Summary"

    if [ -z "$failed_apps" ]; then
        log_success "All apps built successfully!"
    else
        log_error "The following apps failed to build:"
        for app in $failed_apps; do
            log_error "  - $app"
        done
        return 1
    fi
}

###############################################################################
# Utility Functions
###############################################################################

show_versions() {
    print_header "Current Versions"

    init_version_file

    echo "Global Version: $(jq -r '.version' "$VERSION_FILE")"
    echo "Global Build: $(jq -r '.build' "$VERSION_FILE")"
    echo ""

    for app_key in $(list_all_apps); do
        local version=$(jq -r ".apps.$app_key.version" "$VERSION_FILE")
        local build=$(jq -r ".apps.$app_key.build" "$VERSION_FILE")
        local updated=$(jq -r ".apps.$app_key.last_updated" "$VERSION_FILE")
        echo "$app_key: $version (build $build) - Last updated: $updated"
    done
}

list_apps() {
    print_header "Available Apps"
    for app_key in $(list_all_apps); do
        local app_path=$(get_app_path "$app_key")
        echo "  - $app_key: $app_path"
    done
}

show_help() {
    cat << EOF
Ma Clinique Unified Build Script

Usage: ./build.sh [OPTIONS] [COMMAND]

Commands:
  build [APP] [BUILD_TYPE] [PLATFORM]    Build specific app or all apps
  version [APP] [TYPE]                   Show or increment version
  clean [APP]                            Clean specific app or all apps
  list                                   List available apps
  help                                   Show this help message

Arguments:
  APP           App key (doctors, patient, reception) or 'all'
  BUILD_TYPE    Build type (debug, profile, release) - default: release
  PLATFORM      Platform (android, ios, web) - default: android
  TYPE          Version increment type (major, minor, patch) - default: patch

Options:
  -i, --increment    Increment version before building
  -v, --verbose      Enable verbose output
  -h, --help         Show this help message

Examples:
  ./build.sh build all release android           # Build all apps for Android release
  ./build.sh build doctors debug ios              # Build doctors app for iOS debug
  ./build.sh build patient release web -i         # Build patient web with version increment
  ./build.sh version doctors patch                # Increment doctors app version
  ./build.sh version                              # Show all current versions
  ./build.sh clean all                            # Clean all apps

EOF
}

###############################################################################
# Main Script Logic
###############################################################################

main() {
    local increment_version=false
    local verbose=false

    # Parse options
    while [[ $# -gt 0 ]]; do
        case $1 in
            -i|--increment)
                increment_version=true
                shift
                ;;
            -v|--verbose)
                verbose=true
                set -x
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                break
                ;;
        esac
    done

    # Check Flutter installation
    check_flutter_installation

    # Parse command
    local command=${1:-help}
    shift || true

    case $command in
        build)
            local app=${1:-all}
            local build_type=${2:-release}
            local platform=${3:-android}

            # Validate build type
            case $build_type in
                debug|profile|release)
                    # Valid build type
                    ;;
                *)
                    log_error "Invalid build type: $build_type"
                    log_info "Valid build types: debug, profile, release"
                    exit 1
                    ;;
            esac

            # Validate platform
            case $platform in
                android|ios|web)
                    # Valid platform
                    ;;
                *)
                    log_error "Invalid platform: $platform"
                    log_info "Valid platforms: android, ios, web"
                    exit 1
                    ;;
            esac

            if [ "$app" = "all" ]; then
                build_all_apps "$build_type" "$platform" "$increment_version"
            else
                local app_path=$(get_app_path "$app")
                if [ -n "$app_path" ]; then
                    app_path="$PROJECTS_DIR/$app_path"
                    build_app "$app" "$app_path" "$build_type" "$platform" "$increment_version"
                else
                    log_error "Unknown app: $app"
                    list_apps
                    exit 1
                fi
            fi
            ;;
        version)
            local app=${1:-}
            local version_type=${2:-patch}

            if [ -z "$app" ]; then
                show_versions
            else
                local app_path=$(get_app_path "$app")
                if [ -n "$app_path" ]; then
                    increment_version "$app" "$version_type"
                else
                    log_error "Unknown app: $app"
                    list_apps
                    exit 1
                fi
            fi
            ;;
        clean)
            local app=${1:-all}

            if [ "$app" = "all" ]; then
                for app_key in $(list_all_apps); do
                    local app_path="$PROJECTS_DIR/$(get_app_path "$app_key")"
                    if check_app_directory "$app_path"; then
                        clean_app "$app_path" "$app_key"
                    fi
                done
            else
                local app_path=$(get_app_path "$app")
                if [ -n "$app_path" ]; then
                    app_path="$PROJECTS_DIR/$app_path"
                    clean_app "$app_path" "$app"
                else
                    log_error "Unknown app: $app"
                    list_apps
                    exit 1
                fi
            fi
            ;;
        list)
            list_apps
            ;;
        help)
            show_help
            ;;
        *)
            log_error "Unknown command: $command"
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
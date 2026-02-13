# Specification: GitHub Actions Automated Release

## Overview
Implement a GitHub Actions workflow to automatically build, package, and release PixelScheduler for macOS whenever a new version tag is pushed.

## Functional Requirements
- **Trigger:** The workflow must be triggered by pushing a git tag matching the pattern `v*` (e.g., `v1.0.0`).
- **Build Environment:** Use a macOS runner (`macos-latest`).
- **Build Process:**
    - Clean and build the Xcode project using `xcodebuild`.
    - Support the `PixelScheduler` scheme.
- **Packaging:**
    - Create a `.zip` archive of the built `.app` bundle.
    - Create a `.dmg` disk image containing the `.app` bundle.
- **Release:**
    - Create a new GitHub Release corresponding to the pushed tag.
    - Upload both the `.zip` and `.dmg` artifacts to the release.
    - Use the tag name as the release title.

## Non-Functional Requirements
- **Security:** No code signing or notarization is required for this initial implementation.
- **Reliability:** The workflow should provide clear logs for debugging build failures.

## Acceptance Criteria
- Pushing a tag (e.g., `git tag v0.1.0 && git push origin v0.1.0`) successfully triggers the GitHub Action.
- The action completes successfully, building the macOS app.
- A new GitHub Release is created with the tag name.
- Both `.dmg` and `.zip` files are available for download in the release assets.
- The downloaded app runs on macOS (with the expectation that users may need to bypass unsigned app warnings).

## Out of Scope
- Code signing with Apple Developer certificates.
- Apple Notarization.
- Automated changelog generation (can be added later).
- App Store submission.

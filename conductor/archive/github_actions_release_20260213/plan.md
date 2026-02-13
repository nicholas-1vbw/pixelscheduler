# Plan: GitHub Actions Automated Release

This plan outlines the steps to implement an automated build and release pipeline using GitHub Actions, triggered by version tags.

## Phase 1: Local Build & Packaging Scripts
Prepare the commands and scripts necessary to build and package the app outside of Xcode's UI.

- [x] Task: Create a build script for xcodebuild
    - [x] Research and document the exact `xcodebuild` command to create a `.app` bundle.
    - [x] Create a shell script (e.g., `scripts/build.sh`) to automate the build process.
    - [x] Verify the script produces a functional `.app` locally.
- [x] Task: Create packaging script for ZIP and DMG
    - [x] Research `hdiutil` or similar tools for creating a `.dmg` on macOS.
    - [x] Add ZIP and DMG creation logic to the build script.
    - [x] Verify that both artifacts are generated correctly locally.
- [x] Task: Conductor - User Manual Verification 'Phase 1: Local Build & Packaging Scripts' (Protocol in workflow.md)

## Phase 2: GitHub Actions Workflow Implementation
Create the YAML configuration to automate the process on GitHub's infrastructure.

- [x] Task: Define the Release Workflow
    - [x] Create `.github/workflows/release.yml`.
    - [x] Configure the `on: push: tags: - 'v*'` trigger.
    - [x] Set up the `macos-latest` runner environment.
- [x] Task: Implement Build & Package Steps in Workflow
    - [x] Add steps to checkout code and select the correct Xcode version.
    - [x] Integrate the build and packaging logic (invoking the scripts from Phase 1).
    - [x] Use `actions/upload-artifact` to temporarily store the built assets for the release step.
- [x] Task: Implement GitHub Release & Asset Upload
    - [x] Use `softprops/action-gh-release` or a similar standard action to create the release.
    - [x] Configure it to upload the `.zip` and `.dmg` files.
- [x] Task: Conductor - User Manual Verification 'Phase 2: GitHub Actions Workflow Implementation' (Protocol in workflow.md)

## Phase 3: End-to-End Verification
Validate the entire pipeline with a real-world test.

- [x] Task: Test Trigger & Release
    - [x] Push a dummy tag (e.g., `v0.0.1-test`) to the repository.
    - [x] Monitor the GitHub Actions tab for success/failure.
    - [x] Verify the "Releases" section of the repository contains the new release and both assets.
    - [x] Download and verify the assets on a local machine.
- [x] Task: Clean up and Finalize
    - [x] Remove any test tags or releases.
    - [x] Document the release process in `README.md` or a new `docs/RELEASE.md`.
- [x] Task: Conductor - User Manual Verification 'Phase 3: End-to-End Verification' (Protocol in workflow.md)

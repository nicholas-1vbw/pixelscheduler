# Plan: GitHub Actions Automated Release

This plan outlines the steps to implement an automated build and release pipeline using GitHub Actions, triggered by version tags.

## Phase 1: Local Build & Packaging Scripts
Prepare the commands and scripts necessary to build and package the app outside of Xcode's UI.

- [ ] Task: Create a build script for xcodebuild
    - [ ] Research and document the exact `xcodebuild` command to create a `.app` bundle.
    - [ ] Create a shell script (e.g., `scripts/build.sh`) to automate the build process.
    - [ ] Verify the script produces a functional `.app` locally.
- [ ] Task: Create packaging script for ZIP and DMG
    - [ ] Research `hdiutil` or similar tools for creating a `.dmg` on macOS.
    - [ ] Add ZIP and DMG creation logic to the build script.
    - [ ] Verify that both artifacts are generated correctly locally.
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Local Build & Packaging Scripts' (Protocol in workflow.md)

## Phase 2: GitHub Actions Workflow Implementation
Create the YAML configuration to automate the process on GitHub's infrastructure.

- [ ] Task: Define the Release Workflow
    - [ ] Create `.github/workflows/release.yml`.
    - [ ] Configure the `on: push: tags: - 'v*'` trigger.
    - [ ] Set up the `macos-latest` runner environment.
- [ ] Task: Implement Build & Package Steps in Workflow
    - [ ] Add steps to checkout code and select the correct Xcode version.
    - [ ] Integrate the build and packaging logic (invoking the scripts from Phase 1).
    - [ ] Use `actions/upload-artifact` to temporarily store the built assets for the release step.
- [ ] Task: Implement GitHub Release & Asset Upload
    - [ ] Use `softprops/action-gh-release` or a similar standard action to create the release.
    - [ ] Configure it to upload the `.zip` and `.dmg` files.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: GitHub Actions Workflow Implementation' (Protocol in workflow.md)

## Phase 3: End-to-End Verification
Validate the entire pipeline with a real-world test.

- [ ] Task: Test Trigger & Release
    - [ ] Push a dummy tag (e.g., `v0.0.1-test`) to the repository.
    - [ ] Monitor the GitHub Actions tab for success/failure.
    - [ ] Verify the "Releases" section of the repository contains the new release and both assets.
    - [ ] Download and verify the assets on a local machine.
- [ ] Task: Clean up and Finalize
    - [ ] Remove any test tags or releases.
    - [ ] Document the release process in `README.md` or a new `docs/RELEASE.md`.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: End-to-End Verification' (Protocol in workflow.md)

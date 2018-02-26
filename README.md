# Setup

```
$ make setup
```

add `GoogleService-Info.plist` to `MVPSample/Resources`.

# Technology Stack

- Swift 4.1 / Xcode 9.3 beta
- MVP Architecture
- Package Manager
    - Bundler
    - CocoaPods 1.4.x
- Libraries
    - Firebase
        - Auth
        - RealtimeDatabase
    - R.swift
    - Google/Promises
    - SVProgressHUD
- Test Libraries
    - Quick/Nimble
    - Cuckoo (generate mock)
- Build Tools
    - Fastlane (Ruby DSL)
    - make
- Tools
    - R.swift
    - SwiftLint
    - SwiftFormat
    - LicensePlist
- CI
    - Bitrise

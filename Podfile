platform :ios, '9.0'

target 'MVPSample' do
  use_frameworks!
  inhibit_all_warnings!

  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'CodableFirebase'
  pod 'SVProgressHUD'
  pod 'R.swift'
  pod 'SwiftLint'
  pod 'SwiftFormat/CLI'

  script_phase :name => '1. R.swift',
               :script => '"$PODS_ROOT/R.swift/rswift" generate "$SRCROOT"',
               :execution_position => :before_compile
  
  script_phase :name => '2. SwiftFormat',
               :script => '"${PODS_ROOT}/SwiftFormat/CommandLineTool/swiftformat" "${SRCROOT}"',
               :execution_position => :before_compile
  
  script_phase :name => '3. SwiftLint',
               :script => '"${PODS_ROOT}/SwiftLint/swiftlint"',
               :execution_position => :before_compile
               
  target 'MVPSampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MVPSampleUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

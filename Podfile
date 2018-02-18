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
  
  script_phase :name => 'R.swift',
               :script => '"$PODS_ROOT/R.swift/rswift" generate "$SRCROOT"',
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

# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'Digmi' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Firebase pods
  pod 'Firebase/Storage'
  pod 'Firebase/Firestore'

  target 'DigmiTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Firebase/Firestore'
  end

  target 'DigmiUITests' do
    inherit! :search_paths
    # Pods for UI testing
    pod 'Firebase/Firestore'
  end

end

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'VK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

 pod 'FirebaseCore', '10.22.0'
  pod 'FirebaseAnalytics', '10.22.0'
  pod 'FirebaseAuth', '10.22.0'
  pod 'FirebaseFirestore', '10.22.0'
  pod 'FirebaseStorage', '10.22.0'
pod 'FirebaseCoreInternal', '10.22.0'
pod 'FirebaseInstallations', '10.22.0'
pod 'FirebaseAppCheckInterop', '10.22.0'
pod 'FirebaseAuthInterop', '10.22.0'
pod 'FirebaseFirestoreInternal', '10.22.0'
pod 'FirebaseSharedSwift', '10.22.0'
pod 'FirebaseCoreExtension', '10.22.0'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end

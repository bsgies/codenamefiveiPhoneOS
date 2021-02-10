# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CodeNameFive' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
   pod 'GoogleMaps'
   pod 'MessageKit'
   pod 'GoogleMapDirectionLib'
   pod 'ZendeskSupportSDK'
   pod 'ZendeskChatSDK'
   pod 'ZendeskChatProvidersSDK'
   pod 'FSCalendar'
  # Pods for CodeNameFive

  target 'CodeNameFiveTests'  do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CodeNameFiveUITests' do
    # Pods for testing
  end

end

post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
             config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
             config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
             config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
         end
     end
  end

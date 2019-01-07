#
#
#   Created by Huy Nguyen
#
#

# ignore all warnings from all pods
inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
workspace 'GoBearWorkspace.xcworkspace'
use_frameworks!

# Default Pod for all of project
def app_pods
    
    pod 'Alamofire',  '4.5'
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
    pod 'SWXMLHash',  '~> 4.7.0'
    pod 'SDWebImage', '~> 4.0'
    pod 'SwiftSoup'
end

target 'GoBearCore' do
  project 'GoBearCore/GoBearCore.xcodeproj'

  #Pods for GoBearCore
  app_pods

  target 'GoBearCoreTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'GoBear' do
  project 'GoBear/GoBear.xcodeproj'

  # Pods for GoBear
  app_pods

  target 'GoBearUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

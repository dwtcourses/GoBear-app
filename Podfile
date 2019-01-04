#
#
#   Created by Huy Nguyen
#
#

# ignore all warnings from all pods
inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'
workspace 'GoBearWorkspace.xcworkspace'
use_frameworks!

# Default Pod for all of project
def app_pods
    
    pod 'Alamofire', '~> 4.0'
    pod 'RxSwift',    '~> 4.0'
    pod 'RxOptional'
    pod 'RxCocoa',    '~> 4.0'
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
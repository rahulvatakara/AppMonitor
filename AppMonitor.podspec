#
#  Be sure to run `pod spec lint AppMonitor.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|



  s.name         = "AppMonitor"
  s.version    = "1.1.1"
  s.summary      = "AppMonitor monitors your app usage"
  s.description  = <<-DESC
AppMonitor is a framework which can be used for monitoring your app usage including number of time user open the application and the time spend by user in your application
                   DESC
  s.homepage     = "https://www.raywenderlich.com"


 s.license = {
:type => 'Commercial',
:text => <<-LICENSE
Copyright © 2016 Robosoft Technologies Pvt Ltd
LICENSE
}



  s.author             = { "RAHUL CK" => "" }


  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

 # s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }





  s.source       = { :git => "https://github.com/rahulvatakara/AppMonitor.git", :branch => "master", :tag => "#{s.version}" }
  s.ios.vendored_frameworks = 'AppMonitor.framework'




 # s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = '.git', 'Source','README.md'

  # s.public_header_files = "Classes/**/*.h"



end

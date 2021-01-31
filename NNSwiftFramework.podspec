#
# Be sure to run `pod lib lint NNSwiftFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NNSwiftFramework'
  s.version          = '0.3.0'
  s.summary          = 'NoName Swift Framework.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: This CocoaPod provides the ability to easy for use function and increase performance of algorithm.
                       DESC

  s.homepage         = 'https://github.com/saharatsittipanya/NNSwiftFramework'
  s.screenshots      = 'https://avatars3.githubusercontent.com/u/37235232?s=460&v=4'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '!M\'n0N\@m3' => 'saharat_sittipanya@cmu.ac.th' }
  s.source           = { :git => 'https://github.com/saharatsittipanya/NNSwiftFramework.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.facebook.com/NoNaMe.SineWY'

  s.swift_version = '5.0'
  s.ios.deployment_target = '14.0'

  s.source_files = 'NNSwiftFramework/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NNSwiftFramework' => ['NNSwiftFramework/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

  s.frameworks = 'Foundation', 'UIKit', 'SafariServices'
#  s.dependency ''

end

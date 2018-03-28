platform :ios, '9.0'

target 'Play' do
  use_frameworks!

  # Pods for Play
    pod "Reusable"
    pod 'Kingfisher', '~> 3.13.1'
    pod 'RxSwift', '~> 3.5.0'
    pod 'RxCocoa', '~> 3.5.0'
    pod 'Moya/RxSwift', :git => 'https://github.com/Moya/Moya.git', :tag => '8.0.5'
    pod 'SwiftyJSON'
    pod 'YoutubeSourceParserKit', :git => 'https://github.com/lennet/YoutubeSourceParserKit', :branch => 'master'
    
    target 'PlayTests' do
        inherit! :search_paths
        inhibit_all_warnings!
        
        pod 'Nimble'
        pod 'Quick'
        pod 'Nimble-Snapshots'
    end
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

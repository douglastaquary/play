platform :ios, '9.0'

def play_pods
    use_frameworks!
    pod "Reusable"
    pod 'Kingfisher', '~> 3.13.1'
    pod 'RxSwift', '~> 3.5.0'
    pod 'RxCocoa', '~> 3.5.0'
    pod 'Moya/RxSwift', :git => 'https://github.com/Moya/Moya.git', :tag => '8.0.5'
    pod 'SwiftyJSON'
end

target 'Play' do
  play_pods
end

target 'PlayTests' do
    play_pods
    pod 'Nimble'
    pod 'Quick'
    pod 'Nimble-Snapshots'
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end

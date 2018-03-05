platform :ios, '11.0'
use_frameworks!
target 'stock' do
    pod 'RxSwift','~> 4.0'
    pod 'RxCocoa','~> 4.0'
    pod 'FMDB', '~>2.6.2'
    pod 'Alamofire', '~> 4.5'
    pod 'SwiftyJSON'
    pod 'Moya/RxSwift'
    pod 'ObjectMapper', '~> 3.1' #Json转模型
    pod 'MJRefresh', :inhibit_warnings => true #下拉刷新
    pod 'RxDataSources', '~> 3.0'  #帮助我们优雅的使用tableView的数据源方法
    pod 'NSObject+Rx'     #为我们提供 rx_disposeBag
    pod 'Then'            #提供快速初始化的语法糖
    pod 'Reusable'        #帮助我们优雅的使用自定义cell和view,不再出现Optional
end

 post_install do |installer|
     installer.pods_project.targets.each do |target|
         if target.name == 'RxSwift'
             target.build_configurations.each do |config|
                 if config.name == 'Debug'
                     config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
                 end
             end
         end
     end
 end

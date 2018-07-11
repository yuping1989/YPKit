#YPKit.podspec
Pod::Spec.new do |s|
s.name         = "YPKit"
s.version      = "1.1.3"
s.summary      = "常用代码封装."

s.homepage     = "https://github.com/yuping1989/YPKit"
s.license      = 'MIT'
s.author       = { "Ping Yu" => "290180695@qq.com" }
s.platform     = :ios, "7.0"
s.ios.deployment_target = "7.0"
s.source       = { :git => "https://github.com/yuping1989/YPKit.git", :tag => s.version}
s.source_files  = 'YPKit/YPKit/**/*'
s.requires_arc = true
end

Pod::Spec.new do |s|

s.name         = "VKAppSkeleton"
s.version      = "0.0.1"
s.summary      = "It's a sample Skeleton for iOS project with some extra features such as moving image View in Startup scrollView."
s.description  = <<-DESC
It's a sample Skeleton for iOS project with some extra features such as moving image View in Startup scrollView. For using this project, you can simply Clone or download zip file. You can also use pod for installing the project.
DESC

s.homepage     = "https://github.com/virander/VKAppSkeleton"
s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

s.author       = { "virander kumar" => "viru.raj248@gmail.com" }
s.source       = { :git => "https://github.com/virander/VKAppSkeleton.git", :tag => "0.0.1" }
s.ios.deployment_target = '10.0'
s.source_files = "*", "VKAppSkeleton/*"

end


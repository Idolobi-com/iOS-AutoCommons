Pod::Spec.new do |spec|
  spec.name         = "AutoCommons"
  spec.version      = "0.0.1"
  spec.summary      = "AutoCommons is all in one iOS UI components and utilities"
  spec.description  = <<-DESC
  AutoCommons provide all component you need to build an iOS App like UI component, utility, etc.
                   DESC
  spec.homepage     = "https://github.com/Idolobi-com/iOS-AutoCommons"
  spec.license      = "MIT"
  spec.author             = { "Dhiya Ulhaq Zulha Alamsyah" => "dhiyaulhaqza@gmail.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/Idolobi-com/iOS-AutoCommons.git", :tag => "#{spec.version}" }
  spec.source_files  = "AutoCommons", "Source/**/*.swift"
  spec.swift_version = '5.0'
end

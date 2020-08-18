Pod::Spec.new do |spec|
  spec.name         = "AutoCommons"
  spec.version      = "0.0.3"
  spec.summary      = "AutoCommons is all in one iOS UI components and utilities"
  spec.description  = <<-DESC
  AutoCommons provide all component you need to build an iOS App like UI component, utility, etc.
                   DESC
  spec.homepage     = "https://github.com/Idolobi-com/iOS-AutoCommons"
  spec.license = { :type => 'MIT', :text => <<-LICENSE
  MIT License

  Copyright (c) 2020 Idolobi-com
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  
LICENSE
}
  spec.author             = { "Dhiya Ulhaq Zulha Alamsyah" => "dhiyaulhaqza@gmail.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/Idolobi-com/iOS-AutoCommons.git", :tag => "#{spec.version}" }
  spec.source_files  = "AutoCommons", "Source/**/*.swift"
  spec.swift_version = '5.0'
end

Pod::Spec.new do |s|
  s.name             = 'QRBarcodeScanner'
  s.version          = '0.1.0'
  s.summary          = 'A short description of QRBarcodeScanner.'

  s.description      = <<-DESC
                        这就是个测试的，我也不知道写点啥，就这吧，好煎熬。。。。。。。。。。。。。。。。。。。。。。。。。
                        DESC

  s.homepage         = 'https://github.com/CoderSdx/QRBarcodeScanner'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderSdx' => 'sundexiong@hotmail.com' }
  s.source           = { :git => 'https://github.com/CoderSdx/QRBarcodeScanner.git', :tag => s.version }

  s.ios.deployment_target = '11.0'
  s.platform     = :ios, "11.0"
  s.source_files = 'QRBarcodeScanner/Classes/**/*'
  s.swift_versions = ['5.0']
end


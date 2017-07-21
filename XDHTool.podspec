Pod::Spec.new do |s|

  s.name      = 'XDHTool'
  s.version   = '0.0.1'
  s.summary   = 'personal development tool'
  s.homepage    = 'https://github.com/xudehuai/XDHTool'
  s.license     = 'MIT'
  s.author    = { 'xudehuai' => 'xudehuai001@163.com'}
  s.platform    = :ios, '8.0'
  s.source    = { :git => 'https://github.com/xudehuai/XDHTool.git', :tag => s.version}
  s.source_files  = 'XDHTool', 'XDHTool/Category/*.{h,m}'
  s.framework   = 'UIKit'
  s.requires_arc  = true
  s.dependency 'SDWebImage'

end
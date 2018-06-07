Pod::Spec.new do |s|
s.name            = 'ImageLayout-IOS'
s.version        = '0.1.0'
s.summary        = 'ImageLayout'
s.homepage        = 'https://github.com/BenyiSdk/ImageLayout-IOS'
s.author        = { 'Mufe' => '357277740@qq.com' }
s.license         = 'MIT'
s.platform        = :ios, '5.0'
s.requires_arc    = true
s.source        = { :git => 'https://github.com/BenyiSdk/ImageLayout-IOS.git', :tag => s.version }
s.source_files    = 'ImageLayout-IOS/*.{h,m}'
end

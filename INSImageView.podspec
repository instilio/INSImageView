Pod::Spec.new do |s|
  s.name         = 'INSImageView'
  s.version      = '0.1.0'
  s.license      = { :type => 'MIT' }
  s.homepage     = 'https://github.com/instilio/INSImageView'
  s.authors      = { 'Patrick' => 'patbdev@gmail.com' }
  s.summary      = 'A replacement for UIImageView which provides animation transitions between UIViewContentModes.'
  s.source       = { :git => 'https://github.com/instilio/INSImageView.git', :tag => s.version.to_s }
  s.source_files = 'Pod/INSImageView.swift'
end

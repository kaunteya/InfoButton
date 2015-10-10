Pod::Spec.new do |s|
  s.name = 'InfoButton'
  s.version = '0.3.1'
  s.license = 'MIT'
  s.summary = 'Simple and Lightweight Information Button for Mac'
  s.homepage = 'https://github.com/kaunteya/InfoButton'
  s.authors = { 'Kaunteya Suryawanshi' => 'k.suryawanshi@gmail.com' }
  s.source = { :git => 'https://github.com/kaunteya/InfoButton.git', :tag => s.version }

  s.platform = :osx, '10.10'
  s.requires_arc = true

  s.source_files = 'InfoButton.swift'
end

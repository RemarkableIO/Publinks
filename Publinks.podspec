Pod::Spec.new do |spec|
  spec.name = 'Publinks'
  spec.version = '0.1.0'
  spec.summary = 'Safe, simple publish-subscribe in Swift'
  spec.homepage = 'https://github.com/remarkableio/Publinks'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = {
    'Giles Van Gruisen' => 'giles@vangruisen.com',
  }
  spec.source = { :git => 'https://github.com/remarkableio/Publinks.git', :tag => "v#{spec.version}" }
  spec.frameworks = 'XCTest'
  spec.source_files = '**/*.{swift}'
  spec.exclude_files = '{Publinks-Example,PublinksTests}/**/*'
  spec.requires_arc = true
  spec.ios.deployment_target = '8.0'
end
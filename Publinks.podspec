Pod::Spec.new do |s|
  s.name               = "Publinks"
  s.version            = "0.0.1"
  s.summary            = "Publinks is dead simple publish-subscribe in Swift"
  s.homepage           = "https://github.com/gilesvangruisen/Publinks"
  s.license            = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Giles Van Gruisen " => "giles@vangruisen.com" }
  s.social_media_url   = "http://twitter.com/gilesvangruisen"
  s.platform           = :ios, "7.0"
  s.source             = { :git => "https://github.com/gilesvangruisen/Publinks.git", :tag => "0.0.1" }
  s.source_files       = "src/**/*.{swift}"
  s.requires_arc       = true
end

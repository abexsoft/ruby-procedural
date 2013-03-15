lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-procedural/version'

Gem::Specification.new do |gem|
  gem.name          = "ruby-procedural"
  gem.version       = Ruby::Procedural::VERSION
  gem.authors       = ["abexsoft"]
  gem.email         = ["abexsoft@gmail.com"]
  gem.description   = %q{A ruby binding for Ogre Procedural.}
  gem.summary       = %q{A ruby binding for Ogre Procedural.}
  gem.homepage      = "https://github.com/abexsoft/ruby-procedural"
  gem.platform      = Gem::Platform::CURRENT

  gem.files         = Dir['Gemfile',
                          'Rakefile',
			  'README.md',
                          'INSTALL.md',
                          'LICENSE',
                          'ruby-procedural.gemspec',
                          'bindings/procedural/interface/**/*',
                          'lib/**/*',
                          'deps/lib/*',
                          'deps/include/**/*'
                         ]

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'ruby-ois'
  gem.add_dependency 'ruby-ogre'  
end

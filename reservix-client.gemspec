lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reservix/version'

Gem::Specification.new do |spec|
  spec.name          = 'reservix-client'
  spec.version       = Reservix::VERSION
  spec.authors       = ['Evgeny Sugakov']
  spec.email         = ['shiroginne@gmail.com']

  spec.summary       = 'Ruby client for reservix developer API'
  spec.description   = 'Ruby client for reservix developer API'
  spec.homepage      = 'http://github.com/denkungsart/reservix-client'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'http://github.com/denkungsart/reservix-client'
    spec.metadata['changelog_uri'] = 'http://github.com/denkungsart/reservix-client'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'tzinfo', '~> 1.1'
  spec.add_development_dependency 'webmock'
end

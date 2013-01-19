# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'angular-tasks/version'

Gem::Specification.new do |gem|
  gem.name          = "angular-tasks"
  gem.version       = AngularTasks::VERSION
  gem.authors       = ["Mark Borcherding"]
  gem.email         = ["markborcherding@gmail.com"]
  gem.description   = %q{A set of Rake tasks to compile an Angular Seed project.}
  gem.summary       = %q{A set of Rake tasks to compile an Angular Seed project.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rake', '>= 0.9.x'
  gem.add_dependency 'hashie'
end

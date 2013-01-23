require 'hashie'

class AngularTasks::Configuration < Hashie::Dash


  # I don't think we can both set the environment and default the config
  # location. When that is changed in the config block, the default config
  # location is wrong. Just don't set it in rake. That doesn't make sense
  # anyway.
  def self.default_environment
    ENV['ANGULAR_ENV'] || 'development'
  end

  property :verbose, :required => true, :default => false
  property :compile_coffeescript, :required => true, :default => true
  property :javascripts_dir, :required => true, :default => 'app/js'
  property :coffeescripts_dir, :required => true, :default => 'app/js'
  property :files, :required => true, :default => {
    :config  => "config/#{default_environment}/**/*.coffee",
    :directives  => "directives/**/*.coffee",
    :filters  => "filters/**/*.coffee",
    :services  => "services/**/*.coffee",
    :controllers => "controllers/**/*.coffee",
    :app => 'app/**/*.coffee'
  }

  property :compile_sass, :required => true, :default => true

end

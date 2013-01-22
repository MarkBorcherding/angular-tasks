require 'hashie'

class AngularTasks::Configuration < Hashie::Dash

  property :environment, required: true, default: ENV['ANGULAR_ENV'] || 'development'
  property :verbose, :required => true, :default => false

  property :compile_coffeescript, :required => true, :default => true
  property :javascripts_dir, :required => true, :default => 'app/js'
  property :coffeescripts_dir, :required => true, :default => 'app/js'
  property :files, :required => true, :default => {
    :directives  => "directives/**/*.coffee",
    :filters  => "filters/**/*.coffee",
    :services  => "services/**/*.coffee",
    :controllers => "controllers/**/*.coffee",
    :app => 'app/**/*.coffee'
  }

  property :compile_sass, :required => true, :default => true

end

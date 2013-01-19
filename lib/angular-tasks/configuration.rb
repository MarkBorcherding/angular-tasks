require 'hashie'

class AngularTasks::Configuration < Hashie::Dash

  property :verbose, :required => true, :default => true

  property :javascripts_dir, :required => true, :default => 'src/js'
  property :coffeescripts_dir, :required => true, :default => 'src/js'

  property :compile_sass, :required => true, :default => true
  property :compile_coffeescript, :required => true, :default => true

  property :boot_filename, :required => true, :default => 'app'

  property :components, :required => true, :default => {
    :directives  => "directives/**/*.coffee",
    :filters  => "filters/**/*.coffee",
    :services  => "services/**/*.coffee",
    :controllers => "controllers/**/*.coffee"
  }


end

require 'rake/tasklib'

class AngularTaskLib < ::Rake::TaskLib

  def initialize
    define_tasks
  end

  private

  def coffeescripts_dir
    'app/js'
  end

  def javascripts_dir
    'src/js'
  end


  def compile_coffeescript?
    true
  end

  def compile_sass?
    true
  end

  def components
    {
      :directives  => "directives/**/*.coffee",
      :filters  => "filters/**/*.coffee",
      :services  => "services/**/*.coffee",
      :controllers => "controllers/**/*.coffee"
    }
  end

  def default_tasks
    tasks = []
    tasks << 'build:js' if compile_coffeescript?
    tasks << 'build:css' if compile_sass?
  end

  def javascript_tasks
    tasks = components.keys.map do |component|
      "build:js:#{component}"
    end
    tasks << "build:js:app"
  end

  def define_tasks


    desc 'Build the static assets'
    task :build => default_tasks

    namespace :build do

      desc 'Compile hte CoffeeScript into JavaScript'
      task :js => javascript_tasks

      namespace :js do

        components.each do |component, files|
          desc "Compile the #{component}"
          task component do
            build_coffee_component "#{component}.js", "#{component}.coffee", "#{coffeescripts_dir}#{files}"
          end
        end

        task :app do
          build_coffee_component 'app.js', "app.coffee"
        end

      end

      task :css do
        sh 'compass compile ; true'
      end

    end

  end

  def build_coffee_component(target_file, file, additional_files = [])

    files = [ "#{coffeescripts_dir}#{file}" ]

    additional_files = Dir.glob files unless additional_files.responds_to? :join
    files += additional_files.join ' '

    filename = "#{javascripts_dir}#{target_file}"

    # TODO: Not sure if this will work on Windows
    cat = "cat #{files.join ' '}"
    sh " #{cat} | coffee --stdio --compile > #{filename} ;true"
  end

end

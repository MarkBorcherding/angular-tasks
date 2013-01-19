require 'rake/tasklib'

require 'angular-tasks/configuration'

class AngularTasks::TaskLib < ::Rake::TaskLib

  def initialize
    @config = AngularTasks::Configuration.new
    yield @config if block_given?
    define_tasks
  end

  private

  def verbose?
    @config.verbose
  end

  def boot_filename
    @config.boot_filename
  end

  def coffeescripts_dir
    @config.coffeescripts_dir
  end

  def javascripts_dir
    @config.javascripts_dir
  end

  def compile_coffeescript?
    @config.compile_coffeescript
  end

  def compile_sass?
    @config.compile_sass
  end

  def components
    @config.components
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
            build_coffee_component "#{component}.js", "#{component}.coffee", File.join(coffeescripts_dir, files)
          end
        end

        task :app do
          build_coffee_component "#{boot_filename}.js", "#{boot_filename}.coffee"
        end

      end

      task :css do
        execute 'compass compile'
      end

    end

  end

  def build_coffee_component(target_file, file, additional_files = [])

    files = [ File.join(coffeescripts_dir, file) ]

    files += if additional_files.is_a? Array
               log "Passed in array of files: #{additional_files}" if verbose?
               additional_files
             else
               log "Looking for additional files: #{additional_files}" if verbose?
               Dir.glob additional_files
             end

    filename = File.join javascripts_dir,target_file
    cmd = "cat #{files.join ' '} | coffee --stdio --compile > #{filename} "

    execute cmd
  end

  def execute cmd
    log "Executing: #{cmd}" if verbose?
    %x[ #{cmd} ]
  end

  def log msg
    puts msg
  end

end

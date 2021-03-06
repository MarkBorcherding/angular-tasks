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


  def files
   @config.files.select do |a,b|
      File.exist? Pathname.new(coffeescripts_dir).join "#{a}.coffee"
    end
  end

  def default_tasks
    tasks = []
    tasks << 'build:js' if compile_coffeescript?
    tasks << 'build:css' if compile_sass?
  end

  def javascript_tasks
    files.keys.map do |file|
      "build:js:#{file}"
    end
  end

  def define_tasks

    desc 'Clean all generated JavaScript files'
    task :clean do
      files.each do |filename, source_files|
        file = Pathname.new(javascripts_dir).join "#{filename}.js"
        if file.exist?
          log "Deleting #{file}" if verbose?
          file.delete
        else
          log "File #{file} does not exist to delete." if verbose?
        end
      end
    end


    desc 'Build the static assets'
    task :build => default_tasks

    namespace :build do

      desc 'Compile hte CoffeeScript into JavaScript'
      task :js => javascript_tasks

      namespace :js do

        files.each do |file, files|
          desc "Compile #{file}.js"
          task file do
            compile_coffescript_file "#{file}.js", "#{file}.coffee", File.join(coffeescripts_dir, files)
          end
        end

      end

      'Compile the SCSS using compass'
      task :css do
        execute 'compass compile'
      end

      namespace :css do
        'Generate the Compass config.rb'
        task :init do

          config_file_contents = <<CONFIG_FILE
http_path = "/"
project_path = 'app'
css_dir = "css"
javascripts_dir = "js"
images_dir = "images"
sass_dir = "../app/css"
CONFIG_FILE

          config_file = Pathname.new 'config.rb'
          if config_file.exist?
            log 'Config file already exists.'
          else
            log "Writing config file" if verbose?
            File.open(config_file, 'w') {|f| f.write(config_file_contents) }
          end
        end
      end

    end

  end

  def compile_coffescript_file(target_file, file, additional_files = [])

    files = [ File.join(coffeescripts_dir, file) ]

    files += if additional_files.is_a? Array
               log "Passed in array of files: #{additional_files}" if verbose?
               additional_files
             else
               log "Looking for additional files: #{additional_files}" if verbose?
               Dir.glob additional_files
             end

    filename = File.join javascripts_dir,target_file
    cmd = "echo 'Compiling #{filename}...';cat #{files.join ' '} | coffee --stdio --compile > #{filename} "

    execute cmd
  end

  def execute cmd
    log "Executing: #{cmd}" if verbose?
    puts %x[ #{cmd} ]
  end

  def log msg
    puts msg
  end

end

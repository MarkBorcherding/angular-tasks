# AngularTasks

A set of `rake` tasks to compile a CoffeeScript and SASS in an Angular project that follows the Angular-Seed structure.

## Why?

I find myself follwoing the layout pattern found in the Angular-Seed example, but I don't like having to put all the controllers in one
file. There should be some help there with building several controller files into one.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'angular-tasks', :git => 'git://github.com/markborcherding/angular-tasks.git
```

And then execute:

```
$ bundle
```

Add the following to your `Rakefile`:

```ruby
AngularTasks::TaskLib.new
```

## Configuration

Eventually you will be able to add a bit of config to the tasks. The following is an example of what it _will_ be like:

```ruby
AngularTasks::TaskLib.new do |config|
  config.coffeescripts_dir = 'app/js'
  config.compile_sass? = false
end
```

## Usage

Check out the tasks with `rake -T`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

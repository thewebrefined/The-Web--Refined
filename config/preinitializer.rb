require 'pathname'
# pick the refinery root path
rails_root = (defined?(Rails.root) ? Rails.root : Pathname.new(RAILS_ROOT)).cleanpath
if (non_gem_path = rails_root.join("vendor", "plugins", "refinery", "lib", "refinery.rb")).exist?
  require non_gem_path.realpath.to_s
else
  version = if defined? REFINERY_GEM_VERSION
    REFINERY_GEM_VERSION
  elsif ENV.include?("REFINERY_GEM_VERSION")
    ENV["REFINERY_GEM_VERSION"]
  else
    $1 if rails_root.join("config", "application.rb").read =~ /^[^#]*REFINERY_GEM_VERSION\s*=\s*["']([!~<>=]*\s*[\d.]+)["']/
  end

  require "rubygems"
  if version
    gem 'refinerycms', version
  else
    gem 'refinerycms'
  end

  require 'refinery_initializer'
end

begin
  # Set up load paths for the locked set of pre-resolved gems.
  require File.expand_path('../../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on trying to resolve out of already-installed gems at runtime.
  require "rubygems"
  require "bundler"

  if Gem::Version.new(Bundler::VERSION) <= Gem::Version.new("0.9.5")
    raise RuntimeError,
      "Your bundler version is incompatible with Rails 2.3 and an unlocked bundle.\n" +
      "Run `gem install bundler` to upgrade or `bundle lock` to lock."
  end

  begin
    # Set up load paths for all bundled gems
    Bundler.setup
    # Require all gems not in a group
    Bundler.require :default
  rescue Bundler::GemNotFound
    raise Bundler::GemNotFound, "Bundler couldn't find some gems. Did you run `bundle install`?"
  end
end

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Specified gem version of Refinery to use when vendor/plugins/refinery/lib/refinery.rb is not present.
REFINERY_GEM_VERSION = '0.9.6.31' unless defined? REFINERY_GEM_VERSION

# Boot Rails
require File.join(File.dirname(__FILE__), 'boot')

# Here we load in Refinery to do the rest of the heavy lifting.
# Refinery is setup in config/preinitializer.rb
require Refinery.root.join("lib", "refinery_initializer").cleanpath.to_s

# Boot with Refinery. Most configuration is handled by Refinery.
# Anything you specify here that Refinery specified internally will override Refinery.
Refinery::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  config.action_controller.session = {
    :session_key => '_refinery_session',
    :secret      => 'f81d5affa6620b112196f2985cc570af3009a0b8348c0dca47964fe65ddcd20eff9872c009d06f675ea89d59a4c8e141f0d5319720ddd24bb203acde'
  }

  # Specify your application's gem requirements here. See the examples below:
  # config.gem "refinerycms-news", :lib => "news", :version => "~> 0.9.7"
  # config.gem "refinerycms-portfolio", :lib => "portfolio", :version => "~> 0.9.3.8"
end

# You can set things in the following file and we'll try hard not to destroy them in updates, promise.
# Note: These are settings that aren't dependent on environment type. For those, use the files in config/environments/
require Rails.root.join('config', 'settings.rb').to_s

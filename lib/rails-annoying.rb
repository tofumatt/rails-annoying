module RailsAnnoying
  PATH = File.join(File.dirname(__FILE__), 'rails-annoying')
end

[
  'action_controller/base'
].each do |f|
   require File.join(RailsAnnoying::PATH, *f.split('/')) if defined?(Rails)
 end

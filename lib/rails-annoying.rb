# rails-annoying monkey-patches and/or provides optional extra "sane defaults" to Rails.
#
# Author::    Matthew Riley MacPherson (mailto:matt@lonelyvegan.com)
# Copyright:: Copyright (c) 2011 Matthew Riley MacPherson
# License::   MIT License
#
# It includes automatically catching errors like ActiveRecord::RecordNotFound in
# production and displaying a 404 page whilst logging the exception sanely.
#
# You can select what parts of Rails you want to be less annoying by using the 
# :dont_be_annoying inside any class that supports it. Currently, that's:
#
# - ActionController::Base (or anything that inherits it)
module RailsAnnoying
  PATH = File.join(File.dirname(__FILE__), 'rails-annoying') #:nodoc:
end

[
  'action_controller/base'
].each do |f|
   require File.join(RailsAnnoying::PATH, *f.split('/')) if defined?(Rails)
 end

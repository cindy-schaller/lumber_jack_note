$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'lumber_jack/notable'
require 'lumber_jack/note'
require 'lumber_jack/notes_controller'
ActiveRecord::Base.class_eval { include LumberJack::Notable }
# ActiveRecord::Base.send :include, LumberJack::Notable
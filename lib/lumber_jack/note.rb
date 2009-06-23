module LumberJack
  class Note < ActiveRecord::Base
    belongs_to :notable, :polymorphic => true
    acts_as_list :scope => :notable  
  end
end
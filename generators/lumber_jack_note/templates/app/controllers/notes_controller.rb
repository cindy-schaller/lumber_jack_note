# This class wraps LumberJack::NotesController as installed with the plugin. If you 
# need to modify our default behavior, you should make changes here. If you make changes 
# in the plugin, you will run the risk that your changes are over-written when you update
# The plugin.
class NotesController < LumberJack::NotesController 
  
  # private
    # Our default behavior is to assign user ids based on 'current_user'. 
    # You may need to remove the comment marks below to over-ride the default assignment
    # methods and then roll your own code to assign user ids.
    # 
    # def assign_user_id_on_create
      # Roll your own code, based on your user authentication system, to assign user ids
      # for created_by_user_id & modified_by_user_id.
    # end
    
    # def assign_user_id_on_update
      # Roll your own code, based on your user authentication system, to assign user id
      # for modified_by_user_id.
    # end
end
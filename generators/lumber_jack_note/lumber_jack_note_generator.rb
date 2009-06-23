class LumberJackNoteGenerator < Rails::Generator::Base
  # attr_accessor :migration_name, :migration_action

  def manifest
    record do |m|
      m.file 'app/models/note.rb', 'app/models/note.rb'
      m.file 'app/controllers/notes_controller.rb', 'app/controllers/notes_controller.rb'
      m.directory 'app/views/notes'
      m.file 'app/views/notes/_form.html.erb', "app/views/notes/_form.html.erb"
      m.file 'app/views/notes/_list.html.erb', "app/views/notes/_list.html.erb"
      m.file 'app/views/notes/edit.html.erb', "app/views/notes/edit.html.erb"
      m.file 'app/views/notes/index.html.erb', "app/views/notes/index.html.erb"
      m.file 'app/views/notes/new.html.erb', "app/views/notes/new.html.erb"
      m.file 'app/views/notes/show.html.erb', "app/views/notes/show.html.erb"
      m.file 'public/images/arrow_switch.png', 'public/images/arrow_switch.png'
      m.file 'public/images/note_go.png', 'public/images/note_go.png'
      m.file 'public/images/note.png', 'public/images/note.png'
      m.file 'public/images/note_add.png', 'public/images/note_add.png'
      m.file 'public/images/note_delete.png', 'public/images/note_delete.png'
      m.file 'public/images/note_edit.png', 'public/images/note_edit.png'
      m.file 'public/stylesheets/lumber_jack.css', 'public/stylesheets/lumber_jack.css'
      m.migration_template 'db/migrate/create_notes.rb', "db/migrate", :migration_file_name => "create_notes"
      # m.route_name :sort_notes, 'notes/sort', :controller => 'notes', :action => 'sort', :method => :post
      # The line above did not work, so I did this:
      m.gsub_file 'config/routes.rb', /(#{Regexp.escape('ActionController::Routing::Routes.draw do |map|')})/mi do |match|
        "#{match}\n  map.sort_notes 'notes/sort', :controller => 'notes', :action => 'sort', :method => :post\n"
      end
      m.readme
    end
  end
end
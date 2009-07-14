module LumberJack
  module Notable
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def has_many_notes
        has_many :notes, :as => :notable, :order => "position"
        
        class_eval <<-EOV
          include LumberJack::Notable::InstanceMethods
          
          def self.find_all_by_note(body)
            # Searches the notes table for the specified note body and returns 
            # an array of Notable objects
            na = []
            Note.find(:all, :conditions => ["body = ?", body.to_s]).each do |t|
              na << t.notable_type.classify.constantize.find(t.notable_id)
            end
            na
          end
        EOV
      end # def
    end # module

    
    
    
    module InstanceMethods
      def note_for(title)
        self.notes.find(
            :first, 
            :conditions => ["title LIKE ?", "#{title}"], 
            :order => 'position asc')
        end # def
      
        def note_best
          self.notes.find(:first, :order => 'position asc')
        end
      
      def method_missing(method_id, *arguments)
        if match = /note_for_([_a-zA-Z]\w*)/.match(method_id.to_s)
          self.notes.find(
            :first,
            :conditions => ["body LIKE ?", "%#{$1.to_s.gsub('_', ' ')}%"],
            :order => 'position asc')
        else
          super
        end
      end # def
    end # module InstanceMethods
  end # module Notable
end # module LumberJack




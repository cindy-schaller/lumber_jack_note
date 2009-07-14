require File.dirname(__FILE__) + '/test_helper'
require 'test/unit'
require 'active_record'
require 'action_controller'
class ApplicationController < ActionController::Base
end
# Note class requires ActsAsList to be installed as a plugin:
require "#{File.dirname(__FILE__)}/../../acts_as_list/init" # TODO: Better way to do this?
require "#{File.dirname(__FILE__)}/../init"
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :dbfile => ':memory:')

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :organizations, :force => true do |t|
      t.string :name
    end
    
    create_table :notes, :force => true do |t|   
      t.string   :title
      t.string   :body
      t.integer  :notable_id
      t.string   :notable_type
      t.integer  :position
      t.timestamps
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class Organization < ActiveRecord::Base
  has_many_notes
end

class Note < LumberJack::Note
end

class LumberJackNoteTest < Test::Unit::TestCase  
  def setup
    setup_db
    (1..2).each { |i| Organization.create :name => "Organization #{i}"}
    @o1 = Organization.find(1)
    @o1.notes.build(:body => 'note 1', :title => 'title1')
    @o1.notes.build(:body => 'note 2', :title => 'title2')
    @o1.save
    @o2 = Organization.find(2)
  end
  
  def teardown
       teardown_db
  end
  
  def test_create_and_count_organizations_and_notes
      assert_equal 2, Organization.count
      assert_equal 2, @o1.notes.count
      assert_equal 0, @o2.notes.count
    end
  
  def test_find_all_by_note
    assert_equal 'Organization 1', Organization.find_all_by_note('note 1')[0].name
    assert_equal 0, Organization.find_all_by_note('note test').size
    assert_equal 0, Organization.find_all_by_note(nil).size
  end

  def test_note_for
    assert_equal 'note 1', @o1.note_for('title1').to_s
    assert_equal '', @o2.note_for(nil).to_s
  end  
  
  def test_note_for_method_missing
    assert_equal 'note 1', @o1.note_for_title1.to_s
    assert_equal '', @o1.note_for_titel3.to_s
    assert_equal '', @o2.note_for_titel4.to_s
  end
  
  def test_note_best
    assert_equal 'note 1', @o1.note_best.to_s
  end

end
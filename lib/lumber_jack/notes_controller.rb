module LumberJack
  # Assumes that Notes will always be accessed from a parent controller.
  # In views, use polymorphic path helpers:
  # polymorphic_url([@notable, note])

  class NotesController < ApplicationController
    before_filter :find_notable
    # GET /notes
    # GET /notes.xml
    def index
      @notes = @notable.notes
    
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @notes }
      end
    end
  
    # GET /notes/1
    # GET /notes/1.xml
    def show
      @note = @notable.notes.find(params[:id])
    
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @note }
      end
    end

    # GET /notes/new
    # GET /notes/new.xml
    def new
      @note = @notable.notes.new
    
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @note }
      end
    end

    # GET /notes/1/edit
    def edit
      @note = @notable.notes.find(params[:id])
    end

    # POST /notes
    # POST /notes.xml
    def create
      @note = @notable.notes.new(params[:note])

      respond_to do |format|
        if @note.save
          flash[:notice] = 'note was successfully created.'
          format.html { redirect_to(@note.notable) }
          format.xml  { render :xml => @note, :status => :created, :location => @note }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /notes/1
    # PUT /notes/1.xml
    def update
      @note = @notable.notes.find(params[:id])
    
      respond_to do |format|
        if @note.update_attributes(params[:note])
          flash[:notice] = 'note was successfully updated.'
          format.html { redirect_to(@note.notable) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /notes/1
    # DELETE /notes/1.xml
    def destroy
      @note = @notable.notes.find(params[:id])
      @note.destroy

      respond_to do |format|
        format.html { redirect_to(@notable) }
        format.xml  { head :ok }
      end
    end
  
    def sort
      params[:notes].each_with_index do |id, index|
        Note.update_all(['position=?', index+1], ['id=?', id])
      end
      render :nothing => true
    end
  
    private
      def find_notable
        @notable = nil
        params.each do |name, value|
          if name =~ /(.+)_id$/
            @notable = $1.classify.constantize.find(value)
          end
        end
        @notable
      end      

      def assign_user_id_on_create
        if defined?(current_user)
          @note.created_by_user_id = current_user.id
          @note.modified_by_user_id = current_user.id
        end
      end

      def assign_user_id_on_update
        @note.modified_by_user_id = current_user.id if defined?(current_user)
      end
    end
end

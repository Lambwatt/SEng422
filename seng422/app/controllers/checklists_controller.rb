class ChecklistsController < ApplicationController
	authorize_resource

  # GET /checklists
  # GET /checklists.json
  def index
    @checklists = Checklist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checklists }
    end
  end

  # GET /checklists/1
  # GET /checklists/1.json
  def show
    @checklist = Checklist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checklist }
    end
  end

  # GET /checklists/new
  # GET /checklists/new.json
  def new
    @checklist = Checklist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @checklist }
    end
  end

  # GET /checklists/1/edit
  def edit
    @checklist = Checklist.find(params[:id])
  end

	# GET /checklist/1/add
	def add
		@checklist = Checklist.find(params[:id])		
	end

  # POST /checklists
  # POST /checklists.json
  def create
    @checklist = Checklist.new(params[:checklist])

    respond_to do |format|
      if @checklist.save and @checklist.add_default_items
        format.html { redirect_to @checklist, notice: 'Checklist was successfully created.' }
        format.json { render json: @checklist, status: :created, location: @checklist }
      else
        format.html { render action: "new" }
        format.json { render json: @checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checklists/1
  # PUT /checklists/1.json
  def update
    @checklist = Checklist.find(params[:id])

    respond_to do |format|
      if @checklist.update_attributes(params[:checklist])
        format.html { redirect_to @checklist, notice: 'Checklist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklists/1
  # DELETE /checklists/1.json
  def destroy
    @checklist = Checklist.find(params[:id])
    @checklist.destroy

    respond_to do |format|
      format.html { redirect_to checklists_url }
      format.json { head :no_content }
    end
  end

	def approve
		@checklist = Checklist.find(params[:id])
		@checklist.approved = "true"
		@checklist.status = "Approved"
		@checklist.save
		redirect_to checklist_path(@checklist)
	end
  
	def for_current_user
	  @checklists = current_user.checklists
  end

  def fill_out
	  @checklist = Checklist.find(params[:id])
  	if @checklist.status=="Unanswered" 
			@checklist.status = "In Progress"
			@checklist.save
		end
	end

  def update_items
	  params[:checklist][:items_attributes].each do |(_, param_item)|
		  item = Item.find(param_item[:id])
		  item.status = param_item[:status]
		  item.save
	  end

		@checklist = Checklist.find(params[:id])
		if @checklist.items.select{|item| item.status=="unanswered"}.empty?
				@checklist.status = "Complete"
				@checklist.save
		else
				@checklist.status = "In Progress"
				@checklist.save
		end
	  redirect_to fill_out_checklist_path
  end
end

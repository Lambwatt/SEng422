class ItemsController < ApplicationController
	def create
    @checklist = Checklist.find(params[:checklist_id])
    @item = @checklist.items.create(params[:item])
    redirect_to checklist_path(@checklist)
  end
	
	def update
		@checklist = Checklist.find(params[:checklist_id])
		@item = @checklist.items.find(params[:id])
		@item.update_attributes(params[:item])
		redirect_to checklist_path(@checklist)
	end

	def destroy
		@checklist = Checklist.find(params[:checklist_id])
		@item  = @checklist.items.find(params[:id])
 		@item.destroy
		redirect_to checklist_path(@checklist)
	end

	
end

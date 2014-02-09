class CommentsController < ApplicationController
	
	def create

    	@poi = PointOfInterest.find(params[:point_of_interest_id])
    	@comment = @poi.comments.create(params[:comment].permit(:body, :user_id))

    	redirect_to point_of_interest_path(@poi)
  	end

  	def destroy
	    @poi = PointOfInterest.find(params[:point_of_interest_id])
	    @comment = @poi.comments.find(params[:id])
	    @comment.destroy
	    redirect_to point_of_interest_path(@poi)
  	end

end

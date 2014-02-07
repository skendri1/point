class PointOfInterestsController < ApplicationController
	
	before_filter :authorize, :except => [:index, :show ]

	#GET /point_of_interest/new
	def new
		@poi = PointOfInterest.new
	end

	#Index that shows all the POIs in the system in a table. Will remove or block from all users later.
	def index
		@pois = PointOfInterest.all
	end

	# Handles creating the POI
	def create
		#render text: params[:point_of_interest].inspect

		@poi = PointOfInterest.new(post_params)
		@poi.user_id_id = current_user.id
		

		if ( current_user || @poi.save)
    		redirect_to @poi
  		else
    		render 'new'
  		end

		redirect_to @poi
	end

	# GET /point_of_interest/:id(.:format) point_of_interests@show
	def show
		@poi = PointOfInterest.find(params[:id])
	end

	def edit
  		@poi = PointOfInterest.find(params[:id])
	end

	#Updates the POI
	def update
  		@poi = PointOfInterest.find(params[:id])
 
  		if @poi.update(params[:post].permit(:latitude, :longitude, :summary, :sponsor_info, :artist_info))
    		redirect_to @poi
  		else
    		render 'edit'
  		end
	end

	# Destroys the POI
	def destroy
  		@poi = PointOfInterest.find(params[:id])
  		@poi.destroy
 
  		redirect_to point_of_interests_path
	end

	private
  	def post_params
    	params.require(:point_of_interest).permit(:latitude, :longitude, :summary, :sponsor_info, :artist_info)
  	end

end
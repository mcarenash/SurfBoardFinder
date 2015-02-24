class BoardsController < ApplicationController

	before_action  :authenticate_user!
	respond_to :html, :js

	def index
	    @boards = Board.all
	    @hash   = Gmaps4rails.build_markers(@boards) do |board, marker|
	    marker.lat board.latitude
	    marker.lng board.longitude
	    marker.infowindow "Type of Board: " + board.title + " " + "<br>" + "Price: "  + "$" + " "+ board.price.to_s + view_context.link_to('More Info.', board_path(board.id))

		end
	end

	def new
    	@board = Board.new
  	end

	def create
		@board = Board.new(board_params)
        respond_to do |format|
     	 if @board.save
      	  format.html { redirect_to @board, notice: 'board was successfully created.' }
      	  format.json { render :show, status: :created, location: @board }
     	 else
      	  format.html { render :new }
      	  format.json { render json: @board.errors, status: :unprocessable_entity }
     	 end
    	end
	end

	def edit
    	@board = Board.find(params[:id])
  	end

  	def update
    	@board = Board.find(params[:id])
    	respond_to do |format|
     	 if @board.update(board_params)
        	format.html { redirect_to @board, notice: 'board was successfully updated.' }
        	format.json { render :show, status: :ok, location: @board }
      	 else
        	format.html { render :edit }
        	format.json { render json: @board.errors, status: :unprocessable_entity }
     	 end
    	end
  	end

 	def destroy
	    @board = Board.find(board_params[:id])
	    @board.destroy
	    respond_to do |format|
	    format.html { redirect_to root_url, notice: 'User was successfully destroyed.' }
	    format.json { head :no_content }
	    end
    end

	def show 
		@board = Board.find(params[:id])
    	@hash  = Gmaps4rails.build_markers(@board) do |board, marker|
    	marker.lat board.latitude
    	marker.lng board.longitude
    	end
	end

	private
  		def set_board
     	 @board = Board.find(params[:id])
  		end

		def board_params
	    params.require(:board).permit(
	      :latitude,
	      :longitude,
	      :title,
	      :description,
	      :address,
	      :price, 
	      :image,
	      :user_id
	    )
		end
	end



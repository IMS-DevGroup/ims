class StartsController < ApplicationController
  # GET /starts
  # GET /starts.json
  def index
    @starts = Start.all
  end



end

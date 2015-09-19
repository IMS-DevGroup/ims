class StartsController < ApplicationController
  # GET /starts
  # GET /starts.json
  def index
    @boss = BossConfig.first
  end



end

module Api
  class TechnologiesController < ApiController
    def index
      @technologies = Technology.all
    end

    def show
      @technology = Technology.find(params[:id])
    end
  end
end

module Api
  class TechnologiesController < ApiController
    def index
      @technologies = Technology.all
    end

    def show
      @technologies = Technology.includes(requirements: :technology).find(params[:id])
    end
  end
end

module Api
  class ProfilesController < ApiController
    def index
      @profiles = Profile.includes(requirements: :technology)
    end

    def show
      @profile = Profile.includes(requirements: :technology).find(params[:id])
    end
  end
end

module Api
  class ProfilesController < ApiController
    def index
      @profiles = Profile.includes(requirements: :technology)
    end

    def show
      @profile = Profile.includes(requirements: :technology).find(params[:id])
    end

    def create
      @profile = Profile.create!(profile_params)
      params[:requirements].each { |m| Requirement.create!(technology_id: m[:id], profile_id: @profile[:id], seniority: m[:seniority]) }
      render :show, status: :created
    end

    private

    def profile_params
      values = params.require(:profile).permit(
        :language, 
        :language_id, 
        :description,
        :name,
        :area,
        requirements_attributes: [
          :technology_id, 
          :seniority
        ])

      language_name = values[:language]
      if language_name.present?
        values[:language] = Language.find_by(name: language_name)
      end

      values
    end
  end
end

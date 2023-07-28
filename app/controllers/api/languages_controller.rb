module Api
  class LanguagesController < ApiController
    def index
      @languages = Language.all
    end

    def show
      @language = Language.find(params[:id])
    end
  end
end

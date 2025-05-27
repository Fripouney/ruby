class IngredientsController < ApplicationController
    before_action :init_service

    def search
        @ingredients = @service.search_ingredients(params[:query], params[:number])
        render json: @ingredients
    end


    private

    def init_service
        @service = SpoonacularService.new
    end
end

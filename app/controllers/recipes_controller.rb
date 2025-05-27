class RecipesController < ApplicationController
  wrap_parameters format: [ :json ]
  def index
    @recipes = Recipe.all
    render json: { recipes: @recipes }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.cooked = false
    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      render json: @recipe, status: :ok
    else
      render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_content
    end
  end

  private
  def recipe_params
    params.expect(:name, ingredients: [
      :id,
      :name,
      :quantity,
      :_destroy
    ])
  end
end

class ShoppingListsController < ApplicationController
    def index
        @shopping_lists = ShoppingList.all
        render json: @shopping_lists
    end

    def show
        @shopping_list = ShoppingList.find(params[:id])
        render json: @shopping_list
    end

    def create
        @shopping_list = ShoppingList.create(params[:name])
        render json: @shopping_list
    end

    def destroy
        @shopping_list = ShoppingList.find(params[:id])
        @shopping_list.destroy
        render json: @shopping_list
    end
end

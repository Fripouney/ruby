class FridgesController < ApplicationController
    def index
        @fridges = Fridge.all
        render json: @fridges
    end

    def show
        @fridge = Fridge.find(params[:id])
        render json: @fridge
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Fridge not found" }, status: :not_found
        rescue ActiveRecord::RecordInvalid
            render json: { error: "Invalid fridge" }, status: :unprocessable_content
    end

    def create
        @fridge = Fridge.new({ name: params[:name] })
        if @fridge.save
            render json: @fridge, status: :created
        else
            render json: @fridge.errors, status: :unprocessable_content
        end
    end

    def update
        @fridge = Fridge.find(params[:id])
        if @fridge.update({ name: params[:name] })
            render json: @fridge
        else
            render json: @fridge.errors, status: :unprocessable_content
        end
    end

    def destroy
        @fridge = Fridge.find(params[:id])
        if @fridge.destroy
            render json: { message: "Fridge deleted successfully" }, status: :ok
        else
            render json: { error: "Fridge not found" }, status: :not_found
        end
    end
end

class Recipe < ApplicationRecord
    has_many :ingredients, as: :ingredientable
    validates :name, presence: true
    validates :ingredients, presence: true
    accepts_nested_attributes_for :ingredients, allow_destroy: true

    def can_be_made_from_fridge?(fridge)
        ingredients.all? do |recipe_ingredient|
          fridge.has_ingredient?(
            recipe_ingredient.id,
            recipe_ingredient.quantity,
            recipe_ingredient.unit
          )
        end
    end

    def add_ingredients_to_shopping_list

      # TODO
    end
end

class ShoppingList < ApplicationRecord
    validates :name, presence: true
    has_many :ingredients, as: :ingredientable

    # Logic applies here too
    def add_ingredient(ingredient_info, quantity)
        ingredient = ShoppingList.ingredients.find_by(spoonacular_id: ingredient_info["id"])
        if ingredient.nil?
            self.ingredients.create(spoonacular_id: ingredient_info["id"], name: ingredient["name"], quantity: 1, unit: ingredient["unit"])
        end
    end

    def remove_ingredient(spoonacular_id, quantity)
        ingredient = self.ingredients.find_by(spoonacular_id: spoonacular_id)
        if ingredient
            if quantity.present?
                if quantity < ingredient.quantity
                    ingredient.quantity -= quantity
                else
                    ingredient.destroy
            end
        end
    end
end

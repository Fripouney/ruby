class Fridge < ApplicationRecord
    has_many :ingredients, as: :ingredientable
    validates :name, presence: true

    # This needs to be redone with a correct logic and without spamming the API with conversion requests

    def add_ingredient(spoonacular_id, quantity, expiration_date)
        service = SpoonacularService.new
        ingredient = service.get_ingredient_information(spoonacular_id)
        unit = Ingredient.determine_unit(ingredient)
        if self.ingredients.find_by(spoonacular_id: spoonacular_id).nil? # Ingrérdient pas trouvé
            self.ingredients.create(
              spoonacular_id: spoonacular_id,
              name: ingredient["name"],
              quantity: quantity,
              unit: unit,
              expiration_date: expiration_date,
              ingredient_type: ingredient["aisle"]
            )
        else
            ingredient = self.ingredients.find_by(id: spoonacular_id)
            ingredient.quantity += ingredient["amount"]
            ingredient.save
        end
    end

    # Same here
    def remove_ingredient(spoonacular_id, quantity, unit)
        ingredient = self.ingredients.find_by(id: spoonacular_id)
        if ingredient
            if quantity.present?
                converted_quantity = ingredient.convert_quantity(quantity, unit, ingredient.unit)
                if converted_quantity >= ingredient.quantity
                    self.ingredients.destroy(ingredient)
                else
                    ingredient.quantity -= converted_quantity
                    ingredient.save
                end
            end
        end
    end

    def check_ingredient_quantity(spoonacular_id, quantity)
        ingredient = self.ingredients.find_by(spoonacular_id: spoonacular_id)
        if ingredient
            if quantity > ingredient.quantity
                { id: spoonacular_id, quantity: quantity - ingredient.quantity }
            end
        else
            { id: spoonacular_id, quantity: quantity }
        end
    end
end

class CreateIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :ingredients do |t|
      t.integer :spoonacular_id
      t.string :name
      t.integer :quantity
      t.date :expiration_date
      t.string :unit
      t.string :ingredient_type
      t.references :ingredientable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

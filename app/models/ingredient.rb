class Ingredient < ApplicationRecord
  belongs_to :ingredientable, polymorphic: true
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit, presence: true
  validates :ingredientable_id, presence: true
  validates :ingredientable_type, presence: true


  def self.determine_unit(information)
    if information["unit"].present?
      information["unit"]
    else
      case information["consistency"].downcase
      when "liquid"
        "ml"
      when "solid"
        if information["possibleUnits"].include?("piece")
          "piece"
        else
          "g"
        end
      else
        "g"
      end
    end
  end
end

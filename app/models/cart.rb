class Cart < ApplicationRecord
  belongs_to :user, validate: true
end

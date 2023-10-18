class Contact < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :phone_number, presence: true, format: { with: /\A\d{10}$|^\d{11}\z/ }
    validates :message, presence: true
end

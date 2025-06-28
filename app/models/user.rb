class User < ApplicationRecord

    has_many :reservations, foreign_key: :guest_id

    validates :phone_number, format: {
        with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/,
        message: "Entrez un numéro de téléphone valide"
  }
end

class City < ApplicationRecord

    validates :zip_code, format: { 
        with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, 
        message: "Entrez un code postal valide" }
end

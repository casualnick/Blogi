class User < ApplicationRecord
    enum role: [:standard, :guest, :admin]

    after_initialize do
        if self.new_record?
            self.role ||= :standard
        end
    end

    has_secure_password

    EMAIL_FORMAT =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,
        presence: :true,
        length: { minimum: 5 },
        uniqueness: true,
        format: { with: EMAIL_FORMAT }

    validates :password, presence: true, length: { minimum: 5 }

    validates :password_confirmation, presence: true

    has_many :posts
end

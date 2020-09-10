class User < ApplicationRecord
    enum role: [:standart, :admin, :guest]

    after_initialize do
        if self.new_record?
            self.role ||= :standard
        end
    end

    has_secure_password

    EMAIL_FORMAT = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/

    validate :email,
        presence: :true,
        lenght: { minimum: 5 },
        uniqueness: true,
        format: { with: EMAIL_FORMAT }

    validate :password, presence: true, lenght: { minimum: 5 }

    validate :password_confirmation, presence: true
end

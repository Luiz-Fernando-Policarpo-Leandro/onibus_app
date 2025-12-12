class Status < ApplicationRecord
    has_many :users

    def self.waiting
        find_by!(name: "waiting")
    end

    def self.active
        find_by!(name: "active")
    end
end

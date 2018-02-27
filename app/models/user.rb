class User < ApplicationRecord
  include Clearance::User

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end

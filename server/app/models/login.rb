# frozen_string_literal: true

class Login < ApplicationRecord
  belongs_to :user

  validates_presence_of :username, :password, :site
end

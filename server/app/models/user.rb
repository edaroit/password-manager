# frozen_string_literal: true

class User < ApplicationRecord
  has_many :logins, dependent: :destroy
  has_many :notes, dependent: :destroy

  validates_presence_of :name, :email, :password_digest
end

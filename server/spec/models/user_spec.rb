# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:logins).dependent(:destroy) }
  it { should have_many(:notes).dependent(:destroy) }
  it { should have_db_index(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end

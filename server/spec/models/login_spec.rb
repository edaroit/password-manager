# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Login, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:site) }
end

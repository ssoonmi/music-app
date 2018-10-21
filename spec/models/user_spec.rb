require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # subject (:)

  it { should validate_presence_of(:email) }

  it { should validate_presence_of(:password_digest) }

  it 'should validate length of password > 6' do
    expect { User.create!(email: 's', password: 'password') }.not_to raise_error
    expect { User.create!(email: 's', password: 'passwo') }.to raise_error
  end
end

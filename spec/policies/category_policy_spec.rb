require 'rails_helper'

describe CategoryPolicy do
    subject {described_class.new(user, category)}

    let(:category) {Category.new}

    context 'being a user' do
        let(:user) {User.create(admin: true)}
        it {is_expected.to forbid_action(:create)}
    end

    context 'being an administrator' do
        let(:user) {User.create(admin: false)}
        it {is_expected.to permit_action(:create)}
    end
end
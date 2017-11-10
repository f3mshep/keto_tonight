require 'rails_helper'

describe RecipePolicy do
    subject { described_class.new(user, recipe) }

    let(:recipe) {Recipe.create}

    context 'being a user' do
        let(:user) {User.create}
        it {is_expected.to forbid_actions([:destroy, :edit])}
    end

    context 'being a user who owns the recipe' do
        let(:user) {User.create}
        let(:recipe) {Recipe.create(user: user)}
        it {is_expected.to permit_actions([:destroy, :edit])}
    end
    
    context 'being an admin' do
        let(:user) {User.create(admin: true)}
        it {is_expected.to permit_actions([:destroy, :edit])}
    end

end
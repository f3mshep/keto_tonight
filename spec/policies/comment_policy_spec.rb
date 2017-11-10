require 'rails_helper'

describe CommentPolicy do
    subject { described_class.new(user, comment) }

    let(:recipe) {Recipe.create}
    let(:comment) {Comment.create}

    context 'being a user' do
        let(:user) {User.create}
        it {is_expected.to forbid_actions([:destroy, :edit])}
    end

    context 'being a user who owns the comment' do
        let(:user) {User.create}
        let(:comment) {Comment.create(user: user, recipe: recipe)}
        it {is_expected.to permit_actions([:destroy, :edit])}
    end
    
    context 'being an admin' do
        let(:user) {User.create(admin: true)}
        it {is_expected.to permit_actions([:destroy, :edit])}
    end
end
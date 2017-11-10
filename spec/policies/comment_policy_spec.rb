require 'rails_helper'

describe CommentPolicy do
    subject { described_class.new(user, comment) }

    let(:comment) {Comment.create}

    context 'being a user' do
    end

    context 'being a user who owns the comment' do
    end
    
    context 'being an admin' do
    end
end
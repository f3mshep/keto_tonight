class CommentPolicy < ApplicationPolicy

    def update?
        user.admin || record.try(:user) == user
    end

    def destroy?
        user.admin || record.try(:user) == user
    end

end
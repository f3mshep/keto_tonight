class CategoryPolicy < ApplicationPolicy

    def create?
        user.admin
    end

    def destroy?
        user.admin
    end

end
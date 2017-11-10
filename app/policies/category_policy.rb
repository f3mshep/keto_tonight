class CategoryPolicy < ApplicationPolicy

    def create?
        user.admin
    end

end
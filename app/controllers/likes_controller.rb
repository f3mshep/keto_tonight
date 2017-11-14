class LikesController < ApplicationController

    def create
        @like = Like.create(like_params)
        @like.update(user: current_user)
        redirect_to user_recipe_path(@like.recipe.user, @like.recipe)
    end

    def destroy
        @like = Like.find(params[:id])
        @like.destroy
        redirect_to user_recipe_path(@like.recipe.user, @like.recipe)
    end

    private

    def like_params
        params.require(:like).permit(:recipe_id)
    end
end
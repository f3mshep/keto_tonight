class LikesController < ApplicationController

    def create
        @like = Like.create(like_params)
        @like.update(user: current_user)
        
        respond_to do |format|
            format.html {redirect_to user_recipe_path(@like.recipe.user, @like.recipe)}
            format.json {render json: @like}
        end
        
    end

    def destroy
        @like = Like.find(params[:id])
        @like.destroy

        respond_to do |format|
            format.html {redirect_to user_recipe_path(@like.recipe.user, @like.recipe)}
            format.json {render json: @like}
        end
    end

    private

    def like_params
        params.require(:like).permit(:recipe_id)
    end
end
class CommentsController < ApplicationController
    before_action :comment_setter, only: [:update, :destroy]

    def create
        @comment = Comment.new(user_id: current_user.id, recipe_id: params[:recipe_id])
        @comment.update(comment_params)
        authorize @comment
        redirect_to user_recipe_path(@comment.recipe.user_id, @comment.recipe)
    end

    def update
        authorize @comment
        comment.update(comment_params)
        redirect_to user_recipe_path(@comment.recipe.user_id, @comment.recipe)
    end

    def destroy
        authorize @comment
        comment.destroy
        redirect_to user_recipe_path(comment.user, comment.recipe)
    end



    private

    def comment_setter
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:content)
    end

end

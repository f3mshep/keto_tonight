class CommentsController < ApplicationController

    def create
        @comment = Comment.new(user_id: current_user.id, recipe_id: params[:recipe_id])
        @comment.update(comment_params)
        redirect_to user_recipe_path(@comment.recipe.user_id, @comment.recipe)
    end

   

    def comment_params
        params.require(:comment).permit(:content)
    end

end

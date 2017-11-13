class RecipesController < ApplicationController

    before_action :recipe_setter, only: [:show, :edit, :update, :destroy]

    def index
        if params[:user_id]
            @recipes = User.find(params[:user_id]).recipes
        elsif params[:my_pantry]
            @recipes = Recipe.my_pantry(current_user.pantry_ids)
        else
            @recipes = Recipe.all
        end
    end

    def show
        @comment = Comment.new(user: current_user, recipe: @recipe)
    end

    def new
        @recipe = Recipe.new(user: current_user)
        @category = @recipe.categories.build
    end

    def create
        @recipe = Recipe.new(user: current_user)
        @recipe.assign_attributes(recipe_params)
        if @recipe.save
            @recipe.save_food
            redirect_to user_recipe_path(@recipe.user, @recipe)
        else
            render :new
        end
    end

    def edit
       @category = @recipe.categories.build
    end

    def update
        authorize @recipe
        if @recipe.update(recipe_params)
            @recipe.save_food
            redirect_to user_recipe_path(@recipe.user, @recipe)
        else
            @recipe.categories.build
            render :edit
        end
    end

    def destroy
        authorize @recipe
        @recipe.destroy
        redirect_to user_recipes_path(current_user)
    end

    private

    def recipe_params
       params.require(:recipe).permit(:title, :description, :serving_size,
       :ingredient_list, :cook_time, :prep_time, :servings,
       :categories_attributes => [:name], :category_ids => [])
    end

    def recipe_setter
        @recipe = Recipe.find(params[:id])
    end

end

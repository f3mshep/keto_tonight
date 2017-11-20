class RecipesController < ApplicationController

    before_action :recipe_setter, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only: [:show, :edit, :new, :create, :update, :destroy]
    before_action :has_pantry, only: [:show]

    def index
        if params[:user_id]
            #I could write a scope for this but I don't want to mess up nested params
            @recipes = User.find(params[:user_id]).recipes
        else
            @recipes = Recipe.where(nil)
            filtering_params(params).each do |key, value|
                if value == "true"
                    @recipes = @recipes.public_send(key, current_user)
                elsif value.present?
                    @recipes = @recipes.public_send(key, value)
                end
            end
        end
    end

    def show
        @like = current_user.likes_recipe(@recipe) || Like.new(user: current_user, recipe: @recipe)
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
            @category = @recipe.categories.build
            render :new
        end
    end

    def edit
       @category = @recipe.categories.build
    end

    def update
        authorize @recipe
        if @recipe.update(recipe_params)
            @recipe.update_food
            redirect_to user_recipe_path(@recipe.user, @recipe)
        else
            @category = @recipe.categories.build
            render :edit
        end
    end

    def destroy
        authorize @recipe
        @recipe.recipe_categories.destroy_all
        @recipe.destroy
        redirect_to user_recipes_path(current_user)
    end

    def search
    end

    private

    def filtering_params(params)
        params.slice(:by_ingredients, :most_recent, :by_categories,
        :by_likes, :is_liked, :search_query, :my_pantry)
    end

    def recipe_params
       params.require(:recipe).permit(:title, :image, :description, :serving_size,
       :ingredient_list, :cook_time, :prep_time, :servings,
       :categories_attributes => [:name], :category_ids => [])
    end

    def recipe_setter
        @recipe = Recipe.find(params[:id])
    end

end

class RecipesController < ApplicationController

    before_action :recipe_setter, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only: [:show, :edit, :new, :create, :update, :destroy]
    before_action :has_pantry, only: [:show]

    def index
        if params[:user_id]
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
        render json: @recipes if params[:request] || request.format.symbol == :json
    end

    def my_likes
        @recipes = Recipe.my_likes(params[:id])
        render :server_index
    end

    def show
        @like = current_user.likes_recipe(@recipe) || Like.new(user: current_user, recipe: @recipe)
        @comment = Comment.new(user: current_user, recipe: @recipe)
        @comments = @recipe.comments
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
            flash[:notice] = "#{@recipe.title} successfully created!"
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
            flash[:notice] = "#{@recipe.title} successfully updated!"
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
        flash[:notice] = "#{@recipe.title} successfully deleted"
        redirect_to user_recipes_path(current_user)
    end

    def search
    end

    def missing_ingredients
        user = User.find(params[:user_id])
        @recipe = Recipe.find(params[:id])
        #that won't work, treat as psuedo code
        names = @recipe.missing_ingredient_names(user)
        count = @recipe.missing_ingredients(user).size
        @missing_ingredients = {missing_names: names, missing_count: count}
        render json: @missing_ingredients
    end

    private

    def filtering_params(params)
        params.slice(:by_ingredients, :most_recent, :by_categories,
        :by_likes, :is_liked, :search_query, :my_pantry, :my_likes)
    end

    def recipe_params
       params.require(:recipe).permit(:title, :image, :description, :serving_size,
       :ingredient_list, :cook_time, :prep_time, :servings, :user_id,
       :categories_attributes => [:name], :category_ids => [])
    end

    def recipe_setter
        @recipe = Recipe.find(params[:id])
    end

end

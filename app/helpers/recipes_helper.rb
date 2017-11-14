module RecipesHelper

    def like_button
        #figure out why the eff this doesn't work, but directly embedding it does
        if current_user.liked_recipes.include?(@recipe)

            form_for(@like, method: :delete) do |f|
                #future javascripty-front-endy-me: have icon show liked, then on hover change it to unlike
                #also AJAX the heck out if it so that the page doesn't reload
                f.submit "Unlike", class: 'btn btn-primary'
            end

        else 

            form_for(@like) do |f|
                f.hidden_field :recipe_id, value: "#{@recipe.id}"
                f.submit "Like", class: 'btn btn-primary'
            end

        end

    end

end

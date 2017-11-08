require 'net/http'
require 'uri'

class EdamamWrapper
    ID = ENV['EDAMAM_ID']
    KEY = ENV['EDAMAM_KEY']
    XMASH = ENV['XMASH']

    def line_ingredient_parser(query)
        ingredients = {}
        food_hash = {}
        line_items = input_to_array(query)
        line_items.each do |line_item|
            response = Unirest.get "https://edamam-edamam-nutrition-analysis.p.mashape.com/api/nutrition-data?ingr=#{CGI.escape(line_item)}",
            headers:{
            "X-Mashape-Key" => "#{XMASH}",
            "Accept" => "application/json"
            }
            food = response.body["ingredients"][0]["parsed"][0]["foodMatch"]
            food_id = response.body["ingredients"][0]["parsed"][0]["foodId"]
            food_quantity = response.body["ingredients"][0]["parsed"][0]["quantity"]
            food_measure = response.body["ingredients"][0]["parsed"][0]["measure"]
            ingredients[food] = {food_id: food_id, quantity: food_quantity, measure: food_measure}
        end
        food_hash[:ingredients] = ingredients
        nutrients = recipe_analyzer(line_items)
        food_hash[:nutrients] = nutrients
        food_hash
    end


    private 

    def input_to_array(user_input)
         user_input.split(/[\r\n]+/)
    end

    def recipe_analyzer(line_items)

        uri = URI.parse("https://api.edamam.com/api/nutrition-details?app_id=#{ID}&app_key=#{KEY}")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        json_ingredients = {'ingr' => line_items}.to_json
        request.body = json_ingredients
        req_options = {
        use_ssl: uri.scheme == "https",
        }
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
        end
        json = JSON.parse(response.body)
        fat = json["totalNutrients"]["FAT"]["quantity"].to_i
        fiber = json["totalNutrients"]["FIBTG"]["quantity"].to_i
        calories = json["calories"]
        carbs = json["totalNutrients"]["CHOCDF"]["quantity"].to_i
        protein = json["totalNutrients"]["PROCNT"]["quantity"].to_i
        {
            calories: calories,
            fat: fat,
            fiber: fiber,
            carbs: carbs,
            protein: protein
        }
    end

end
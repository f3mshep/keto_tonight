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
            begin
                food = response.body["ingredients"][0]["parsed"][0]["foodMatch"]
                food_id = response.body["ingredients"][0]["parsed"][0]["foodId"]
            rescue
                return "#{line_item} not found"
            end
            food_quantity = response.body["ingredients"][0]["parsed"][0]["quantity"]
            food_measure = response.body["ingredients"][0]["parsed"][0]["measure"]
            return "#{line_item} missing measurement" if food_measure.nil?
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
        if json["totalNutrients"]
            fat = json["totalNutrients"]["FAT"]["quantity"] unless json["totalNutrients"]["FAT"].nil?
            fiber = json["totalNutrients"]["FIBTG"]["quantity"] unless json["totalNutrients"]["FIBTG"].nil?
            calories = json["calories"] unless json["calories"].nil?
            carbs = json["totalNutrients"]["CHOCDF"]["quantity"] unless json["totalNutrients"]["CHOCDF"].nil?
            protein = json["totalNutrients"]["PROCNT"]["quantity"] unless json["totalNutrients"]["PROCNT"].nil?
        end
        {
            calories: calories.to_i,
            fat: fat.to_i,
            fiber: fiber.to_i,
            carbs: carbs.to_i,
            protein: protein.to_i
        }
    end

end
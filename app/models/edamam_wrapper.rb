require 'net/http'
require 'uri'

class EdamamWrapper
    ID = ENV['EDAMAM_ID']
    KEY = ENV['EDAMAM_KEY']
    XMASH = ENV['XMASH']

    def line_ingredient_parser(query)
        line_items = query.input_to_array
        line_items.each do |line_item|
            response = Unirest.get "https://edamam-edamam-nutrition-analysis.p.mashape.com/api/nutrition-data?ingr=#{CGI.escape(line_item)}",
            headers:{
            "X-Mashape-Key" => "#{XMASH}",
            "Accept" => "application/json"
            }
            binding.pry
        end
    end


    private 

    def input_to_array(user_input)
        user_input.split('r/n')
    end

    def recipe_analyzer

        uri = URI.parse("https://api.edamam.com/api/nutrition-details?app_id=#{ID}&app_key=#{KEY}")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        file_location = File.join(Rails.root, 'app', 'models', 'recipe.json')
        request.body = ""
        request.body << File.read(file_location).delete("\r\n")

        req_options = {
        use_ssl: uri.scheme == "https",
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            binding.pry
            http.request(request)
        end
    end

end
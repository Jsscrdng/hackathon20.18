module TrelloFunctions

    def get_lists(options, user_id)
        url = "https://api.trello.com/1/boards/#{user_id}?#{options}&key=#{TRELLO_API_KEY}&token=#{TRELLO_ACCESS_TOKEN}"
        parsed_url = URI.parse(url)
        http = Net::HTTP.new(parsed_url.host, parsed_url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(parsed_url.request_uri)
        response = http.request(request)
        lists = JSON.parse(response.body)["lists"]
        return lists
    end

    def get_cards_in_list(list_id)
        # /1/lists/5bb0e491eba38556d7968ee9/cards?fields=name
        url = "https://api.trello.com/1/lists/#{list_id}/cards?fields=name&key=#{TRELLO_API_KEY}&token=#{TRELLO_ACCESS_TOKEN}"
        parsed_url = URI.parse(url)
        http = Net::HTTP.new(parsed_url.host, parsed_url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(parsed_url.request_uri)
        response = http.request(request)
        cards = JSON.parse(response.body).length == 0 ? [] : JSON.parse(response.body)
        return cards
    end

    def create_missing_list(name)
        #https://api.trello.com/1/lists?name=To%20do&idBoard=5bb0425143e65366f174f4e9
        url = "https://api.trello.com/1/lists?name=#{name}&idBoard=#{TRELLO_BOARD_ID}&key=#{TRELLO_API_KEY}&token=#{TRELLO_ACCESS_TOKEN}"
        parsed_url = URI.parse(url)
        http = Net::HTTP.new(parsed_url.host, parsed_url.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(parsed_url.request_uri)
        response = http.request(request)
        return response.body
    end

    def create_cards(name, desc, list_id)
        #https://api.trello.com/1/cards?idList=idList
        url = "https://api.trello.com/1/cards?name=#{name}&desc=#{desc}&idList=#{list_id}&key=#{TRELLO_API_KEY}&token=#{TRELLO_ACCESS_TOKEN}"
        parsed_url = URI.parse(url)
        http = Net::HTTP.new(parsed_url.host, parsed_url.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(parsed_url.request_uri)
        response = http.request(request)
        return response.body
    end

end
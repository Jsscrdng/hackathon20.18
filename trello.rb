require_relative 'methods'
include TrelloFunctions

require 'rubygems'
require 'json'

require 'net/http'
require 'byebug'

TRELLO_API_KEY= ENV['TRELLO_API_KEY']
TRELLO_ACCESS_TOKEN= ENV['TRELLO_ACCESS_TOKEN']
TRELLO_BOARD_ID= ENV['TRELLO_BOARD_ID']
USER_ID= ENV['USER_ID']

module Trello
    def create_list
        options = "fields=id,name&lists=open&list_fields=id,name,closed,pos"
        user_id = USER_ID
        lists = get_lists(options, user_id)
        #Check if list exists
        list_counter = {backlog: 0, todo: 0, done: 0}
        lists.each do |list|
            case list["name"].downcase
            when "backlog"
                list_counter[:backlog] += 1
            when "to do"
                list_counter[:todo] += 1
            when "done"
                list_counter[:done] += 1
            end
        end

        #Create missing lists
        if list_counter[:done] == 0
            create_missing_list "Done"
        end
        if list_counter[:todo] == 0
            create_missing_list "Todo"
        end
        if list_counter[:backlog] == 0
            create_missing_list "Backlog"
        end    
        
        lists = get_lists(options, user_id)
        lists_ids = Hash.new
        lists.each do |list|
            lists_ids["#{list["name"].downcase.delete(' ')}"] = list["id"]
        end
        #Return ids of each list
        return lists_ids
    end

    def create_issues(name, description, list_id)
        #Check if card works
        cards = get_cards_in_list(list_id)
        #Create Cards
        toggle = 1
        cards.each do |card|
            if card["name"] == name
                toggle = 0
            end
        end
        create_cards(name, description, list_id) if toggle == 1
    end
end
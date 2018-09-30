require_relative 'trello'
include Trello

require 'telegram_bot'
require 'net/http'

require 'rubygems'
require 'json'

require 'byebug'

token = ENV['TELEGRAM_TOKEN']

bot = TelegramBot.new(token: token)

bot.get_updates(fail_silently: true) do |message|
    puts "@#{message.from.username}: #{message.text}"
    command = message.get_command_for(bot)
    a = String.new
    message.reply do |reply|
      case command
      when /start/i
        reply.text = "Hack-a-bot is ready now. Try the /greet command."
      when /greet/i
        #🤖
        reply.text = "Hello, #{message.from.first_name}.How things doing?"
      when /setup/i
        url = "https://api.github.com/repos/jsscrdng/hackathon20.18/issues?access_token=#{ENV["GITHUB_ACCESS_TOKEN"]}"
        parsed_url = URI.parse(url)
        http = Net::HTTP.new(parsed_url.host, parsed_url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(parsed_url.request_uri)
        response = http.request(request)
        lists_ids = create_list

        JSON.parse(response.body).each do |issue|
          create_issues(issue["title"], issue["body"], lists_ids["backlog"])
          puts issue["url"]
        end
        reply.text = "a"
      else
        reply.text = "I have no idea what #{command.inspect} means."
      end
      puts "sending #{reply.text.inspect} to #@{message.from.username}"
      reply.send_with(bot)
    end
  end
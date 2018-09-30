require 'telegram_bot'
require 'net/http'

token = ENV['TELEGRAM_TOKEN']

bot = TelegramBot.new(token: token)

bot.get_updates(fail_silently: true) do |message|
    puts "@#{message.from.username}: #{message.text}"
    command = message.get_command_for(bot)
  
    message.reply do |reply|
      case command
      when /start/i
        reply.text = "All I can do is say hello. Try the /greet command."
      when /greet/i
        reply.text = "Hello, #{message.from.first_name}.🤖"
      when /setup/i
        # https://api.github.com/users/jsscrdng/repos
        url = 'https://api.github.com/users/jsscrdng/repos/hackathon20.18/'
        parsed_url = URI.parse(url)
        http = Net::HTTP.new(parsed_url.host, parsed_url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(parsed_url.request_uri)
        response = http.request(request)
        puts response.body
        reply.text = response.body
      else
        reply.text = "I have no idea what #{command.inspect} means."
      end
      puts "sending #{reply.text.inspect} to #@{message.from.username}"
      reply.send_with(bot)
    end
  end
# Trello/GitHub/Telegram API integration - Hackathon 20.18
In this proyect you would find an integration to take Github issues and put inside _Backlog_ list of a previously created Trello board. This proyect was entirely developed using Ruby.

Code is now deployed and working so you can pass commands to ```hack-a-bot```  telegram bot now if you were invited both GitHub and Trello projects. 

If you want to use this integration in your own project pleas use the following as a guide.

# Settings and configurations
This project uses environment variables to keep safe Trello, Github and Telegram credentials. If you like to this use properly it's mandatory to set environment variables. If you use Debian based system all you have to do is run ```sudo nano ~/.bashrc``` or ```sudo vi ~/.bashrc``` and add values this way:
```
export TELEGRAM_TOKEN='<Your Telegram token here>'
export GITHUB_ACCESS_TOKEN= '<Your Github access Token>'
export TRELLO_ACCESS_TOKEN= '<Your Trello access token>'
export TRELLO_API_KEY= '<Your Trello API Key>'
export TRELLO_BOARD_ID= '<Your Trello Board>'
export USER_ID='<Your Trello User ID >'

```
Save your changes and don't forget run ```source ~/.bashrc``` another location for enviroment could be ```/.profile```.

Please, got to project's folder and open a console there. Run ```bundle install``` in order to install required gems. 

## Run Ruby script
Go into project folder, run ```ruby hack-a-bot.rb``` in the command prompt.  Now the code is constantly requesting for new commands.

To interact with the bot you have to search the bot in, their name is *hack-a-bot* just as the ruby file 

## Talking with the bot

You can run three commands to interact with the bot. ```/start```, ```greet``` and the most important: ```/setup```. Use the first two to test bot's response. Lastly, use ```setup``` to do the trick, don't forget open your trello board and add some *GitHub* Issues before run the command.

## What's possible with this code
You can add the three some of the most used list in a Trello *SCRUM* board in case you haven't yet: **backlog, todo, done**. Additionally, all your *GitHub* issues will pass directly to **Backlog**. Project is capable to detect if either lists or cards inside backlog already exists to avoid to repeat.

## Things to improve

Until now, code just take Title and Description of each card. It would be nice to add more data, connect GitHub and Trello checking if share google account. Also it would be fine to add criterias to  identify and pass list elements inside card body. Finally i would change gem (```telegram_bot```) to another one that allows usage of keyboards and text inputs( *Telegram-bot* or *Telegram-bot-ruby* for instance). I have some problems trying to get it work thanks to Gem failure in my machine (first one) and incompability with WebHook in some versions (second one).

Doing this it would be possible to interact with user and get all neccesary API credentials before pass data. Avoiding the hassle of set ENV variables.

## Special Thanks to
Ideaware and their team for make this possible.

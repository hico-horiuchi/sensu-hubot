## sensu handlers for hubot

#### about

 - `hubot_handler.rb`: sensu event data post to hubot

#### how to use (sensu)

 1. `cd /path/to/sensu/handlers`
 2. `wget https://raw.githubusercontent.com/hico-horiuchi/sensu-hubot/master/hubot_handler.rb`
 3. `chmod 755 hubot_handlerrb`
 4. `cd /path/to/sensu/conf.d/`
 5. `wget https://github.com/hico-horiuchi/sensu-hubot/master/handler_hubot.json`
 6. please modify to suit your hubot environment this `handler_hubot.json`
 7. please restart sensu-server

#### how to use (hubot)

 1. `cd /path/to/hubot/scripts`
 2. `wget https://raw.githubusercontent.com/hico-horiuchi/sensu-hubot/master/sensu.coffee`
 3. please restart hubot

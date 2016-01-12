# Description
#   A hubot script to execute commands 
#
# Configuration:
#
# Commands:
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   lukasz@sredni.pl

module.exports = (robot) ->

  robot.respond /execute (.*)?$/i, (msg) ->
    command = msg.match[1]

    unless robot.auth.hasRole(msg.envelope.user, 'command-executor')
      msg.reply "I can't do what you ask, you don't have sufficient permission..."
    else
      @exec = require('child_process').exec
      command = "cd ~; #{command}"

      msg.reply "Lock and load, executing..."

      @exec command, (error, stdout, stderr) ->
        msg.send stdout
        if stderr
          msg.send "ERROR (stderr): " + stderr
        if error
          msg.send "ERROR (error)" + error

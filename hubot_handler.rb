#!/usr/bin/env ruby
# Sensu Hubot Handler

require 'sensu-handler'
require 'net/http'
require 'timeout'

class HubotHandler < Sensu::Handler
  def host
    settings['hubot']['host'] || 'localhost'
  end

  def port
    settings['hubot']['port'] || '80'
  end

  def https
    settings['hubot']['https'] || false
  end

  def room
    settings['hubot']['room']
  end

  def time_out
    settings['hubot']['timeout'] || 5
  end

  def retry_number
    settings['hubot']['retry'] || 5
  end

  def handle
    metrics = {
      client: @event['client']['name'],
      check: @event['check']['name'],
      output: @event['check']['output'],
      status: @event['check']['status'],
      occurrences: @event['occurrences']
    }
    success = false

    retry_number.times do
      begin
        timeout(time_out) do
          uri = URI "http#{'s' if https}://#{host}:#{port}/sensu?room=#{room}"
          http = Net::HTTP.new uri.host, uri.port
          request = Net::HTTP::Post.new uri, 'content-type' => 'application/json; charset=utf-8'
          request.body = JSON.dump metrics

          response = http.request request
          if response.code == '200'
            puts "request metrics #=> #{metrics}"
            puts "response body #=> #{response.body}"
            puts "hubot post ok."
            success = true
          else
            puts "request metrics #=> #{metrics}"
            puts "response body #=> #{response.body}"
            puts "hubot post failure. status error code #=> #{response.code}"
          end
        end
      rescue Timeout::Error
        puts "hubot timeout error."
      end
      break if  success
    end
  end
end

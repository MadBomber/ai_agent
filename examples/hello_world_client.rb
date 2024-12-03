#!/usr/bin/env ruby
# examples/hello_world_client.rb

require 'json'
require 'json_schema'
require 'securerandom'
require_relative '../lib/ai_agent'

class HelloWorldClient < AiAgent::Base
  def init
    send_request
  end

  def send_request
    to_uuid = discover_agent(capability: 'greeter', how_many: 1).first[:uuid]

    request = build_request(
                to_uuid:,
                greeting: 'Hey',
                name:     'MadBomber'
              )

    result = @message_client.publish(request)
    logger.info "Sent request: #{request.inspect}; status? #{result.inspect}"
  end

  def build_request(
                to_uuid:,
                greeting: 'Hello',
                name:     'World'
              )

    {
      header: {
        type:       'request',
        from_uuid:  @id,
        to_uuid:,
        event_uuid: SecureRandom.uuid,
        timestamp:  AiAgent::Timestamp.new.to_i
      },
      greeting:,
      name:
    }
  end


  def receive_response
    logger.info "Received response: #{payload.inspect}"
    result = payload[:result]

    puts
    puts `echo "#{result}" | boxes -d info`
    puts

    exit(0)
  end

  #####################################################
  private

  def capabilities
    ['hello_world_client']
  end
end


# Example usage
client = HelloWorldClient.new
client.run


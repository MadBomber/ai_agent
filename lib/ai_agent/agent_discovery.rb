# lib/ai_agent/agent_discovery.rb

module AiAgent::AgentDiscovery

  # Returns the agent's capabilities (to be overridden by subclasses).
  #
  # @return [Array<String>] The agent's capabilities
  #
  def capabilities
    []
  end

  
  ################################################
  private
  
  # Discovers other agents with a specific capability.
  #
  # @param capability [String] The capability to search for
  # @param how_many [Integer] The number of agents to return
  # @param all [Boolean] Whether to return all matching agents
  # @return [Array<Hash>] The discovered agents
  # @raise [RuntimeError] If no agents are found
  #
  def discover_agent(capability:, how_many: 1, all: false)
    result = @registry_client.discover(capability:)

    if result.empty?
      logger.error "No agents found for capability: #{capability}"
      raise "No agents available"
    end

    all ? result : result.sample(how_many)
  end
end

# lib/ai_agent/header_management.rb

module AiAgent::HeaderManagement


  ################################################
  private
  
  def header      = @payload[:header]
  def to_uuid     = header[:to_uuid]
  def from_uuid   = header[:from_uuid]
  def event_uuid  = header[:event_uuid]
  def timestamp   = header[:timestamp]
  def type        = header[:type]

  def return_address
    header.merge(
      to_uuid:    from_uuid,
      from_uuid:  to_uuid,
      timestamp:  AiAgent::Timestamp.new.to_i,
      type:       'response'
    )
  end
end

class EntityExtraction

  attr_accessor :entities

  def initialize(text, subjects)
    return if text.blank?

    @text = text
    @subjects = subjects
    extract_entities
  end

  def client
    OpenCalais::Client.new(api_key: ENV['OPEN_CALAIS_TOKEN'])
  end

  def response
    client.enrich(@text)
  end

  def extract_entities
    self.entities = response.entities.select do |entity|
      @subjects.include? entity[:type]
    end
  end

  def terminologies
    entities.map{ |term| term[:name] }.uniq!
  end
end

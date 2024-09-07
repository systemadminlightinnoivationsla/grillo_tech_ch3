require 'httparty'

class Metric
  include HTTParty
  base_uri 'http://localhost:7474'

  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def save
    query = {
      statements: [
        {
          statement: "MERGE (m:Metric {key: '#{key}'}) SET m.value = #{value} RETURN m"
        }
      ]
    }

    response = self.class.post(
      '/db/neo4j/tx/commit',
      basic_auth: { username: 'neo4j', password: 'your_password' },
      headers: { 'Content-Type' => 'application/json' },
      body: query.to_json
    )

    if response.success?
      puts "Metric saved successfully: #{response.parsed_response}"
      true
    else
      puts "Error during save: #{response.parsed_response}"
      false
    end
  end
end

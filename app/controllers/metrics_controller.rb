class MetricsController < ApplicationController
  def create
    key = params[:key]
    
    begin
      request_body = JSON.parse(request.body.read)
      value = request_body['value']
    rescue JSON::ParserError
      render json: { error: 'Invalid JSON in request body' }, status: :bad_request
      return
    end

    if key.blank? || value.blank?
      render json: { error: 'Missing key or value' }, status: :bad_request
      return
    end

    timestamp = Time.now.to_i

    query = "MERGE (m:Metric {key: $key}) " \
            "CREATE (m)-[:HAS_VALUE]->(:Value {value: $value, timestamp: $timestamp})"

    begin
      execute_query(query, key: key, value: value.to_f, timestamp: timestamp)
      render json: {}, status: :ok
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  def destroy
    key = params[:key]

    query = "MATCH (m:Metric {key: $key}) " \
            "OPTIONAL MATCH (m)-[:HAS_VALUE]->(v:Value) " \
            "DETACH DELETE m, v"

    begin
      execute_query(query, key: key)
      render json: {}, status: :ok
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  def index
    one_hour_ago = Time.now.to_i - 3600

    query = "MATCH (m:Metric)-[:HAS_VALUE]->(v:Value) " \
            "WHERE v.timestamp > $one_hour_ago " \
            "WITH m.key AS key, SUM(v.value) AS total " \
            "RETURN key, total"

    begin
      result = execute_query(query, one_hour_ago: one_hour_ago)
      metrics = result['data'].map do |row|
        { key: row['row'][0], total: row['row'][1] }
      end
      render json: metrics
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  private

  def execute_query(query, params = {})
    response = HTTParty.post(
      NEO4J_CONFIG[:url],
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => NEO4J_CONFIG[:auth]
      },
      body: { 
        statements: [{ statement: query, parameters: params }]
      }.to_json
    )

    if response.success?
      response.parsed_response['results'][0]
    else
      raise "Neo4j error: #{response.body}"
    end
  end
end
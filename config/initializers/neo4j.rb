require 'httparty'
require 'base64'

NEO4J_CONFIG = {
  url: 'http://localhost:7474/db/neo4j/tx/commit',
  auth: "Basic #{Base64.strict_encode64('neo4j:your_password')}"
}
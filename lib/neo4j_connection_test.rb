module Neo4jConnectionTest
    def self.run
      begin
        driver = Neo4j::Driver::GraphDatabase.driver(
          'bolt://localhost:7687',
          Neo4j::Driver::AuthTokens.basic('neo4j', 'your_password')
        )
  
        session = driver.session
        result = session.run("RETURN 1 as n")
        puts "Resultado de la consulta: #{result.next['n']}"
        true
      rescue => e
        puts "Error al conectar con Neo4j: #{e.message}"
        false
      ensure
        session.close if session
        driver.close if driver
      end
    end
  end
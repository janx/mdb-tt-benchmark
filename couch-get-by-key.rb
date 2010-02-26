require 'couch'

server = Couch::Server.new("localhost", "5984")

time_to_get = 50000
start_time = Time.now.to_i
gets_count = 0

time_to_get.times do

	id = rand(12000) + 1
        server.get("/test/#{id}")

	gets_count = gets_count + 1
	if (gets_count % 10000 == 0)
		end_time = Time.now.to_i
		puts "#{gets_count} gets: #{end_time - start_time}s"
	end
end

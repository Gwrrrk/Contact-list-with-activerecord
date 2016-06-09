require 'pg'

ActiveRecord::Base.establish_connection(
	adapter: 'postgresql',
	host: 'localhost',
	dbname: 'contacts',
	user: 'development',
	password: 'development'
	)

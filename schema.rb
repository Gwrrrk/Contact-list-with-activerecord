require 'active_record'
require_relative 'db'

ActiveRecord::Schema.define do
	drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)
  create_table :contacts do |t|
    t.column :name, :string
    t.column :email, :string
  end
end
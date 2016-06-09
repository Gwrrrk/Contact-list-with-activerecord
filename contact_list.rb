require 'pry'
require 'active_record'
require_relative 'db'
require_relative 'contact'
require_relative 'telephone_numbers'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

	attr_accessor :new_name

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def list_contacts
  	list = Contact.all
    list.each do |line|
      puts "#{line.id}: #{line.name}: #{line.email}"
    end
  end

  def add_contact
    puts "Please enter a name:"
 		name = STDIN.gets.chomp()
    puts "Please enter an email address:"
 		email = STDIN.gets.chomp()
 		Contact.create(name: name, email: email)
  end

  def show_contact(id)
  	contact = Contact.find(id)
    puts "#{contact.id}: #{contact.name}, #{contact.email}"
  end

  def find_contact(term)
    # binding.pry
    contact = Contact.where("name LIKE ? OR email LIKE ?", "%#{term}%", "%#{term}%")
    contact.each {|person| puts "#{person.name}, #{person.email}"}
  end

  def update_contact(id)
    updated_contact = Contact.find(id)
    puts "Please enter the new name:"
    updated_contact.name = STDIN.gets.chomp()
    puts "Please enter the new email address:"
    updated_contact.email = STDIN.gets.chomp()
    updated_contact.save
  end

  def delete_contact(id)
    contact = Contact.find(id)
    if contact == nil
      puts "Contact not found!"
    else
      puts "#{contact.name} destroyed!"
      contact.destroy
    end
  end
end

contact_list = ContactList.new

case ARGV[0]
	when "list"
		contact_list.list_contacts
	when "new" 
		contact_list.add_contact
	when "show"
		contact_list.show_contact(ARGV[1].to_i)
	when "search"
    contact_list.find_contact(ARGV[1])
  when "update"
    contact_list.update_contact(ARGV[1].to_i)
  when 'destroy'
    contact_list.delete_contact(ARGV[1].to_i)
  else
    puts "Here is a list of available commands:"
    puts "new -add a contact to the contact list"
    puts "list -List all contacts"
    puts "show * -Show a contact via id number"
    puts "search -Search contacts"
    puts "update * -select a contact via id and then update a contact"
    puts "destroy * - select a contact via ID and then delete them"
end
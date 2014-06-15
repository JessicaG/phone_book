gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/mock'
require_relative '../lib/phone_book'
require_relative '../lib/entry_repository'
require_relative '../lib/db'
require_relative '../lib/person'
require_relative '../lib/phone_number'

class EntryRepositoryTest < Minitest::Test
  def people_data
    [
      { id: "1", first_name: "Alice", last_name: "Smith" },
      { id: "2", first_name: "Bob", last_name: "Smith" },
      { id: "3", first_name: "Charlie", last_name: "Jones" }
    ].map {|row| Person.new(row)}
  end

  def people
    DB.new(people_data)
  end

  def phone_numbers_data
    [
      { person_id: "1", phone_number: "111.111.1111" },
      { person_id: "1", phone_number: "111.111.2222" },
      { person_id: "2", phone_number: "222-222-1111" }
    ].map {|row| Phone_Number.new(row)}
  end

  def phone_numbers
    DB.new(phone_numbers_data)
  end

  def repository
    @repository ||= EntryRepository.new(people, phone_numbers)
  end

  private

  def format(number)
    digits = number.delete("-.")
    area_code = digits[0..2]
    exchange = digits[3..5]
    subscriber = digits[-4..-1]

    "(%s) %s-%s" % [area_code, exchange, subscriber]
  end

  # def test_find_by_last_name
  #   entries = repository.find_by_last_name("Smith").sort_by {|e| e.first_name}
  #   assert_equal 2, entries.length
  #   alice, bob = entries
  #   assert_equal "Alice Smith", alice.name
  #   assert_equal ["111.111.1111", "111.111.2222"], alice.numbers
  #   assert_equal "Bob Smith", bob.name
  #   assert_equal ["222-222-1111"], bob.numbers
  # end
end

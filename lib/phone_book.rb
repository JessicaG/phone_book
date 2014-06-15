require_relative '../lib/entry_repository'
require_relative '../lib/db'
require_relative '../lib/entry'
require 'csv'

class PhoneBook
  attr_reader :repository

  def initialize(repository=EntryRepository.in('./data'))
    @repository = repository
  end

  def lookup(name)
    repository.find_by_last_name(name)
  end
end

class Resource < ApplicationRecord
  
  # Validates Resources Parameters for Add Fund page
  validates :contact_person, length: { maximum: 255 }
  validates :source, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :contact_person, presence: { message: "and Department can't both be blank." }, on: :create, unless: :source?
  validates :source, presence: { message: "and Fund Owner can't both be blank." }, on: :create, unless: :contact_person?
  
  # This may be a good validation to have
  # validates :title, uniqueness: { message: " has already been taken." }
  
  
  #Including pg_search capabilities to this model
  include PgSearch::Model
  
  # include Gutentag gem
  ::Gutentag::ActiveRecord.call self
  
  #Definining the variables the pg_search should  work for,
  #the type of search (tsearch = full text search);
  #and whether it should search for partial words or not (prefix: true)
  pg_search_scope :search, against: [:title, :description, :amount, :contact_person, :source], using: {tsearch: {prefix: true}}
  pg_search_scope :search_amount, against: [:amount], using: {tsearch: {prefix: true}}
  
  #scope :filter by
  
  def print_decription
    return "#{description}"
  end
  
end
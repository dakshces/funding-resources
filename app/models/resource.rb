class Resource < ApplicationRecord
  
  
  # This email regex could be improved
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  
  # Validates Resources Parameters
  validates :title, presence: true, length: { maximum: 255 }
  validates :contact_person, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  
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
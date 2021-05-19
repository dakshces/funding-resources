class Resource < ApplicationRecord
  # Validates Resources Parameters for Add Fund page
  validates :contact_person, length: { maximum: 255 }
  validates :source, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  
  # The "on: :create" parameter is meant to force students to provide these field when submmitting a resource for review.
  # This would then allow admin to remove these fields before approving if they want to.
  # The only issue is that admin would not be able to create a new resource without these fields.
  # The admin would have to create the resource then update it
  validates :contact_person, presence: { message: "and Department can't both be blank." }, on: :create, unless: :source?
  validates :source, presence: { message: "and Fund Owner can't both be blank." }, on: :create, unless: :contact_person?
  
  # Currently validates any email address but can be switched to only grinnell emails
  VALID_EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,10}\Z/i
  GRINNELL_EMAIL_REGEX = /\A[A-Z0-9._%+-]+@grinnell.edu\Z/i
  # validates :email, presence: true, on: :create
  validates :email, allow_blank: true, format: { with: VALID_EMAIL_REGEX, message: "is invalid"  }
  
  # This may be a good validation to have
  # This validates that all titles are unique, it could prevent duplicate submissions.
  # validates :title, uniqueness: { message: " has already been taken." }
  
  
  #Including pg_search capabilities to this model
  include PgSearch::Model
  
  # include Gutentag gem
  Gutentag::ActiveRecord.call self
  
  #Definining the variables the pg_search should  work for,
  #the type of search (tsearch = full text search);
  #and whether it should search for partial words or not (prefix: true)
  pg_search_scope :search, against: [:title, :description, :amount, :contact_person, :source, :criteria, :requirements, :email, :web], using: {tsearch: {prefix: true}}
  pg_search_scope :search_amount, against: [:amount], using: {tsearch: {prefix: true}}
  
  #scope :filter by
  
  def print_decription
    return "#{description}"
  end
  
  
end
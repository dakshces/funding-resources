class Resource < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:title, :description, :amount, :cp, :source], using: {tsearch: {prefix: true}}
end

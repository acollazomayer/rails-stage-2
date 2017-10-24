class SearchTerm < ActiveRecord::Base
  validates :search, presence: true
end

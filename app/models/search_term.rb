class SearchTerm < ActiveRecord::Base
  validates :search, presence: true

  def self.search_by_term(term = '')
    SearchTerm.where('search like ?', "%#{term}%").group(:search).order('count_id desc').count('id')
  end
end

require 'rails_helper'

describe SearchTerm, :type => :model do
  context 'when no search is given' do
    subject { SearchTerm.new(search: nil) }
    it { is_expected.to_not be_valid }
  end

  context 'when a search is given' do
    subject { SearchTerm.new(search: 'somesearch') }
    it { is_expected.to be_valid }
  end
end

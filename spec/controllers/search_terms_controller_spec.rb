require 'rails_helper'
require 'webmock/rspec'

describe SearchTermsController do

  describe 'GET index' do
    searches = nil

    before do
      create(:search_term, search: 'some_search1')
      create(:search_term, search: 'some_search2')
    end

    it "should populate an array of searches" do
      get :index
      assigns(:search_terms_keys).should eql(["some_search1", "some_search2"])
    end

    it "should render the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET edit' do
    searches = nil

    before do
      create(:search_term, search: 'some_search1')
      create(:search_term, search: 'some_search2')
    end

    it "should populates an array of searches" do
      get :edit, id: 'someid'
      assigns(:search_terms_keys).should eql(["some_search1", "some_search2"])
    end

    it "should render the edit view" do
      get :edit, id: 'someid'
      response.should render_template :edit
    end

  end

  describe 'GET new' do

    it "should render the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do

    response = {
      items: [{
        title: 'sometitle',
        snippet: 'somesnippet',
        displayLink: 'somedisplayLink',
        link: 'somelink'
      }]
    }

    before do
      stub_request(:get, /.*/).
      to_return(status: 200, body: response.to_json)
    end

    context "with valid attributes" do

      it "should create a new search" do
        expect{
          post :create, search_term: attributes_for(:search_term)
        }.to change(SearchTerm,:count).by(1)
      end

      it "should redirect to new view" do
        post :create, search_term: attributes_for(:search_term)
        response.should render_template :new
      end
    end

    context "with invalid attributes" do
      it "should not save the new search" do
        expect{
          post :create, search_term: { invalid: 'atribute' }
        }.to_not change(SearchTerm, :count)
      end

      it "should re-renders the new view" do
        post :create, search_term: { invalid: 'atribute' }
        response.should render_template :new
      end
    end
  end

  describe 'DELETE delete_term' do
    searches =  nil

    before do
      searches = create_list(:search_term, 10)
    end

    context 'when a term is deleted' do

      it 'should delete all searches with that same term' do
        expect{
          delete :delete_term, term: 'somesearch'
        }.to change(SearchTerm, :count).from(10).to(0)
      end

      it 'should re-render the index view' do
        delete :delete_term, term: 'somesearch'
        response.should redirect_to action: 'index'
      end

    end
  end

  describe 'POST update_term' do
    searches =  nil

    before do
      searches = create_list(:search_term, 10)
    end

    context 'when a term is deleted' do

      it 'should update all searches with that same term' do
        post :update_term, edit_term: attributes_for(:search_term, search: 'someeditedvalue'), term: "somesearch"
        expect(SearchTerm.group(:search).order('count_id desc').count('id')).to eql({'someeditedvalue' => 10})
      end

      it 'should re-render the index view' do
        post :update_term, edit_term: attributes_for(:search_term), term: "somesearch"
        response.should redirect_to action: 'index'
      end

    end
  end

end

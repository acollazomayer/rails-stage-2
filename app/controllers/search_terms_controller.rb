require 'will_paginate/array'
require 'rest-client'

class SearchTermsController < ApplicationController

  def create
      SearchTerm.create(search_params)
      query = search_params[:search]
      api_key = Rails.configuration.config['api_key']
      search_engine = Rails.configuration.config['search_engine']
      url = Rails.configuration.config['url']
      response = RestClient.get url, { params: { key: api_key, cx: search_engine, q: query }}
      body = JSON.parse(response.body)
      @search_results = body['items']
      render 'new'
  end

  def new
    @focus = true
  end

  def index
    @focus = true
    term = params[:search_term] == nil ? '' : params[:search_term][:search]
    @search_terms = SearchTerm.where('search like ?', "%#{term}%").group(:search).order('count_id desc').count('id')
    @search_terms_keys = @search_terms.keys.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
    @focus = false
    @edit_term = params[:id]
    @search_terms = SearchTerm.group(:search).order('count_id desc').count('id')
    @search_terms_keys = @search_terms.keys.paginate(:page => params[:page], :per_page => 5)
  end

  def delete_term
    @search_terms = SearchTerm.where(search: params[:term]).destroy_all
    redirect_to action: 'index'
  end

  def update_term
    term = params[:term]
    @search_terms = SearchTerm.where(search: term).update_all(search: edit_term_params[:search])
    redirect_to action: 'index'
  end

  private
    def search_params
      params.require(:search_term).permit(:search)
    end

    def edit_term_params
      params.require(:edit_term).permit(:search)
    end
end

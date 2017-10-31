require 'will_paginate/array'
require 'rest-client'

class SearchTermsController < ApplicationController

  def create
    SearchTerm.create(search_params)
    query = search_params[:search]
    @search = SearchTermsHelper.search(query)
    render 'new'
  end

  def index
    @search_terms = SearchTerm.search_by_term()
    @search_terms_keys = @search_terms.keys.paginate(:page => params[:page], :per_page => 5)
  end

  def filter_terms
    @search_terms = SearchTerm.search_by_term(params[:search_term][:search])
    @search_terms_keys = @search_terms.keys.paginate(:page => params[:page], :per_page => 5)

    respond_to do |format|
      format.js
    end
  end

  def edit
    @edit_term = params[:id]
    @search_terms = SearchTerm.search_by_term()
    @search_terms_keys = @search_terms.keys.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.js
    end
  end

  def delete_term
    SearchTerm.where(search: params[:term]).destroy_all
    @search_terms = SearchTerm.search_by_term()
    @search_terms_keys = @search_terms.keys.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html { redirect_to search_terms_path }
      format.js
    end
  end

  def update_term
    SearchTerm.where(search: params[:term]).update_all(search: edit_term_params[:search])
    @search_terms = SearchTerm.search_by_term()
    @search_terms_keys = @search_terms.keys.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.js
    end
  end

  private
    def search_params
      params.require(:search_term).permit(:search)
    end

    def edit_term_params
      params.require(:edit_term).permit(:search)
    end
end

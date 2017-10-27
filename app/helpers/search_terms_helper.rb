module SearchTermsHelper

  def self.search(query)
    api_key = Rails.configuration.config['api_key']
    search_engine = Rails.configuration.config['search_engine']
    url = Rails.configuration.config['url']
    response = RestClient.get url, params: { key: api_key, cx: search_engine, q: query }
    body = JSON.parse(response.body)
    {search_results: body['items'], total_results: Integer(body['queries']['request'][0]['totalResults'])}
  end
end

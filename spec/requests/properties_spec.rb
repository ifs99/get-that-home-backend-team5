require 'rails_helper'
describe 'Properties', type: :request do
  it 'index path respond with http success status code' do
    get '/api/properties'
    properties = JSON.parse(response.body)
    puts properties
    expect(response.status).to eq(200)
  end
end

require 'rails_helper'

RSpec.describe MetricsController, type: :controller do
  describe "POST #create" do
    it "creates a new metric" do
      post :create, params: { key: 'test_metric', value: 10 }
      expect(response).to have_http_status(:ok)
      expect(Metric.find_by(key: 'test_metric')).not_to be_nil
    end
  end

  describe "DELETE #destroy" do
    it "deletes an existing metric" do
      metric = Metric.create(key: 'test_metric')
      delete :destroy, params: { key: 'test_metric' }
      expect(response).to have_http_status(:ok)
      expect(Metric.find_by(key: 'test_metric')).to be_nil
    end
  end

  describe "GET #index" do
    it "returns metrics for the last hour" do
      metric = Metric.create(key: 'test_metric')
      metric.values.create(value: 10, timestamp: Time.now.to_i)
      metric.values.create(value: 20, timestamp: 2.hours.ago.to_i)

      get :index
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.first['key']).to eq('test_metric')
      expect(body.first['total']).to eq(10.0)
    end
  end
end
require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  describe "アイデア取得" do
    it "全てのアイデアを取得する" do
      get api_v1_categories_path
      expect(response).to have_http_status(200)
    end
  end
end

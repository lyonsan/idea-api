require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  before do
    @category1 = Category.create(name: 'category1')
    @category2 = Category.create(name: 'category2')
    @idea1 = @category1.ideas.create(body: 'idea1')
    @idea2 = @category2.ideas.create(body: 'idea2')
  end
  describe "アイデア取得" do
    context 'アイデアを取得できる' do
      it "カテゴリー名を指定しない場合、全てのアイデアを取得する" do
        get api_v1_categories_path, params: { category_name: nil }
        json = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(json['data'].length).to eq(2)
      end
      it 'カテゴリー名を指定する場合、リクエストを送ったカテゴリー名に属するアイデアを取得する' do
        get api_v1_categories_path, params: { category_name: 'category1' }
        json = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        json['data'].each do |d|
          expect(d['category']).to eq('category1')
        end
      end
    end
    context 'アイデアを取得できない' do
      it 'カテゴリー名を指定する場合、リクエストを送ったカテゴリーが存在しない場合にアイデアを取得できない' do
        get api_v1_categories_path, params: { category_name: 'category3' }
        expect(response).to have_http_status(404)
      end
    end
  end
  describe 'アイデア登録' do
    context 'アイデアを登録できる' do
      it 'これまでに存在しないカテゴリー名を入力しても登録できる' do
        expect {post api_v1_categories_path, params: { category_name: 'category3', body: 'idea' } }.to change { Category.count }.by(1) && change { Idea.count }.by(1)
        expect(response).to have_http_status(201)
      end
      it 'これまでに存在しているカテゴリー名を入力しても登録できる' do
        expect {post api_v1_categories_path, params: { category_name: 'category1', body: 'idea' } }.to change { Category.count }.by(0) && change { Idea.count }.by(1)
        expect(response).to have_http_status(201)
      end
    end
    context 'アイデアを登録できない' do
      it 'カテゴリー名を入力していないと登録できない' do
        expect {post api_v1_categories_path, params: { category_name: nil, body: 'idea' } }.to change { Category.count }.by(0) && change { Idea.count }.by(0)
        expect(response).to have_http_status(422)
      end
      it '本文を入力していないと登録できない' do
        expect {post api_v1_categories_path, params: { category_name: 'category3', body: nil } }.to change { Category.count }.by(0) && change { Idea.count }.by(0)
        expect(response).to have_http_status(422)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe "index" do
    let!(:user) {create(:user)}
    let!(:user2) {create(:random_user)}
    let!(:list_items) {create_list(:random_item, 4, user: user)}
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: user2.id}).token}
    it "if user unauthorized" do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end

    it "respons four items" do

      headers = {Authorization: authorization_header}
      request.headers.merge! headers
      get :index
      expect(response.body).to eq(ActiveModelSerializers::SerializableResource.new(list_items).to_json)
    end
  end


  # def create
  #   item = Item.new(item_params)
  #   item.user = current_user
  #   if item.save
  #     render json: item
  #   else
  #     render json: { errors: item.errors }, status: :unprocessable_entity
  #   end
  # end
  describe "create" do
    let!(:user2) {create(:random_user)}
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: user2.id}).token}
    let(:random_category) {create(:random_category)}
    it "if user unauthorized" do
      get :create
      expect(response).to have_http_status(:unauthorized)
    end

    it "create new item" do
      params = {
          item: {
              name: 'Potato',
              description: "AAAAAAA",
              price: 2.2,
              category: random_category
          }
      }
      headers = {Authorization: authorization_header}
      request.headers.merge! headers
       p request.params.merge! params
     p post :create
      expect(response).to have_http_status(:unauthorized)
    end
  end

end

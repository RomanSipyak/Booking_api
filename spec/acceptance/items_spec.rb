require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

resource 'Items' do
  header 'Content-Type', 'application/json'
  header 'Accept', 'application/json'

  post '/items' do

    let!(:random_user2) {create(:random_user)}
    let(:category) {Category.create(title: "Music")}
    let(:raw_post) {params.to_json}
    header "Authorization", :authorization_header

    with_options scope: :item do
      parameter :name, 'item_name'
      parameter :price, 'item_price'
      parameter :description, 'item_description'
      parameter :category_id, 'item_category'
      parameter :user_id, 'user_id'
    end

    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user2.id}).token}
    let(:name) {'Aaaa'}
    let(:description) {'description'}
    let(:price) {10.22}
    let(:category_id) {category.id}


    example_request 'Create item' do
      expect(status).to eq(200)
      item = Item.last
      expect(item.name).to eq(name)
      expect(item.user).to eq(random_user2)
    end
  end

  patch '/items/:id' do

    let!(:user) {create(:user)}
    let(:update_item) {create(:random_item, user: user)}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header

    with_options scope: :item do
      parameter :name, 'item_name'
      parameter :price, 'item_price'
      parameter :description, 'item_description'
    end

    let(:id) {update_item.id}
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: user.id}).token}
    let(:name) {'Aaaa'}
    let(:price) {10}
    let(:description) {'description'}

    example_request 'Update an item' do
      expect(status).to eq(200)
      item = Item.find(id)
      expect(item.name).to eq(name)
      expect(item.price).to eq(price)
      expect(item.description).to eq(description)
    end

  end

  patch '/items/:id' do

    let!(:user) {create(:user)}
    let!(:random_user2) {create(:random_user)}
    let(:update_item) {create(:random_item, user: user)}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header

    with_options scope: :item do
      parameter :name, 'item_name'
      parameter :price, 'item_price'
      parameter :description, 'item_description'
    end

    let(:id) {update_item.id}
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user2.id}).token}
    let(:name) {'Aaaa'}
    let(:price) {10}
    let(:description) {'description'}

    example_request 'Update an item not own item' do
      expect(response_body).to eq({errors: "you can't do it"}.to_json)
    end
  end


  delete '/items/:id' do

    let!(:user) {create(:user)}
    let(:delete_item) {create(:random_item, user: user)}


    header "Authorization", :authorization_header

    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: user.id}).token}
    let(:id) {delete_item.id}

    example_request 'Delete item' do
      expect(status).to eq(200)
      expect(Item.find_by(id: id)).to eq(nil)
    end
  end

  delete '/items/:id' do

    let!(:user) {create(:user)}
    let!(:random_user2) {create(:random_user)}
    let(:delete_item) {create(:random_item, user: user)}

    header "Authorization", :authorization_header

    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user2.id}).token}
    let(:id) {delete_item.id}

    example_request 'Delete item not own item' do
      expect(response_body).to eq({errors: "you can't do it"}.to_json)
    end
  end


  get '/items' do

    let!(:user) {create(:user)}
    let!(:list_items) {create_list(:random_item, 1, user: user)}
    let!(:random_user2) {create(:random_user)}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user2.id}).token}

    example_request 'Index. All items not current user' do
      expect(status).to eq(200)
      expect(response_body).to eq(ActiveModelSerializers::SerializableResource.new(list_items).to_json)
    end
  end

  get '/items' do

    let!(:user) {create(:user)}
    let!(:list_items) {create_list(:random_item, 5, user: user)}
    let!(:random_user2) {create(:random_user)}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: user.id}).token}

    example_request 'Index items not current user' do
      expect(status).to eq(200)
      expect(response_body).to eq([].to_json)
    end
  end

  get '/items/all' do

    let!(:user) {create(:user)}
    let!(:list_items) {create_list(:random_item, 5, user: user)}

    example_request 'Index All items in db ' do
      expect(status).to eq(200)
      expect(response_body).to eq(ActiveModelSerializers::SerializableResource.new(list_items).to_json)
    end
  end

  get '/items/my' do

    let!(:user) {create(:user)}
    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:random_user2) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:random_user3) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:random_user4) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:list_items) {create_list(:random_item, 5, user: user)}
    let!(:list_items2) {create_list(:random_item, 5, user: random_user4)}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: user.id}).token}
    example_request 'All items of current user' do
      expect(status).to eq(200)
      expect(response_body).to eq(ActiveModelSerializers::SerializableResource.new(list_items).to_json)
    end
  end


  get '/items/:id' do

    let!(:item) {create(:random_item)}
    let(:id) {item.id}

    example_request 'Show item' do
      expect(status).to eq(200)
      expect(response_body).to eq(ActiveModelSerializers::SerializableResource.new(item).to_json)
    end
  end

end
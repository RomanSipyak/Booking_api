require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

resource 'Reviews' do
  header 'Content-Type', 'application/json'
  header 'Accept', 'application/json'

  post '/items/:item_id/reviews' do

    let!(:item) {create(:item)}
    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let(:raw_post) {params.to_json}
    header "Authorization", :authorization_header

    with_options scope: :review do
      parameter :reviewcontainer_type, 'Item'
      parameter :reviewcontainer_id, 'item_price'
      parameter :rating, 'item_description'
      parameter :comment, 'review_comment'
    end

    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user1.id}).token}
    let(:reviewcontainer_type) {'Item'}
    let(:reviewcontainer_id) {item.id}
    let(:rating) {5}
    let(:comment) {'comment'}


    example_request 'Create review for item' do
      expect(status).to eq(200)
      review = Review.last
      expect(review.comment).to eq(comment)
    end
  end
  post '/items/:item_id/reviews' do

    let!(:item) {create(:item)}
    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let(:raw_post) {params.to_json}
    header "Authorization", :authorization_header

    with_options scope: :review do
      parameter :reviewcontainer_type, 'Item'
      parameter :reviewcontainer_id, 'item_price'
      parameter :rating, 'item_description'
      parameter :comment, 'review_comment'
    end

    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user1.id}).token}
    let(:reviewcontainer_type) {'User'}
    let(:reviewcontainer_id) {item.id}
    let(:rating) {5}
    let(:comment) {'comment'}


    example_request 'Create review for user' do
      expect(status).to eq(200)
      review = Review.last
      expect(review.comment).to eq(comment)
    end
  end

  delete '/items/:item_id/reviews/:id' do
    let!(:item) {create(:item)}
    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:review) {create(:review, reviewcontainer_type: "Item", reviewcontainer_id: item.id, user: random_user1)}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user1.id}).token}
    let(:item_id) {item.id}
    let(:id) {review.id}

    example_request 'Delete review for item' do
      expect(status).to eq(200)
      review = Review.where(id: id)
      expect(review).to eq([])
    end
  end

  delete '/users/:user_id/reviews/:id' do
    let!(:item) {create(:item)}
    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:random_user2) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:review) {create(:review, reviewcontainer_type: "User", reviewcontainer_id: random_user1.id, user: random_user2)}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user2.id}).token}
    let(:user_id) {random_user1.id}
    let(:id) {review.id}

    example_request 'Delete review for user' do
      expect(status).to eq(200)
      review = Review.where(id: id)
      expect(review).to eq([])
    end
  end

  delete '/users/:user_id/reviews/:id' do
    let!(:item) {create(:item)}
    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:random_user2) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:review) {create(:review, reviewcontainer_type: "User", reviewcontainer_id: random_user1.id, user: random_user2)}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user1.id}).token}
    let(:user_id) {random_user1.id}
    let(:id) {review.id}

    example_request 'Update an item not own item' do
      expect(response_body).to eq({errors: "you can't do it"}.to_json)
    end
  end
end
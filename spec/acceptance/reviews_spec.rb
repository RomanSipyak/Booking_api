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
      p random_user1
      expect(status).to eq(200)
      review = Review.last
      expect(review.comment).to eq(comment)
    end
  end
end
require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

resource 'Books' do
  header 'Content-Type', 'application/json'
  header 'Accept', 'application/json'

  post '/items/:item_id/books' do

    let!(:random_user) {create(:random_user, username: Faker::Name.unique.name)}
    let(:category) {Category.create(title: "Music")}
    let!(:item) {create(:random_item)}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user.id}).token}


    with_options scope: :book do
      parameter :start_booking
      parameter :end_booking
    end

    let(:item_id) {item.id}
    let(:start_booking) {"Jan 1, 2020 12:01:01"}
    let(:end_booking) {"Jan 13, 2020 12:01:01"}

    example_request 'Create book for item' do
      expect(status).to eq(200)
    end
  end

  post '/items/:item_id/books' do

    let!(:random_user) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:item) {create(:random_item)}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user.id}).token}


    with_options scope: :book do
      parameter :start_booking
      parameter :end_booking
    end

    let(:item_id) {item.id}
    let(:start_booking) {"Jan 10, 2020 12:01:01"}
    let(:end_booking) {"Jan 1, 2020 12:01:01"}

    example_request 'Create book for item but start > end' do
      expect(status).to eq(422)
    end
  end


  get '/items/:item_id/books' do
    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:random_user2) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:item) {create(:random_item)}

    let!(:item2) {create(:random_item, title: Faker::Name.unique.name)}
    let!(:book) {create(:book, user: random_user1, item: item)}
    let!(:book2) {create(:book, user: random_user2, item: item2)}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user1.id}).token}

    let(:item_id) {item.id}

    example_request 'books for item' do
      expect(response_body).to eq(ActiveModelSerializers::SerializableResource.new(book).to_json)
    end

  end

  get '/items/:item_id/books/:id' do

    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:item) {create(:random_item)}
    let!(:book) {create(:book, user: random_user1, item: item)}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user1.id}).token}

    let(:item_id) {item.id}
    let(:id) {book.id}
    example_request 'Show book' do
      expect(response_body).to eq(ActiveModelSerializers::SerializableResource.new(book).to_json)
    end
  end

  delete '/items/:item_id/books/:id' do

    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:item) {create(:random_item)}
    let!(:book) {create(:book, user: random_user1, item: item)}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user1.id}).token}

    let(:item_id) {item.id}
    let(:id) {book.id}
    example_request 'Destroy book' do
      expect(status).to eq(200)
    end
  end
  delete '/items/:item_id/books/:id' do

    let!(:random_user1) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:random_user2) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:item) {create(:random_item)}
    let!(:book) {create(:book, user: random_user1, item: item)}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user2.id}).token}

    let(:item_id) {item.id}
    let(:id) {book.id}
    example_request 'Destroy book if you are not own ' do
      expect(response_body).to eq({errors: "you can't do it"}.to_json)
    end
  end

=begin
  get '/items/:item_id/books' do

    let!(:random_user) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:random_user2) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:item) {create(:random_item)}
    let!(:book) {create(:book , user: random_user,item: item )}
    let!(:book2) {create(:book , user: random_user2,item: item )}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user.id}).token}

    let(:item_id) {item.id}

    example_request '' do
      expect(response_body).to eq(ActiveModelSerializers::SerializableResource.new(book2).to_json)
    end
  end
=end

=begin
  patch '/items/:item_id/books/:id' do

    let!(:random_user) {create(:random_user, username: Faker::Name.unique.name)}
    let!(:item) {create(:random_item)}
    let!(:booking) {create(:book)}
    let(:raw_post) {params.to_json}

    header "Authorization", :authorization_header
    let(:authorization_header) {Knock::AuthToken.new(payload: {sub: random_user.id}).token}


    with_options scope: :book do
      parameter :start_booking
      parameter :end_booking
    end

    let(:id) {booking.id}
    let(:item_id) {item.id}
    let(:start_booking) {"Jan 12, 2020 12:01:01"}
    let(:end_booking) {"Jan 15, 2020 12:01:01"}

    example_request 'update book' do
      expect(status).to eq(200)
    end
  end
=end


end
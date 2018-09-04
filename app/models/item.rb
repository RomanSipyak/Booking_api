class Item < ApplicationRecord

  include ImageUploader::Attachment.new(:image)
  include Filterable
  has_many :reviews, as: :reviewcontainer, dependent: :destroy
  belongs_to :user
  belongs_to :category
  has_many :books, dependent: :destroy
=begin
  extend ItemSpliter
  split(name)
=end

  validates :name, :description, :rating, presence: true
  validates :price, :rating, numericality: true
  def self.average_rating
    average(:rating)
  end

  validates :price, presence: true, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
            numericality: {greater_than: 0, less_than: 1_000_000}

  scope :by_city, ->(city_ids) {
    joins(:user)
        .where(users: {city_id: city_ids})
  }
  scope :by_category, ->(category_ids) {
    joins(:category)
        .where(categories: {id: category_ids})
  }
  scope :by_title, ->(str) {where(arel_table[:name].matches("%#{str}%"))}

  def self.book_interval(term_start, term_end)
    item_table = Item.arel_table
    book_table = Book.arel_table
    bedbooks = Book.where(book_table[:start_booking].lt(term_end)
                              .and(book_table[:end_booking].gt(term_start)))
    self.where.not(item_table[:id].in(bedbooks.map(&:item_id)))
  end
end

class Quote < ApplicationRecord
  serialize :tags
  
  after_initialize do |quote|
    quote.tags = [] if quote.tags == nil
  end
  
  validates :title, presence: true, length: { minimum: 10 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: true
  validates :tags, presence: true, length: { minimum: 3, maximum: 20 }
end

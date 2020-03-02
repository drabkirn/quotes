class Quote < ApplicationRecord
  
  ## Tags are an array, so initialize them as array
  serialize :tags
  after_initialize do |quote|
    quote.tags = [] if quote.tags == nil
  end
  
  ## Validate titile, content, author and tags - self explanatory
  validates :title, presence: true, length: { minimum: 10 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: true
  validates :tags, presence: true, length: { minimum: 3, maximum: 20 }
end

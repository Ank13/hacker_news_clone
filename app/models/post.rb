class Post < ActiveRecord::Base
  has_many :comments
  has_many :post_votes
  belongs_to :user
  # validates :is_url_or_text_present 

  # def is_url_or_text_present
  #   if (self.url && self.text).nil?
  #     errors.add(:url, "or text is required.")
  #     errors.add(:text, "or url is required.")
  #   end
  # end

end

class Function < ActiveRecord::Base
  has_many :params
  belongs_to :categories
end

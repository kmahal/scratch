class Grade < ActiveRecord::Base
  extend FriendlyId
  friendly_id :gradelevel, use: :slugged
  belongs_to :user
  attr_accessible :English, :History, :Math, :Science, :gradelevel, :private, :slug, :user_id
end

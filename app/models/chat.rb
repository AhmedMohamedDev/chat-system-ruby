class Chat < ApplicationRecord
    belongs_to :application, optional: true#, counter_cache: true
    has_many :messages
  end
class Application < ApplicationRecord
    has_many :chats
    after_save :clear_cache

  def clear_cache
    $redis.del "applications"
  end
end

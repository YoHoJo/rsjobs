require 'open-uri'

class Post < ActiveRecord::Base
  belongs_to :user

  default_scope -> {order(created_at: :desc)}
  validates :category, presence: true
  validates :description, presence: true
  validates :rsn, length: {maximum: 20}

  def grab_stats(rsn)
    skills = %w'Overall Attack Defence Strength Hitpoints Ranged Prayer Magic Cooking Woodcutting Fletching Fishing Firemaking Crafting Smithing Mining Herblore Agility Thieving Slayer Farming Runecraft Hunter Construction BH_Rouge BH Hunter'
    hs_hash  = Hash.new
    url = "http://services.runescape.com/m=hiscore_oldschool/index_lite.ws?player=" + rsn
    file = open(url)
    hiscore_array = file.read.gsub!("\n", ',').split(',')
    hiscore_2d = hiscore_array.each_slice(3).to_a
    
    skills.each_with_index do |value, index|
      hs_hash[value] = hiscore_2d[index]
    end
    
    if hs_hash
        return hs_hash
    else
      return 'nil'
    end
  end

  def stats
    Rails.cache.fetch("#{cache_key}", expires_in: 24.hours) do
      grab_stats(self.rsn)
    end
  end
end

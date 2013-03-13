class Url < ActiveRecord::Base
  before_create :create_short_url

  def create_short_url
    url = [('a'..'z').to_a,(0..9).to_a].flatten.shuffle[0...4].join('')
    return self.short_url = url unless Url.where('short_url = ?', url).count > 0
    return create_short_url
  end
end

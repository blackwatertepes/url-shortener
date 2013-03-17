class Url < ActiveRecord::Base
  before_create :create_short_url

  validates :long_url, :format => { :with => /^[^\.][\w\.\-\/\:]{0,}\.\w{2,7}(\/|#|$)/,
    :message => "Please input a valid url."}

  def create_short_url
    id = 1
    id = Url.last.id + 1 if Url.last
    self.short_url = Url.obfuscate_id(id)
  end

  def self.string
    [('a'..'z').to_a, ('A'..'Z').to_a, (0..9).to_a, '$','-','_','.','+','!','*','(',')',',',"'"].flatten
  end

  def self.rand_char
    self.string.sample.to_s
  end

  def self.encode_id(id)
    div, mod = id.divmod(self.string.length)
    return self.string[div].to_s << self.string[mod].to_s if div < self.string.length
    self.encode_id(div) << self.string[mod].to_s
  end

  def self.obfuscate_id(id)
    self.encode_id(id) << self.rand_char
  end
end
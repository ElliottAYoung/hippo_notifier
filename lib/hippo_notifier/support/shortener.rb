class Shortener
  def self.short_url(url)
    url.present? && cut_url(url)
  end

  def self.cut_url(url)
    @url = Bitly.client.shorten(url) rescue nil
    @url.try(:short_url) || url
  end
end

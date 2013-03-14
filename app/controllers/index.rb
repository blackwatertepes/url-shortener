get '/' do
  @urls = Url.order("id DESC").limit(3)
  @url = Url.where('short_url = ?', params[:s]).first
  @error = params[:error]
  erb :index
end

post '/urls' do
  url = Url.new(:long_url => params[:url], :click_count => 0)
  if url.save
    redirect "/?s=#{url.short_url}"
  else
    redirect "/?error=Invalid URL"
  end
end

# e.g., /q6bda
get '/:short_url' do
  url = Url.where('short_url = ?', params[:short_url]).first
  url.click_count += 1
  url.save
  redirect format_url(url.long_url)
end

helpers do
  def format_url(url)
    return url if url.index(/(https?:\/\/)/)
    "http://#{url}"
  end
end

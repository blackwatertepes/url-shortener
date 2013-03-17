get '/' do
  @url = Url.find_by_short_url(params[:s])
  @error = params[:error]
  erb :index
end

post '/url' do
  url = Url.new(:long_url => params[:url], :click_count => 0)
  if url.save
    redirect "/?s=#{url.short_url}"
  else
    redirect "/?error=Invalid URL"
  end
end

get '/recent' do
  @urls = Url.order("id DESC").limit(20)
  erb :list
end

get '/popular' do
  @urls = Url.order("click_count DESC").limit(20)
  erb :list
end

get '/:short_url' do
  url = Url.find_by_short_url(params[:short_url])
  url.click_count += 1
  url.save
  redirect format_url(url.long_url)
end
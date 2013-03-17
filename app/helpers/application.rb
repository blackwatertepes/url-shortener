def format_url(url)
  return url if url.index(/(https?:\/\/)/)
  "http://#{url}"
end
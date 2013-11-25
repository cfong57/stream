module ApplicationHelper
  def control_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'control-group error'
    else
      content_tag :div, capture(&block), class: 'control-group'
    end
  end
end

def markdown(text)
  renderer = Redcarpet::Render::HTML.new
  extensions = {fenced_code_blocks: true}
  redcarpet = Redcarpet::Markdown.new(renderer, extensions)
  (redcarpet.render text).html_safe
end

def will_paginate(collection_or_options = nil, options = {})
  if collection_or_options.is_a? Hash
    options, collection_or_options = collection_or_options, nil
  end
  unless options[:renderer]
    options = options.merge :renderer => BootstrapLinkRenderer
  end
  super *[collection_or_options, options].compact
end

require 'uri'

def uri?
  URI(request.fullpath.to_s)
end

#uri = URI("http://foo.com/posts?id=30&limit=5#time=1305298413")
#=> #<URI::HTTP:0x00000000b14880
#      URL:http://foo.com/posts?id=30&limit=5#time=1305298413>
#uri.scheme
#=> "http"
#uri.host
#=> "foo.com"
#uri.path
#=> "/posts"
#uri.query
#=> "id=30&limit=5"
#uri.fragment
#=> "time=1305298413"
#uri.to_s
#=> "http://foo.com/posts?id=30&limit=5#time=1305298413"
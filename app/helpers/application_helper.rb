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

def sortable(column, title = nil)
  title ||= column.titleize
  direction = (column == sort_column) ? sort_direction : "asc"
  css_class = toggle_arrow(column)
  link_to title, {:sort => column, :direction => direction}, {:class => css_class}
end

def toggle_arrow(column)
  if(column == sort_column)
    css_class = (sort_direction == "asc") ? "asc sort-column" : "desc sort-column"
  else
    css_class = nil
  end
end
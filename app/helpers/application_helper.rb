module ApplicationHelper

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def meta_tag(descr)
    content_for :description, descr.to_s
  end

  def facebook_url(url)
    content_for :url, url.to_s
  end

end


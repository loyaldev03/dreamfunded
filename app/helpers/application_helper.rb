module ApplicationHelper

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def meta_tag(descr)
    content_for :description, descr.to_s
  end

  def facebook_og_title(name)
    content_for :og_title, name.to_s
  end

  def facebook_image(url)
    content_for :facebook_image, url
  end

  def facebook_secure_image(url)
    content_for :facebook_secure_image, url
  end

  def facebook_url(url)
    content_for :url, url.to_s
  end

  def dollar_format(value)
    number_with_precision(value, :precision => 2, :delimiter => ',')
  end

  def current_date
    Date.today.strftime("%b %e, %Y")
  end

  def date_format(date)
    date.strftime("%b %e, %Y")
  end

  def all_states
    [
      "Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"
    ]
  end

end


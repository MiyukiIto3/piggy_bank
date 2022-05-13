module ApplicationHelper
  BASE_TITLE = 'Piggy Bank'.freeze

  def page_full_title(page_title)
    page_title.blank? ? BASE_TITLE : "#{page_title} | #{BASE_TITLE}"
  end
end

module ApplicationHelper
  def full_title page_title = ""
    base_title = t("static_pages.about.name_book")
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end

module PostsHelper
  def links_to_subs(subs)
    if subs.empty?
      return "the Void"
    end
    subs.map do |sub|
      link_to sub.title, sub_url(sub)
    end.join(', ').html_safe
  end
end

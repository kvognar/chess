module ApplicationHelper
  
  def authentication_token
    token = <<-HTML
    <input
      type="hidden"
      name="authenticity_token"
      value="#{form_authenticity_token}"
    >
    HTML
    token.html_safe
  end
  
end

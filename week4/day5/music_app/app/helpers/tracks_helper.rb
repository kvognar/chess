module TracksHelper
  def ugly_lyrics(lyrics)
    html = "<pre>"
    html += lyrics.strip
                  .split("\n")
                  .map { |line| "&#9835 #{h(line)}" }
                  .join("\n")
    html += "</pre>"
    html.html_safe
  end
end

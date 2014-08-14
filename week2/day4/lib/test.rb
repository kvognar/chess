require 'dispel'

# draw app and redraw after each keystroke
Dispel::Screen.open(:colors => true) do |screen|
  map = Dispel::StyleMap.new(3) # number of lines
  map.add(:reverse, 0, 1..5)    # :normal / :reverse / color, line, characters
  map.add(["#aa0000", "#00aa00"], 0, 5..8) # foreground red, background green

  screen.draw "Shiny Rainbows!\nDefault\nand more!", map, [0,3] # text, styles, cursor position

  Dispel::Keyboard.output { break }
end
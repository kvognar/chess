# encoding: utf-8

require 'tk'
require './board.rb'

board = Board.new

root = TkRoot.new { title "Chess" }
TkLabel.new(root) do
  text "Chess v. beta"
  pack { padx 15 ; pady 15; side 'left' }
end

text = TkLabel.new do
  text "Good morning"
  # command { puts "Good evening" }
  pack
end

board_gui = TkFrame.new do
  
end
  



TkButton.new(root) do
  text "♘" 
  command { puts "knight" }
  height 15
  width 15
  pack
end
Tk.mainloop
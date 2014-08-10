require 'set'

class WordChainer
  
  def initialize(dictionary_file_name = "dictionary.txt")
    @dictionary = load_dictionary(dictionary_file_name)
    
  end
  
  def adjacent_words(word)
    @dictionary.select do |other_word| 
      word.length == other_word.length &&
      off_by_one(word, other_word)
    end
  end
      
  def off_by_one(word, other_word)
    total = 0
    word.length.times do |i|
      total += 1 unless word[i] == other_word[i]
    end
    total == 1
  end
    
  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source  => nil }
    
    until @current_words.empty? or @all_seen_words.include?(target)
      new_current_words = explore_current_words
      @current_words = new_current_words
    end
    puts build_path(target)
  end
  
  def explore_current_words
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        unless @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end
      end
    end
   new_current_words.each { |word| puts "#{word} || #{@all_seen_words[word]}"}
   new_current_words
  end
  
  def build_path(target)
    path = [target]
    until path.last.nil?
      path << @all_seen_words[path.last]
    end
    path
  end
  
  
  private
  
  def load_dictionary(file_name)
    Set.new(File.readlines(file_name).map(&:chomp))
  end
  
end



chainer = WordChainer.new
chainer.run("crowd", "trash")
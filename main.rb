$words = []
File.foreach("google-10000-english-no-swears.txt") |line|
if line.length > 4 and line.length < 13
  words.push(line)
end

class Game 
  def initialize
    @secret_word = $words.sample
    @secret_array = @secret_word.split("")
    @guesses = 10
    @wrong = ""
    @canvas = "" 
    @secret_word.length.times do
      @canvas += "_"
    end
  end
  def turn 
    self.request_letter
    @secret_array.each_wih_index do |a,i|
      if @letter == a
        @canvas[i] = @letter
      else 
        @wrong += @letter
      end
    end
    self.display
    @guesses -+ 1
  end
  def display
    puts @canvas
    
  end
  def request_letter
    input = gets.chomp
    @letter = input
  end
  def start
    while @guesses > 0
      self.turn
      if @canvas == @secret_word
        puts "You have guessed the word!"
      end
    end
    puts "You ran out of guesses :("
  end
  def save_game
    File.open('saved_game.yml', 'w') { |f| YAML.dump([] << self, f) }
    puts 'Game Saved!'
  end

  def load_game
    yaml = YAML.load_file('./saved_game.yml')
    @word = yaml[0].word
    @arr = yaml[0].arr
    @incorrect_letters = yaml[0].incorrect_letters
    @mistakes = yaml[0].mistakes
    puts 'Save Loaded!'
  end
end
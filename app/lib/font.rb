# this is only for the very specific png font file. and should not be used anywhere else.
# until this is expanded to work with any font.png file
class Font
	def self.draw_letter letter
		@@letter = {}
	10.map_with_index do |i|
		@@letter["#{i}"] = [i * 12, 0, 12, 20]
	end
	@@letter["?"] = [10 * 12, 0, 12, 20]
		return [12, 20, "img/numbers.png", 0, 255, 255, 255, 255, *@@letter[letter]]
	end
end
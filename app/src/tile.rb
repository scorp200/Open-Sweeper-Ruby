class Tile
	attr_accessor :isBomb
	attr_reader :color, :index, :size, :count, :revealed

	def initialize index, size
		@index = index
		@isBomb = false
		@count = -1
		@label = ""
		@revealed = false
		@color = [165, 214, 167, 255]
		@size = size
		@padding = ~~(size * 0.1)
	end

	def set_market
		return if @count >= 0
		@label = "?"
	end

	def set_revealed
		return if @revealed
		@color = [77, 208, 225, 225]
		@color = [245, 127, 23, 225] if @isBomb
		@revealed = true
	end

	def count_bombs grid
		return if @isBomb || @count >= 0
		@count = 0

		3.map_with_index do |x|
			3.map_with_index do |y|
				nx = @index.x + x - 1
				ny = @index.y + y - 1
				next if nx < 0 || nx >= grid.width || ny < 0 || ny >= grid.height

				tile = grid.get_tile nx, ny

				@count += 1 if tile.isBomb
			end
		end

		reveal_neighbors grid if @count == 0
		@label = "#{@count}" if count > 0

		return @count
	end

	def reveal_neighbors grid
		3.map_with_index do |x|
			3.map_with_index do |y|
				nx = @index.x + x - 1
				ny = @index.y + y - 1
				next if nx < 0 || nx >= grid.width || ny < 0 || ny >= grid.height

				tile = grid.get_tile nx, ny

				next if tile == self
				return if tile.isBomb

				grid.que tile
			end
		end
	end

	def render outputs
		# outputs.solids << [*@index.mult(@size), @size, @size]
		outputs.sprites << [*@index.mult(@size).add(@padding), @size - @padding, @size - @padding, "img/tile.png",0 , *@color]
		#outputs.labels << [@index.x + @size / 2, @index.y + @size, "#{@index.x}, #{@index.y}", -2, 1, 255, 255, 255, 255]
		#outputs.labels << [*@index.mult(@size).add([@size/2, @size]), @label, 1, 1, 255, 255, 255, 255] if @label != ""
		outputs.sprites << [*@index.mult(@size).add([@size/2, @size]).sub([4, 24]), *Font.draw_letter(@label)] if @label != ""
	end

	def to_s
		["index #{@index}",
		"isBomb #{@isBomb}",
		"count #{@count}",
		"label #{@label}",
		"revealed #{@revealed}",
		"color #{@color}",
		"size #{@size}",
		"padding #{@padding}"]
	end
end
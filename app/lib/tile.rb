class Tile
	attr_accessor :isBomb, :position, :count, :revealed
	attr_reader :color

	def initialize tiles, que, width, height, size
		@tiles = tiles
		@que = que
		@width = width
		@height = height
		@isBomb = false
		@count = -1
		@label = ""
		@revealed = false
		@color = [165, 214, 167, 255]
		@size = size
		@padding = ~~(@size * 0.1)
	end

	def setMarked
		return if @count >= 0
		@label = "?"
	end

	def setRevealed
		return if @revealed
		@color = [77, 208, 225, 225]
		@color = [245, 127, 23, 225] if @isBomb
		@revealed = true
	end

	def countBombs cx, cy
		return if @isBomb || @count >= 0
		@count = 0

		3.map_with_index do |x|
			3.map_with_index do |y|
				nx = cx + x - 1
				ny = cy + y - 1

				next if nx < 0 || nx >= @width || ny < 0 || ny >= @height

				i = ny * @width + nx
				@count += 1 if i >= 0 && i < @tiles.size && @tiles[i].isBomb
			end
		end

		revealNeighbors cx, cy if @count == 0
		@label = "#{@count}" if count > 0

		return @count
	end

	def revealNeighbors cx, cy
		3.map_with_index do |x|
			3.map_with_index do |y|
				next if x == y

				ny = cy + y - 1
				nx = cx + x - 1
				next if nx < 0 || nx >= @width || ny < 0 || ny >= @height

				i = ny * @width + nx
				next if i < 0 || i >= @tiles.size

				tile = @tiles[i]

				return if tile.isBomb
				@que.append [nx, ny, tile]
			end
		end
	end

	def render outputs
		outputs.solids << [*@position, @size, @size]
		outputs.solids << [@position.x + @padding, @position.y + @padding, @size - @padding, @size - @padding, *@color]
		outputs.labels << [@position.x + @size / 2, @position.y + @size, @label, 1, 1, 255, 255, 255, 255]
	end
end
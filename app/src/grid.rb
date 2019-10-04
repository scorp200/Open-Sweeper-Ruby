class Grid
	attr_reader :size, :width, :height
	def initialize width, height, size, bombs
		@size = size
		@width = width
		@height = height
		@tiles = {}
		@que = []

		@ready = false
		@bombs = bombs

		width.map_with_index do |x|
			height.map_with_index do |y|
				@tiles[x] ||= {}
				@tiles[x][y] = Tile.new [x, y], size
			end
		end
	end

	def get_tile x, y
		return nil if x < 0 || x >= @width || y < 0 || y >= @height
		return @tiles[x][y]
	end

	def place_bombs tile
		@bombs.map_with_index do |i|
			nTile = tile
			while nTile == tile || nTile.isBomb do
				nTile = get_tile(rand(@width), rand(@height))
			end
			nTile.isBomb = true
		end
	end

	def que tile
		@que << tile
	end

	def update state
		if @que.size > 0
			@que.map do |d|
				d.set_revealed
				d.count_bombs self
				@que.delete d
			end
		end
	end

	def input state, inputs
		if inputs.mouse.last_button == :left
			pos = inputs.mouse.local_position
			zoom = state.camera.zoom
			x = ~~(pos.x / (@size * zoom || 1))
			y = ~~(pos.y / (@size * zoom || 1))
			tile = get_tile x, y
			return if tile.nil?

			if !@ready
				place_bombs tile
				@ready = true
			end

			tile.set_revealed
			tile.count_bombs self
		elsif inputs.mouse.last_button == :right
			pos = inputs.mouse.local_position
			zoom = state.camera.zoom
			x = ~~(pos.x / (@size * zoom || 1))
			y = ~~(pos.y / (@size * zoom || 1))
			tile = get_tile x, y
			return if tile.nil?

			tile.set_market
		end
	end

	def render outputs
		@width.map_with_index do |x|
			@height.map_with_index do |y|
				get_tile(x, y).render outputs
			end
		end
	end
end
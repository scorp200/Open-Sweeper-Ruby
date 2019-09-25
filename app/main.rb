require "app/lib/tile.rb"

def tick args
	defaults args.state
	render args.state, args.outputs
	input args.state, args.inputs
	update args.state
end

def update state
	if state.que.size > 0
		state.que.map do |d|
			d[2].setRevealed
			d[2].countBombs d.x, d.y
			state.que.delete d
		end
		return
	end
end

def render state, outputs
	outputs.solids << [0, 0, 1280, 720, 0, 0, 0, 255]
	state.tiles.map do |tile|
		tile.render outputs
	end
end

def input state, inputs
	if inputs.mouse.click
		pos = inputs.mouse.position
		x = ~~(pos.x / state.size)
		y = ~~(pos.y / state.size)

		if x >= 0 && x < state.width && y >= 0 && y < state.height
			i = x * state.height + y
			if state.firstTouch
				state.bombs.map_with_index do |d|
					index = rand state.tiles.size
					while state.tiles[index].isBomb || index == i do
						index = rand state.tiles.size
					end
					state.tiles[index].isBomb = true
				end
				state.firstTouch = false
			end

			state.tiles[i].setRevealed
			state.tiles[i].countBombs x, y
		end
	end
end

def defaults state
	state.bombs ||= 30
	state.firstTouch ||= true
	state.tiles ||= []
	state.que ||= []
	state.width ||= 20
	state.height ||= 20
	state.size = 30
	state.wSize = state.size * state.width
	state.hSize = state.size * state.height
	state.ready ||= false

	if !state.ready
		state.width.map_with_index do |x|
			state.height.map_with_index do |y|
				i = x * state.height + y
				tile = Tile.new state.tiles, state.que, state.width, state.height, state.size
				tile.position = [x * state.size, y * state.size]
				state.tiles.append tile
			end
		end
		puts state.tiles.size
		state.ready = true
	end
end

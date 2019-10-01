require "app/lib/doge_array.rb"
require "app/lib/utils.rb"
require "app/lib/camera.rb"
require "app/src/tile.rb"
require "app/src/grid.rb"

# $gtk.log = :off

def tick args
	defaults args.state
	render args.state, args.outputs
	input args.state, args.inputs
	update args.state
end

def update state
	state.grid.update state
end

def render state, outputs
	outputs.solids << [*state.camera.position, 1280, 720, 0, 0, 0, 255]
	state.grid.render outputs
end

def input state, inputs
	state.grid.input inputs
end

def defaults state
	state.grid ||= Grid.new 20, 20, 30, 30
	state.camera ||= Camera.new [-360, -90], 2
end

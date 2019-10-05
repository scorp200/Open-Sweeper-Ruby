require "app/lib/doge_tick.rb"
require "app/lib/doge_array.rb"
require "app/lib/doge_mouse.rb"
require "app/lib/utils.rb"
require "app/lib/doge_camera.rb"
require "app/lib/font.rb"

require "app/src/tile.rb"
require "app/src/grid.rb"

# $gtk.log = :off

def tick args
	defaults args.state
	input args.state, args.inputs
	update args.state
	render args.state, args.outputs
end

def update state
	state.grid.update state
end

def render state, outputs
	outputs.solids << state.bg
	state.grid.render outputs
	outputs.labels << [100,600, "#{~~$gtk.current_framerate}",1, 1, 255, 255, 255, 255]
end

def input state, inputs
	if inputs.mouse.dragging
		state.camera.position.add! inputs.mouse.dragging_dist.div(state.camera.zoom)
	elsif inputs.mouse.button_up
		state.grid.input state, inputs
	end

	if inputs.keyboard.key_down.up
		state.camera.zoom += 0.1
	elsif inputs.keyboard.key_down.down
		state.camera.zoom -= 0.1
	end
end

def defaults state
	state.grid ||= Grid.new 20, 20, 30, 30
	state.camera ||= Camera.new [0, 0], 1
	state.bg ||= state.camera.add_ignore([0, 0, 1280, 720, 0, 0, 0, 255])
end

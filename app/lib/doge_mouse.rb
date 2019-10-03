# Requires:
# doge_tick.rb
# doge_array.rb

# Usage:
# do "if mouse.dragging" to check if dragging initiated
# do "if mouse.button_up" to get mouse up when not dragging
# use mouse.dragging_dist to get how far mouse moved since last frame

# Credit:
# By Anton K. (ai Doge) https://aidoge.net
module GTK
	class Mouse
		attr_accessor :dragging, :dragging_dist, :previous_position, :button_up
	end
end

DogeTick.pre["doge_mouse_pre"] = -> args {
	mouse = args[:args].inputs.mouse
	if mouse.click
		mouse.previous_position = mouse.position
		@timer = 0
	end
	if mouse.down
		@held = true
		mouse.button_up = false
	elsif mouse.up
		mouse.button_up = true if @timer < 10 && !mouse.dragging
		@held = false
		mouse.dragging = false
	end
	if @held && !mouse.click
		@timer += 1
		mouse.dragging = true if @timer >= 10 || mouse.previous_position.dist_squared(mouse.position) > 100
	end
	if mouse.dragging || mouse.button_right
		mouse.dragging_dist = mouse.previous_position.sub mouse.position
		mouse.previous_position = mouse.position
	end
}
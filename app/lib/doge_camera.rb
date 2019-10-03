# Requires:
# doge_array.rb
# doge_tick.rb

# Usage:
# initialize the camera with position and zoom
# For mouse position use mouse.local_position
# When using scale variables multiply them by camera.zoom
# To scale mouse.dragging_dist divide it by camera.zoom

# Credit:
# By Anton K. (ai Doge) https://aidoge.net
class Camera
	attr_accessor :position, :zoom

	def initialize position = [0, 0], zoom = 1
		@position = position
		@zoom = zoom
		DogeTick.post["doge_camera_post"] = -> args { render args[:args] }
		DogeTick.pre["doge_camera_pre"] = -> args { input args[:args] }
		@ignore = {}
	end

	def render args
		args.outputs.solids.each do |d|
			next if @ignore[d]
			d.sub!(@position)
			d.mult!([@zoom] * 4)
		end if args.outputs.solids.size > 0
		args.outputs.labels.each do |d|
			d.sub!(@position)
			d.mult!([@zoom] * 2)
		end if args.outputs.labels.size > 0
	end

	def input args
		pos = args.inputs.mouse.position
		args.inputs.mouse.local_position = pos.add(@position.mult(@zoom))
	end

	def add_ignore obj
		@ignore[obj] = true
		return obj
	end

end

#===CLASSIFIED===
module GTK
	class Mouse
		attr_accessor :local_position
	end
end
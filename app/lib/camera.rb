# Requires: doge_arrays.rb
# Whenever you use a scaling variable multiply it by inputs.zoom or state.camera.zoom
# EXCEPT when adding to outputs it is done automatically
class Camera
	attr_accessor :position, :zoom

	def initialize position, zoom
		@position = position
		@zoom = zoom
	end

	def render args
		args.outputs.solids.map do |d|
			d.sub!(@position)
			d.mult!([@zoom] * 4)
		end if args.outputs.solids.size > 0
		args.outputs.labels.map do |d|
			d.sub!(@position)
			d.mult!([@zoom] * 2)
		end if args.outputs.labels.size > 0
	end

	def input args
		args.inputs.zoom = @zoom
		args.inputs.mouse.set_camera self
		pos = args.inputs.mouse.__original_position__
		args.inputs.mouse.position = pos.add(@position.mult(@zoom))
	end
end

#===CLASSIFIED===
module GTK
	class Runtime
		alias_method :__original_tick_core__, :tick_core unless Runtime.instance_methods.include?(:__original_tick_core__)
		def tick_core
			@args.state.camera.input @args if @args.state.camera != nil
			__original_tick_core__
			@args.state.camera.render @args if @args.state.camera != nil
		end
	end
	class Mouse
		alias_method :__original_position__, :position unless Mouse.instance_methods.include?(:__original_position__)
		def position
			return __original_position__ if @camera == nil
			return [*@__position__]
		end
		def position= array
			@__position__ = array
		end
		def set_camera camera
			@camera ||= camera
		end
	end
	class Inputs
		attr_accessor :zoom
	end
end
# Register an action to execute before or after tick

# Usage:
# After tick:
# DogeTick.post["action_name"] = -> args {
# 	args = args[:args]
# 	# Your action goes here
# }
# Before tick:
# DogeTick.pre["action_name"] = -> args {
# 	args = args[:args]
# 	# Your action goes here
# }

# Credit:
# By Anton K. (ai Doge) https://aidoge.net
class DogeTick
	def self.pre
		@@__pre__ ||= {}
		return @@__pre__
	end
	def self.post
		@@__post__ ||= {}
		return @@__post__
	end
end

module GTK
	class Runtime
		alias_method :__original_tick_core__, :tick_core unless Runtime.instance_methods.include?(:__original_tick_core__)
		def tick_core
			DogeTick.pre.each { |key, d| d.call args: @args }
			__original_tick_core__
			DogeTick.post.each { |key, d| d.call args: @args }
		end
	end
end
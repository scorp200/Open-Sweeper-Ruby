# Doge array extensions

# Credit:
# By Anton K. (ai Doge) https://aidoge.net
class Array
	#Modify self
	def add! array
		if array.is_a? Array
			self.size.lesser(array.size).map_with_index do |i|
				self[i] += array[i]
			end
		else
			self.map do |d|
				d += array
			end
		end
	end
	def sub! array
		if array.is_a? Array
			self.size.lesser(array.size).map_with_index do |i|
				self[i] -= array[i]
			end
		else
			self.map do |d|
				d -= array
			end
		end
	end
	def mult! array
		if array.is_a? Array
			self.size.lesser(array.size).map_with_index do |i|
				self[i] *= array[i]
			end
		else
			self.map do |d|
				d *= array
			end
		end
	end
	def div! array
		if array.is_a? Array
			self.size.lesser(array.size).map_with_index do |i|
				self[i] /= array[i]
			end
		else
			self.map do |d|
				d /= array
			end
		end
	end

	#Modify and return a new array
	def add array
		if array.is_a? Array
			return self.size.lesser(array.size).map_with_index do |i|
				self[i] + array[i]
			end
		else
			return self.map do |d|
				d + array
			end
		end
	end
	def sub array
		if array.is_a? Array
			return self.size.lesser(array.size).map_with_index do |i|
				self[i] - array[i]
			end
		else
			return self.map do |d|
				d - array
			end
		end
	end
	def mult array
		if array.is_a? Array
			return self.size.lesser(array.size).map_with_index do |i|
				self[i] * array[i]
			end
		else
			return self.map do |d|
				d * array
			end
		end
	end
	def div array
		if array.is_a? Array
			return self.size.lesser(array.size).map_with_index do |i|
				self[i] / array[i]
			end
		else
			return self.map do |d|
				d / array
			end
		end
	end

	def dist_squared array
		x = self.x - array.x
		y = self.y - array.y
		return x * x + y * y
	end
end
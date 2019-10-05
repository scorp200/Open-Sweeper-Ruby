# Doge array extensions

# Credit:
# By Anton K. (ai Doge) https://aidoge.net
class Array
	#Modify self
	def add! array
		i = 0
		if array.is_a? Array
			while i < self.size && i < array.size do
				self[i] += array[i]
				i += 1
			end
		else
			while i < self.size do
				self[i] += array
				i += 1
			end
		end
	end
	def sub! array
		i = 0
		if array.is_a? Array
			while i < self.size && i < array.size do
				self[i] -= array[i]
				i += 1
			end
		else
			while i < self.size do
				self[i] -= array
				i += 1
			end
		end
	end
	def mult! array
		i = 0
		if array.is_a? Array

			while i < self.size && i < array.size do
				self[i] *= array[i]
				i += 1
			end
		else
			while i < self.size do
				self[i] *= array
				i += 1
			end
		end
	end
	def div! array
		i = 0
		if array.is_a? Array
			while i < self.size && i < array.size do
				self[i] /= array[i]
				i += 1
			end
		else
			while i < self.size do
				self[i] /= array
				i += 1
			end
		end
	end

	#Modify and return a new array
	def add array
		i = 0
		arr = []
		if array.is_a? Array
			while i < self.size && i < array.size do
				arr << self[i] + array[i]
				i += 1
			end
		else
			while i < self.size do
				arr << self[i] + array
				i += 1
			end
		end
		return arr
	end
	def sub array
		i = 0
		arr = []
		if array.is_a? Array
			while i < self.size && i < array.size do
				arr << self[i] - array[i]
				i += 1
			end
		else
			while i < self.size do
				arr << self[i] - array
				i += 1
			end
		end
		return arr
	end
	def mult array
		i = 0
		arr = []
		if array.is_a? Array
			while i < self.size && i < array.size do
				arr << self[i] * array[i]
				i += 1
			end
		else
			while i < self.size do
				arr << self[i] * array
				i += 1
			end
		end
		return arr
	end
	def div array
		i = 0
		arr = []
		if array.is_a? Array
			while i < self.size && i < array.size do
				arr << self[i] / array[i]
				i += 1
			end
		else
			while i < self.size do
				arr << self[i] / array
				i += 1
			end
		end
		return arr
	end

	def dist_squared array
		x = self.x - array.x
		y = self.y - array.y
		return x * x + y * y
	end
end
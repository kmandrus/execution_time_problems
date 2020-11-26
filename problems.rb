#Given a list of integers find the smallest number in the list.
#O(n^2) and O(n) time implementations
def my_slow_min(list)
    list.each_with_index do |base_num|
        return base_num if list.all? { |num| base_num <= num }
    end
end

def my_fast_min(list)
    min = list.first
    list.each do |item|
        min = item if item < min
    end
    min
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
p my_slow_min(list)  # =>  -5
p my_fast_min(list)  # =>  -5 

#You have an array of integers and you want to find the largest contiguous 
#(together in sequence) sub-sum. Find the sums of all contiguous sub-arrays 
#and return the max.
list_1 = [5, 3, -7] # => 8
list_2 = [2, 3, -6, 7, -6, 7] # => 8
list_3 = [-5, -1, -3] #=> -1

    #Phase I
#Write a function that iterates through the array and finds all sub-arrays 
#using nested loops. First make an array to hold all sub-arrays. Then find the 
#sums of each sub-array and return the max.

def slow_largest_contiguous_subsum(list)
    sub_arrays = []
    list.each_with_index do |start_num, start_i|
        list.each_with_index do |end_num, end_i|
            sub_arrays << list[start_i..end_i] if end_i >= start_i
        end
    end
    max = sub_arrays.first.sum
    sub_arrays.each { |array| max = array.sum if array.sum > max}
    max
end
p slow_largest_contiguous_subsum(list_1) #  => 8
p slow_largest_contiguous_subsum(list_2) #  => 8
p slow_largest_contiguous_subsum(list_3) #  => -1
#Discuss the time complexity of this solution.
    #The sub_arrays are the dominant factor in this solution. Because of the
    #nested loops, they run in O(n^2) time. Finding the max is also, I'm fairly
    #certain, O(n^2) time as well because of the implict nested loop in adding
    #up the terms of each sub-array.

    #Phase II
#Let's make a better version. Write a new function using O(n) time with O(1) 
#memory. Keep a running tally of the largest sum. To accomplish this efficient 
#space complexity, consider using two variables. One variable should track the 
#largest sum so far and another to track the current sum. We'll leave the rest 
#to you.
def fast_largest_contiguous_subsum(list)
    max_sum = list.first
    current_sum = list.first
    i = 1
    start_index = 0
    while i < list.length do
        start_val = list[start_index]
        current_val = list[i]
        if start_val.negative?
            if current_val > start_val
                start_val = current_val
                start_index = i
                max_sum = start_val
            end
        else
            current_sum += current_val
            if current_sum.negative?
                start_index = i + 1
                current_sum = 0
            end
            max_sum = current_sum if current_sum > max_sum
        end
        i += 1
    end
    max_sum
end
p fast_largest_contiguous_subsum(list_1) #  => 8
p fast_largest_contiguous_subsum(list_2) #  => 8
p fast_largest_contiguous_subsum(list_3) #  => -1

#Get your story straight, and then explain your solution's time complexity to your TA.
    
    #This solution runs in linear time and constant space. The latter is easier
    #to show: it only assigns literal values to a maximum of six variables
    #within a single loop. The former is a bit more complex. As already noted,
    #there is a single loop, putting us at a minimum of linear time. In
    #addition, each iteration of the loop manipulates a single value from the
    #array with only addition, assignments, or comparisons. Thus, each of those
    #operations only adds constant time to the algorithm. So, we are at linear
    #time. 
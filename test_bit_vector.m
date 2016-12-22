function [bit_vector_full] = test_bit_vector(vector_size)
%Make a test bit vector.
%   Here it is not composed of 0 and 1, easier to see resluts for tests

for i = 1:vector_size
    bit_vector_full(i)=i; 
end

end


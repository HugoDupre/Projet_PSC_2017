function [interleaved_vector] = interleaver()

vecteur_size=100;

test_vector_bit = test_bit_vector(vecteur_size);

symbole_size = 5;

%----------------------------------------------------%
%Creation of the interleaver table (2-dim vector)

for vect_bits_index = 1:vecteur_size
    %interleaver(line, column)
    %Here are the index of the vector in the interleaver (symbole_size = 5) :
    %1 2 3 4 5
    %6 7 8 9 10
    %11 ..
    [Q,R] = quorem(sym(vect_bits_index-1), sym(5));
    interleaver_table(Q+1, R+1)=test_vector_bit(vect_bits_index);
end
interleaver_table

%---------------------------------------------%
%-create 1-dim interleaved vector (symbole_size = 5) : 1 6 11 16... 

[nb_i_t_row, nb_i_t_column] = size(interleaver_table);

i_vect_index = 1;
for i_t_column = 1:nb_i_t_column
    for i_t_row = 1:nb_i_t_row
        interleaved_vector(i_vect_index) = interleaver_table(i_t_row, i_t_column);
        i_vect_index = i_vect_index + 1;
    end
end

interleaved_vector

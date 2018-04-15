function [ newWord ] = shear_online_word_horizontally( Word , angle_in_degrees )

    newWord = Word;
    
    angle = angle_in_degrees*pi/180;
    shear_factor = cot(pi/2 - angle);
    
    shear_matrix = [ 1  shear_factor ;
                     0     1  ];

    XY = [Word.X Word.Y]';
    new_XY = [shear_matrix*XY]';
    
    newWord.X = new_XY(:,1);
    newWord.Y = new_XY(:,2); 

end
function [ points_inside_ratio ] = compute_percentage_of_word_between_bounds( Stroke , Xmin , Xmax , Ymin , Ymax )

    if( nargin < 4 )
        Ymin = -Inf;
    end
    if( nargin < 5 )
        Ymax = Inf;
    end

    points_inside_ratio = length( find( Stroke.X >= Xmin & Stroke.X <= Xmax & Stroke.Y >= Ymin & Stroke.Y <= Ymax ) ) / Stroke.NumSamples;


end
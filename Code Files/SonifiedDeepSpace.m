clc; clear;

% Read image
img = imread('Hubble-Massive-Panorama.png');
% Convert image to binary
blackImg = imbinarize(rgb2gray(img));

i = 1;
y = zeros(1024, 900);

% For all coloumns
while( i <= 1024 )
    j = 1;
    % For all parts
    while( j <= 10 )
        k = 1;
        % For all rows in part
        while( k <= 90 )
            rowIndex = 90 * (j-1) + k;
            isWhite = blackImg(rowIndex, i);
            % If not black fill appropriate spectra
            if( isWhite )
                y(i, 901-rowIndex) = j;
            end
            k = k + 1;
        end
        j = j + 1;
    end
    i = i + 1;
end

Z = zeros(900*1024, 1);
i = 1;
while( i<= 1024)
    temp = ifft(y(i,:), 'symmetric');
    j = 1;
    while(j <= 900)
        Z(900*(i-1) + j) = temp(j);
        j = j + 1;
    end
    i = i + 1;
end

% Construct .waw file
audiowrite('deepspace.wav', Z, 900);
% Play the sound
sound(Z, 1000);

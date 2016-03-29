function [Dados] = ReadData(nomeFich)

fileID = fopen(nomeFich,'r');
A=textscan(fileID, '%f %f %f %f %f %f %f %f %f %f %f %f ','Delimiter',',');

fclose(fileID);
Dados=cell2mat(A);

end


function [Dados] = leDados(nomeFich)

fileID = fopen(nomeFich,'r');
A=textscan(fileID, '%30f ','Delimiter',',');

fclose(fileID);
A=A{1,1};
Dados= reshape(A,[],12);
end


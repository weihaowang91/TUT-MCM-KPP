%Opening the MCM-file
fid = fopen('mcm_subset.kpp', 'r');
%Reading the lines into an array
s = textscan(fid, '%s', 'delimiter', '\n');
fclose(fid);

%Replace Fortran-expressions with Matlab-expressions
s{1,1} = strrep(s{1,1}, 'F90', 'MATLAB');
s{1,1} = strrep(s{1,1}, 'REAL(dp)::M, N2, O2, RO2, H2O', 'global N2 O2 RO2');
s{1,1} = strrep(s{1,1}, 'CALL mcm_constants(time, temp, M, N2, O2, RO2, H2O)',...
    'mcm_constants(TEMP, M, H2O);');
s{1,1} = strrep(s{1,1}, '& ', '...');
idx =  strfind(s{1,1}, ' mcm_constants');
t = find(~cellfun(@isempty,idx),1);


s{1,1} = strrep(s{1,1}, '**', '^');
s{1,1} = strrep(s{1,1}, 'EXP', 'exp');
s{1,1} = strrep(s{1,1}, 'D+', 'E+');
s{1,1} = strrep(s{1,1}, 'D-', 'E-');

%Replace empty products with dummy product
idx2 =  strfind(s{1,1}, ' = IGNORE');
first = find(~cellfun(@isempty,idx2),1);
s{1,1}{first-1} = 'DUMMY = IGNORE ;';

s{1,1} = strrep(s{1,1}, '= :', ' = DUMMY :');

%Insert global declarations
s{1,1} = strrep(s{1,1}, 'USE constants', ' global M N2 O2 RO2 H2O C');
s{1,1} = strrep(s{1,1}, '!end of USE statements ', ' global KRO2NO KRO2HO2 KAPHO2 KCH3O2 KAPNO KRO2NO3 KNO3AL KDEC K298CH3O2');
s{1,1} = strrep(s{1,1}, '! start of executable statements', ' KMT12 KMT13 KMT14 KMT15 KMT16 KMT17 KMT18 KFPAN KBPAN KROPRIM KROSEC');
s{1,1} = strrep(s{1,1}, '!', ' global KMT01 KMT02 KMT03 KMT04 KMT05 KMT06 KMT07 KMT08 KMT09 KMT10 KMT11...');

%Add global declarations for RO2 species
matches = regexp(s{1,1}(:),'^.*ind.*$','match');
matches = [matches{:}];
matches = strrep(matches, 'C(', '');
matches = strrep(matches, '+ ', '');
matches = strrep(matches, ')', '');
matches(1) = strcat({' '},'global',{' '},matches(1));
matches(2:end)=strcat({' '},matches(2:end));
[col, row] = size(matches);

idx3 =strfind(s{1,1},' global M N2 O2 RO2 H2O C');
g = find(~cellfun(@isempty,idx3));
s{1,1}(g+row:end+row,:) = s{1,1}(g:end,:);
s{1,1}(g+1:g+row) = matches;


%Overwrite the original MCM-file
fid = fopen('mcm_subset.kpp', 'w');
[nrows,ncols] = size(s{1,1});
for row = 1:nrows
    fprintf(fid,'%s\n',s{1,1}{row,:});
end
fclose(fid);
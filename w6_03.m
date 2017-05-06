%Q6
clear
txt = 'ding yaleissssssssssssssssssssssssssssssssssssssssssssssssssssssssssss' ;

% converting into a binary string, the least significant bit first on the
% lefthand side
txt_bb = fliplr(dec2bin(uint8(txt),8))';  % one binary character per column
txt_bc = txt_bb(:)' ;         % the final string as  0, 1 characters
txt_b = uint8(txt_bc - '0') ; % the final string as  0, 1 uint8 numbers

n = numel(txt_b) ; %  number of bits in txt  
n = 4 * 127;
% Scrambling with the seed scr The initial sequence scr_ini should be produced from the seven least significant digits of 
% your student ID number.
ID = [8 1 9 9 0 1 4];

scr_ini = ID - mean(ID);
%scr = uint8([1 1 1 1 1 1 1]) ; % the scrambler seed
scr = scr_ini;

txt_Scr = zeros(1,n, 'uint8') ;  % the scarambled sequence

s = zeros(1, n, 'uint8') ;       %  the n-bit scrambling sequence
for k = 1 : n  
    s(k) = xor(scr(1), scr(4)) ;          % big-small     x0 = x4 ? x7                                    
    txt_Scr(k) = xor(txt_b(k), s(k)) ;
    scr = [scr(2:7) s(k)] ;  % the last 7 bits of the scrambling sequence
end
%   resulting s        is an n-bit scrambling sequence
%   resulting txt_Scr  is an n-bit scrambled  sequence

scrSq = reshape(s, 127, 4);

% Q7
% a) 
msg = '<ding yalei><ydin0002@student.monash.edu>';
a = ('4B19DFA5');
b = dec2hex(msg);
b = b(:)';
msgF = [b, a];
%  scrambled message  msgF_scr 
% convert msgF  hex to bin
[ta, tb] = size(msgF);
msgF_t = zeros(1, 4 * tb);

for i = 1:tb
    h2b = dec2bin(hex2dec(msgF(i)), 4);
    for j = 1: 4
        msgF_t(1, (i - 1) * 4 + j) = h2b(j) - '0';
    end
end

msgF_bc = msgF_t(:)';
msgF_b = uint8(msgF_bc);

n = numel(msgF_b);

msgF_Scr = zeros(1, n, 'uint8');

% b) scrambling sequence  scr.  is calued in the next loop
s = zeros(1, n, 'uint8') ;       %  the n-bit scrambling sequence
for k = 1 : n  
    s(k) = xor(scr(1), scr(4)) ;          % big-small     x0 = x4 ? x7                                    
    msgF_Scr(k) = xor(msgF_b(k), s(k)) ;
    scr = [scr(2:7) s(k)] ;  % the last 7 bits of the scrambling sequence
end



% c)
% descramble
msgF_dScr = uint8(xor(msgF_Scr, s)) ;
% sum = 0, screamble and deacrambled;
sum = sum(msgF_dScr - msgF_b); 


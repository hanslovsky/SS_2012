% login: pr12XX  XX according to list,
% please change password immediately (type'passwd')


% Matlab is 
% 
%  * a programming language
%  * a prototyping tool 
%  * a visualization tool 
%  * pocket calculator
%
%  + fast
%  + "relatively" comfortable
%  + powerful 
%  + widely-used 
% 
%  - expensive! 
%  - not fully downward-compatible 
%  - not always a pretty language  




% Computations with Matlab
% ------------------

5/3

a=5
b=3
a/b


% basic data structure is an array of type long with an arbitrary number of
% dimensions (do not have to be declared previously)

size(a) 
% address a as a vector
a(2) = 7
a(3) = 9

a(5) = 13 

% address a as a 2D matrix
a(1,4) = 11

size(a)

a(2,2) = 1
size(a)

% attach a row to a
a = [a; [1, 1, 1, 1, 1]]




% standard operators refer to the whole matrix
a
2*a

% matrix multiplication
b=[1,23;1,2,3]
b*a

% This does not work: a*b 
% but transposing it, is possible (using an ')
size(b)
size(b') % alternatively use: transpose(b)
a'*b'
% (Achtung: for complex matrices ' results in a complex conjugation)


% For special matrices, there are special commands
d = eye(6)
e = ones(4)
f = zeros(4)
g = randn(3)
g = rand(3,2)
% which accept more than one argument
e = ones(2,5)
diag([1, 2, 3, 4])
diag([1, 2, 3, 4], 2)



% The : operator
% ------------------------

-5:6
1:2:10
0.31:-0.0271:0.22

a(1, 1:end)
a(2, :) % returns second row of matrix a



% Operators
% ----------
% refer to the complete matrix
c=[1, 2 3; 4 5 6; 7 8 9]
c^2 % c*c 
% if not used with an additional "." 
c=[1, 2 3; 4 5 6; 7 8 9]
c.^2 

% Linear Algebra 
det(c) % matrix is singular 
c(3,3) = 4
det(c)
d=inv(c) 
c*d

% Boole Operators and subscripts
5>3
5>6
4~=4 % ~ is the NOT-Operator
a>10
mean(a)
a(a>10) = Inf





% Saving and Loading of Data
% -----------------------------
save data % saves all variables
save data_a a % save only variable a 
ls % and "dir" list the complete current directory

% it is possible to delete variable from the work space
clear a 
% and to delete all variables
clear 

load data 
clear

% make a plot
a=-1:0.1:1;
b=sin(a.^2);
figure;
plot(a,b);
title('a fascinating plot')
xlabel('x')
ylabel('x^2')

%write a function
%save this function in a separate file
function m=factorial(n)
m=1
for i=1:n
   m=i*m;
end
%then you can call it
factorial(3)

% Avoiding for loops
% ------------------
% When programming in Matlab, always try to express matrix and vector level
% operations without looping over the elements.
% simple example of sine computation with a loop:
i = 0;
for t=0:.01:10
    i = i+1;
    y(i) = sin(t);
end

% a much faster vectorized version:
t = 0:.01:10;
y = sin(t);

    

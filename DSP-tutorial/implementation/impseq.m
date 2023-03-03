function [x,n]=impseq(s0,s1,s2);
%s0是起始时刻
%s2是终止时刻
%s1是冲激时刻

n=s0:0.01:s2;
x=[(n-s1)==0];

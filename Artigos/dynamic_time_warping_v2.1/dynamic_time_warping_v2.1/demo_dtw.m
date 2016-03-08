% Copyright (C) 2013 Quan Wang <wangq10@rpi.edu>,
% Signal Analysis and Machine Perception Laboratory,
% Department of Electrical, Computer, and Systems Engineering,
% Rensselaer Polytechnic Institute, Troy, NY 12180, USA

% this is a demo showing the use of our dynamic time warping package 
% we provide both Matlab version and C/MEX version
% the C/MEX version is much faster and highly recommended

clear;clc;close all;


a=rand(500,3);
b=rand(520,3);
w=50;

tic;
d1=dtw(a,b,w);
t1=toc;



fprintf('Using Matlab version: distance=%f, running time=%f\n',d1,t1);

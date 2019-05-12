close all
clear
clc

%% Define motor parameters
J = 0.01;
b = 0.1;
K = 0.1397;
R = 1;
L = 0.5;
s = tf('s');
motor_tf = K / ( s*( L*J*s^2 + (L*b+R*J)*s + (R*b+K^2) ) )

%% Simulate open loop system with step response
% linearSystemAnalyzer('step', P_motor, 0:0.1:5)

%% Add control
close all
clc

Kp = 2.5;
Ki = 0;
Kd = 1;

C = pid(Kp, Ki, Kd)
cl_sys = feedback(C*motor_tf, 1)

t = 0:0.01:2;
opt = stepDataOptions;
opt.StepAmplitude = 2*pi;
step(cl_sys, t, opt)
grid
title('Step Response with Control')

%% 
close all
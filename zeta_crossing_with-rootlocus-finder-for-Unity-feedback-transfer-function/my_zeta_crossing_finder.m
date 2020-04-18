function []=my_zeta_crossing_finder(zeros_array,poles_array,zeta_value)
%user should enter the poles and zeros in arrays 
%first step , make the open loop transfer function 

my_tf=zpk(zeros_array,poles_array,1);

%2nd step: make a while loop , in which zeta line s values are incremented
%in small steps and then also evaluated at the transfer_function ,
%if the evaluated value of TF has phase in our desired range of 180 
%break the loop and find the corresponding value of k

%now finding the zeta line
my_phase=pi-acos(zeta_value);
step_size=0.01;
magnitude=0;
required_s_value=0;
zeta_line_array=[];
current_loop_s_value=0;
while(1)
    
    current_loop_s_value=(magnitude+step_size)*(exp(j*my_phase));
    
    %evaluate the open_loop_tf on current value of s
    
   answer= evalfr(my_tf,current_loop_s_value);
    
   %now check if answer phase is in required range or not
   %phase(answer)
   if(phase(answer)>(0.99*pi) && phase(answer)<(pi))
       required_s_value=current_loop_s_value;
       break
   end
    
 magnitude=magnitude+step_size;
 zeta_line_array=[zeta_line_array,current_loop_s_value];
end
disp('value has been found for zeta crossing')
%abs(required_s_value)
current_loop_s_value
%now also finding the corresponding Value of Gain K for which this pole is
%occuring 

%for plotting the zeta line
current_loop_s_value=(magnitude+2)*(exp(j*my_phase));
zeta_line_array=[zeta_line_array,current_loop_s_value];
%------------------------

gain_value=1/(abs(answer))

%now plotting the root locus
rlocus(my_tf) 
hold on
plot(real(zeta_line_array),imag(zeta_line_array))
%my_zeta_crossing_finder([2+4j,2-4j],[-2,-4],0.45)
end
function [ Xplus ] = AUV_Dynamics_discrete_real( X,U,T )

% System coefficients
%==========================================================================
err_model=0.3;
% err_model=0;

% B=[0.7974    0.8643    0.8127    0.8270
% 0.6032    0.5029   -0.5824   -0.5610
% 0.2945   -0.3302   -0.2847    0.3505];

m=116;
Iz=13.1;
X_udot=-167.6*(1+err_model);
Y_vdot=-477.2*(1+err_model);
N_rdot=-15.9*(1+err_model);
Xu=26.9*(1+err_model);
Yv=35.8*(1+err_model);
Nr=3.5*(1+err_model);
Du=241.3*(1+err_model);
Dv=503.8*(1+err_model);
Dr=76.9*(1+err_model);

Mx=m-X_udot;
My=m-Y_vdot;
Mpsi=Iz-N_rdot;
%==========================================================================

x=X(1);
y=X(2);
psi=X(3);
u=X(4);
v=X(5);
r=X(6);

tau=U;

Fu=tau(1);
Fv=tau(2);
Fr=tau(3);

x_dot=u*cos(psi)-v*sin(psi);
y_dot=u*sin(psi)+v*cos(psi);
psi_dot=r;
u_dot=(My/Mx)*v*r-(Xu/Mx)*u-(Du/Mx)*u*abs(u)+Fu/Mx;
v_dot=-(Mx/My)*u*r-(Yv/My)*v-(Dv/My)*v*abs(v)+Fv/My;
r_dot=((Mx-My)/Mpsi)*u*v-(Nr/Mpsi)*r-(Dr/Mpsi)*r*abs(r)+Fr/Mpsi;


X_dot=[x_dot;y_dot;psi_dot;u_dot;v_dot;r_dot];

Xplus=X+X_dot*T;

end


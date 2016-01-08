clf
clear

X=makedist('exponential','mu',1); %Create iid exp RVs
Y=makedist('exponential','mu',1);
Z=makedist('exponential','mu',1);

N=10e6;                         
x=X.random(N,1);
y=Y.random(N,1);
z=Z.random(N,1);

u=x./(x+y);                         %Generate RVs
v=(x+y)./(x+y+z);
w=x+y+z;

figure(1);subplot(3,3,1);hist(x,100);title('X');axis([0 20 0 2e6]);
figure(1);subplot(3,3,2);hist(y,100);title('Y');axis([0 20 0 2e6]);
figure(1);subplot(3,3,3);hist(z,100);title('Z');axis([0 20 0 2e6]);
figure(1);subplot(3,3,4);hist(u,100);title('U');
figure(1);subplot(3,3,5);hist(v,100);title('V');
figure(1);subplot(3,3,6);hist(w,100);title('W');axis([0 20 0 8e5]);

UU=makedist('uniform');             %Generate postulated RVs
VV=makedist('triangular','a',0,'b',1,'c',1);
WW=makedist('gamma','a',3,'b',1);

uu=UU.random(N,1);
vv=VV.random(N,1).*2;
ww=WW.random(N,1);

figure(1);subplot(3,3,7);hist(uu,100);title('UU');
figure(1);subplot(3,3,8);hist(vv,100);title('VV');
figure(1);subplot(3,3,9);hist(ww,100);title('WW');axis([0 20 0 8e5]);
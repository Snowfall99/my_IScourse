n=0:31;
N=32;
x=0.1*n+0.2.^n+4*cos(0.2*pi*n);
X=fft(x,N);
subplot(3,2,1);stem(n,real(X),'.');
subplot(3,2,2);stem(n,imag(X),'.');


subplot(3,2,3);stem(n,x,'.');
x=conj(fft(conj(X)))/32;
subplot(3,2,4);stem(n,x,'.');


x1(1:16)=x(2*[0:15]+1);
x2(1:16)=x(2*[1:16]);
y=x1+j*x2;
Y=fft(y,N/2);
X1=[Y(1) (Y([1:15]+1)+conj(Y([15:-1:1]+1)))/2];
X2=[Y(1) (Y([1:15]+1)-conj(Y([15:-1:1]+1)))/2/j];
X=[X1+X2.*exp(-j*2*pi*[0:15]/32) X1-X2.*exp(-j*2*pi*[0:15]/32)];
subplot(3,2,5);stem(n,real(X),'.');
subplot(3,2,6);stem(n,imag(X),'.');
clc
clear all
close all

% Veri Seti 1 (Test Verisi)
% p = [2  1 -2 1;...
%      2 -2  2 1];
% t = [0  1  0 1];

%%--------------------------------------------

% Veri Seti 2 (AND)
% p = [0  0  1  1;...
%      0  1  0  1];
% t = [0  0  0  1];

%%--------------------------------------------

% Veri Seti 3 (OR)
% p = [0  0  1  1;...
%      0  1  0  1];
% t = [0  1  1  1];

%%--------------------------------------------

% % Veri Seti 4 (XOR)
% p = [0  0  1  1;...
%      0  1  0  1];
% t = [0  1  1  0];
%%--------------------------------------------

% Veri Seti (Parite 3 Problemi)
% 
%  p=[-1 -1 -1 -1  1  1  1  1;...
%     -1 -1  1  1 -1 -1  1  1;...
%     -1  1 -1  1 -1  1 -1  1];
%  t=[-1  1  1 -1  1 -1 -1  1];

%%--------------------------------------------

% Parite4 problemi

p=[-1, -1, -1, -1, -1, -1, -1, -1,  1,  1,  1,  1,  1,  1,  1,  1;...

      -1, -1, -1, -1,  1,  1,  1,  1, -1, -1, -1, -1,  1,  1,  1,  1;...

      -1, -1,  1,  1, -1, -1,  1,  1, -1, -1,  1,  1, -1, -1,  1,  1;...

      -1,  1, -1,  1, -1,  1, -1,  1, -1,  1, -1,  1, -1,  1, -1,  1];

t=[-1,  1,  1, -1,  1, -1, -1,  1,  1, -1, -1,  1, -1,  1,  1, -1];

[r, k]=size(p);
S1=1;
S2=1;
w1=randn(S1,r);
w2=randn(S2,S1);
b1=1; %b1 size=s1x1
b2=1;%b2 size=s2x1
sonuc=[];
eta=0.5;
ep=20;
for i=1:ep
    for l=1:k
        n1=w1*p(:,l)+b1;
        a1=tansig(n1);
        n2=w2*a1+b2;
        a2=tansig(n2);
        sonuc(l)=a2;
        e=t(1)-sonuc(l);
        s2=2*dtansig(n2,a2)*e;
        s1=diag(dtansig(n1,a1),0)*w2'*s2;

        w1=w1+eta*s1*p(:,1)';
        w2=w2+eta*s2*a1';
       SE(i,l)= e*e';%squared error
    end
    MSE(i)=mean(SE(i,:));  %mean squared error
    TCE(i)=length(find((round(sonuc)-t)==0)*100/length(sonuc));%training classification error
end
figure
semilogy(MSE)
xlabel('epoch')
ylabel('MSE')
title('Amaç fonksiyonu')
figure
plot(TCE)
xlabel('Epoch')
ylabel('Sýnýflandýrma hassasiyeti (%)')
title('sýnýflandýrma performansý')

figure
plot(t,'or')
hold on
plot(round(sonuc))
legend('gerçek sonuç','tahmini sonuç')
title('sýnýflandýrma performansý')

    
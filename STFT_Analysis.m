% This function realizes the STFT for single channels


Fs = 100000;%���ò���Ƶ��
Data = Data1_AI_A_1(:); % ʵ������������������ת��
Data = Data-mean(Data); %ȥƽ��
figure(1)
nLevel = 3000;
win = MakeWindows('Gaussian', 6000 , nLevel);
Nfft = Fs / 1;
[specgmShow] = STFT(Data,win , nLevel , Nfft); %���������������help STFT,���ݵ�̫�����Ե����ֱ���
specgmShow = abs(specgmShow(1:size(specgmShow,1)/2,:));
[ff,tt] = size(specgmShow);
% colormap(jet_Linchao(64))
imagesc((0:nLevel:(tt-1)*nLevel)/Fs,Fs/2*linspace(0,1,ff),(specgmShow)); %(specgmShow-spmin)/(spmax-spmin)
axis xy;
xlabel('time : s');
ylabel('frequecy : Hz')
title('ʱƵͼ');
axis([0 , (((tt-1)*nLevel)/Fs) ,0 , 2000])%�˴���������ķ�Χ

caxis([0,0.03])


% Made by Zhibin Zhao, Baoqing Ding, Shuming Wu
% Contact with zhaozhibin@stu.xjtu.edu.cn
% Date: 2016.09.13
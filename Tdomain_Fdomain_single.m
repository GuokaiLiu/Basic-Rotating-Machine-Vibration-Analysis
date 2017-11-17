% ������ʵ�ּ򵥵�ʱ���Ƶ�����ͼ����
clc
clear all
close all
for i = 1:2 %����ͨ����Ŀ��������  
    if i == 4
        continue;  %��������ͨ������Ŀ����������11ͨ��δʹ��
    else
%         filename = ['HBMchan' num2str(i) '.mat'];
        filename = ['Econchan' num2str(i) '.mat'];
        load(filename)
%         Data = cell2mat(Data);
        Data = Data(:)';  % ʵ������������������ת��
        Data = Data-mean(Data); %ȥƽ��
        n = length(Data);
        Fs = 4000; % ���ò���Ƶ��
        t = 0:1/Fs:(n-1)/Fs;
        figure(i)
        plot(t,Data);
        titlex = ['ͨ��' num2str(i) 'ʱ��ͼ'];
        title(titlex)
        xlabel('time /s')
        ylabel('amplitude')
        saveas(gcf, ['J:\XH_test\2017\0610\ͨ��' num2str(i) 'ʱ��ͼ.fig']);
        close gcf
    end
%% ������Ҫ��Ƶ��ͼ������Ǳ�ת���źţ����ȫ������Ƶ��ͼ��Ҫ�Բ���,��ҪʱƵͼ
% [Mag,f] = dofft(c,Fs); 
% Plot single-sided amplitude spectrum.
% figure(2)
% plot(f,Mag) 
% title('Single-Sided Amplitude Spectrum of y(t)')
% xlabel('Frequency (Hz)')
% ylabel('|Y(f)|') 
end

% Made by Zhibin Zhao, Baoqing Ding, Shuming Wu
% Contact with zhaozhibin@stu.xjtu.edu.cn
% Date: 2016.09.13

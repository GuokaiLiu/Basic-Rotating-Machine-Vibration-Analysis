% ������ʵ��ȫ������RMS����Чֵ��������ͼ�Ļ���
clc;
clear all;
close all;
cl = {'r';'g';'b';'y';'m';'c';'k'}; %������Ҫ��ͨ��������ͼ
Fs = 4000; %���ò���Ƶ��
for n = 1:2
%         if n == 1 || n == 2 || n == 3 || n == 4 
%         if n == 5 || n == 6 
        if n == 1 || n == 2
%         if n == 2 || n == 6 || n == 7  
%         if n == 1 || n == 3 || n == 8  
%         filename = ['HBMchan',num2str(n),'.mat'];
        filename = ['Econchan' num2str(n) '.mat'];       
        load (filename)
        Data = Data(:); % ʵ������������������ת��
        Data = Data-mean(Data); %ȥƽ��
        L = length(Data);
        % ����RMSֵ��ÿ2000�������һ�Σ��м��ص�1000����
        N = 1000*2;
        start = 1;
        t = (1:L)/Fs;
        Timeindex = start:1000:(L-N);
        for irow = 1:length(Timeindex)
            Vibrationseg = Data(Timeindex(irow):Timeindex(irow)+N-1);
            Index= Cal_Index(Vibrationseg);
            Rms(irow) = Index;
        end
        
        plot(t(Timeindex + 1000),Rms);
        hold all;
        axis([-inf,inf,-inf,inf]);
        end
end
%% ���ݶ�Ӧ��ѭ��˳��������ͬ��ɫ�źŵ�����
%   legend('ˮ��̨����','1#�⹦������','�⹦��֧������',3,'Location','NorthEastOutside');
%   saveas(gcf, ['G:\TestProject(2016-09-24,15-34-22)\codes\RMS�Ա�ͼ\ˮ��̨����_1#�⹦������_�⹦��֧������.fig']);
%   legend('1#�⹦������','1#�⹦������',2,'Location','NorthEastOutside');
%   saveas(gcf, ['G:\TestProject(2016-09-24,15-34-22)\codes\RMS�Ա�ͼ\�⹦������������.fig']); 
%   legend('2#��д�ֱ','3#��д�ֱ','4#��д�ֱ',3,'Location','NorthEastOutside');
%   saveas(gcf, ['G:\TestProject(2016-09-24,15-34-22)\codes\RMS�Ա�ͼ\2#��д�ֱ_3#��д�ֱ_4#��д�ֱ.fig']);
  legend('��ѹ','��ѹ',2,'Location','NorthEastOutside');
  saveas(gcf, ['J:\XH_test\2017\0610\ȫ���Ա�.fig']); 
% Made by Zhibin Zhao, Baoqing Ding, Shuming Wu
% Contact with zhaozhibin@stu.xjtu.edu.cn
% Date: 2016.09.13
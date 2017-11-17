function [Channel_Number] = Data_Convert( CurrentFolder, MyFileInfo_Channel ,  Cons)
% This function realizes Converting the data
% Input:
%          CurrentFolder : the folder where you save the data
%          MyFileInfo_Channel : the channels' name
%          Cons : some constant parameters
%  Made by Zhibin Zhao, Baoqing Ding, Shuming Wu
%  Contact with zhaozhibin@stu.xjtu.edu.cn
%  Date: 2017.06.19
k = 1 : Cons.Channel;
Channel_Number = setdiff(k , Cons.ChannelNot);
switch Cons.Collect
    case 1
        % ʵ��Econһ������ݲɼ���������ת��
        % ����ͨ������ת��ͨ��
        for i = 1 :  length(Channel_Number)%ͨ��ѭ������ͨ����
            filename = [CurrentFolder '\' MyFileInfo_Channel(Channel_Number(i)).name];%�����ļ�·��
            fileID = fopen(filename);
            if Cons.type == 1                
            % ʵ��y���ݱ�����ʽ
                x = textscan(fileID,'%f','HeaderLines',21);%����һ��cell���飬����TXT�ļ��������ö�ȡ�ķ�ʽ��HeaderLines����ǰ��յ���������
                fclose(fileID);
                Data = cell2mat(x);
            else
            % ʵ��x-y���ݱ����ʽ
                x = textscan(fileID,'%f %f','HeaderLines',21);
                fclose(fileID);
                Data = cell2mat(x(1,2));
            end
            %% �ڳ�ȡ֮ǰ��Ĭ�ϵز�����8��chebyshevI�͵�ͨ�˲���ѹ��Ƶ����
            % Data = decimate(Data,4);%��ԭʼ���ݽ��н���������ԭʼ���ݲ���Ƶ��Ϊ12800��������֮��Ϊ3200.������Ҫѡȡ������
            
            filename = ['Econchan' num2str(Channel_Number(i)) '.mat'];%cell��ʽת��Ϊmat��ʽ�ļ�
            save(filename,'Data','-v7.3');
        end
        
    case 2    
        % ʵ��Econ���ݲɼ���������һ����������ļ�.txt����ת��Ϊ.mat
        %��ע��Econ����ĸ�ʽ�ǰ���x-y����y�ĸ�ʽ���б���ģ�
        for i = 1 :  length(Channel_Number)%ͨ��ѭ������ͨ����
            filename = [CurrentFolder '\' MyFileInfo_Channel(Channel_Number(i)).name];%�����ļ�·��
            fileID = fopen(filename);
            if Cons.type == 1                
            % ʵ��y���ݱ�����ʽ
                x = textscan(fileID,'%f','HeaderLines',18);%����һ��cell���飬����TXT�ļ��������ö�ȡ�ķ�ʽ��HeaderLines����ǰ��յ���������
                fclose(fileID);
                Data = cell2mat(x);
            else
            % ʵ��x-y���ݱ����ʽ
                x = textscan(fileID,'%f %f','HeaderLines',18);
                fclose(fileID);
                Data = cell2mat(x(1,2));
            end
            %% �ڳ�ȡ֮ǰ��Ĭ�ϵز�����8��chebyshevI�͵�ͨ�˲���ѹ��Ƶ����
            % Data = decimate(Data,4);%��ԭʼ���ݽ��н���������ԭʼ���ݲ���Ƶ��Ϊ12800��������֮��Ϊ3200.������Ҫѡȡ������
            filename = ['Econchan' num2str(Channel_Number(i)) '.mat'];%cell��ʽת��Ϊmat��ʽ�ļ�
            save(filename,'Data','-v7.3');
        end
        
        
    case 3
        % ������ʵ��HBM���ݲɼ���������ת������Txtת��ΪMat
        for i = 1 :  length(MyFileInfo_Channel)  %����ͨ�����趨ѭ��
            filename = [CurrentFolder '\' MyFileInfo_Channel(i).name];%��������Ҫת���ļ���·��
            fileID = fopen(filename);
            % textscan(fileID,'%s')
            x = textscan(fileID,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');%����һ��16�е�cell����
            fclose(fileID);
            for j = Channel_Number %�����Լ����õ�ͨ����
                Data = cell2mat(x(j));
                filename = ['HBMchan' num2str(j) '.mat'];%cell��ʽת��Ϊmat��ʽ�ļ�
                save(filename,'Data');
            end
        end
        
        
        
end


function [stft,Tx,time,freqr,win]=Fast_STFT_SST_Matrix_ZoomNoRecon(sig,fs,sigma,hop,f1,f2,zoom,nfft)
% Fast zoomed Synchrosqueezing Transform
% Input:
%       sig : the inputting signal
%       fs : sampling frequency
%       sigma : the standard deviation of the gaussian window function
%       hop : the size of the jump <= length(Win) / 2
%       f1��f2 : the range of frequency to be analysed (f1<f2)
%       Zoom : magnifying factor
%       Nfft : FFT length >= length(Win)
% Output:
%       stft : short time Fourier transform
%       Tx : zoomed Synchrosqueezing Transform
%       time, freqr : time and frequency vectors
%       win : window function
% 
% Modified by HeDong
% Date: 2017.11
% Email:hedongcn@hotmail.com

if nargin < 8
    nfft=length(sig);
end

sig=sig(:);
% N = length(sig);

% Initialize output matrix,
% nw = floor(N ./ m);    % ����������nw
% 
% nfft=round(nbin*fs/(f2-f1)); % FFT�任�ĵ���
% nfft=2^nextpow2(nfft);

idx1=round(f1*nfft/fs); %f1��Ӧ������
idx2=round(f2*nfft/fs); %f2��Ӧ������

freqr=linspace(0,fs,nfft)';    %����Ƶ���᡾���塿���ֽ��

% nfft=fix(N/2)+1;
% STFT    = zeros(idx2-idx1+1,nw);
% dSTFT   = zeros(idx2-idx1+1,nw);

% Gaussian window function
K = 0.005;
Half = round(sqrt(-2*log(K))*sigma*fs); 
sig = [zeros(Half,1); sig; zeros(Half,1)];  %���غ���ź�

ix     = ((-Half):Half);
t_win = ix/fs;
win = (pi*sigma^2)^(-0.25).* exp(-(t_win/sigma).^2/2);
win = win(:);
% the first derivative of Gaussian window function
dwin = (pi*sigma^2)^(-0.25).* exp(-(t_win/sigma).^2/2).*(-t_win/sigma^2);
dwin = dwin(:);
L=length(win);

% do STFT of win and dwin
ds=buffer(sig,L,L-hop, 'nodelay');
stft = bsxfun(@times, win(:), ds);
stft = fft(stft,nfft)*2/nfft;
stft = stft(idx1:idx2,:);
ds = bsxfun(@times, dwin(:), ds);
ds = fft(ds,nfft)*2/nfft;
ds = ds(idx1:idx2,:);


gamma = 1e-8;       % ��ֵ��С�����ֵ���ԣ���ΪNAN������ʽ2-53��
stft((abs(stft)<gamma)) = NaN;
CandidateIF =  real(1i *ds ./stft / (2*pi) ) ;   %(ʽ2-49)
[row,col]=size(stft);
time=(0:hop:(col-1)*hop)/fs;
freqr= linspace(f1,f2,idx2-idx1+1);
CandidateIF = bsxfun(@plus, freqr(:), CandidateIF);


freqr= linspace(f1,f2,zoom*(idx2-idx1+1));
Tx = SynchroSqueezing(stft,CandidateIF,f1,freqr);

end




function Tx = SynchroSqueezing(STFT,CandidateIF,f1,freqr)
% STFT-based Synchrosqueezing 
%   input:
%       STFT: the TF representation by STFT
%       w: Candidate instantaneous frequency
%       freqr: the frequency associated with STFT
%   output:
%       Tx: `the synchrosqueezing result

%{
if nargin ~= 3
    error('you should check the input parameter of SynSqu_STFT function');
end
%}
[STFT_rows,STFT_cols] = size(STFT);
Tx = zeros(length(freqr),STFT_cols);       % ���Ž����ռλ��
delta_f = (freqr(2)-freqr(1));  % STFT_rows��Ƶ�ʵ���,STFT_cols��ʱ�����
k=zeros(size(Tx));
for u=1:STFT_cols
   for fi=1:STFT_rows
        if (~isnan(CandidateIF(fi, u)) && (CandidateIF(fi,u)>0))
            % Find w_l nearest to w(a_i,b)         
%             k(fi,u) = 1 + round((CandidateIF(fi,u)-f1)/delta_f);
            k(fi,u) = round((CandidateIF(fi,u)-f1)/delta_f);
            if ~isnan(k(fi,u)) && k(fi,u)>0 && k(fi,u) <= size(Tx,1)
            % ���Ź�ʽ��ֻ����˲ʱƵ�����Ӵ�����STFT��ֵ��
            % ����fi=100Hz��k(fi,u)=120Hz��100Hz����STFTֵҪ�Ӹ�Tx����ͼ��120Hz��
                Tx(k(fi,u),u) = Tx(k(fi,u), u) + abs(STFT(fi, u)); 
%                 Tx(k(fi,u),u) = Tx(k(fi,u), u) + STFT(fi, u)*delta_f; 
            end
        end
    end 
end 

end
%}
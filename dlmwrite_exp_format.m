function dlmwrite_exp_format(varargin)

tmp=num2str(varargin{2},'%8.5e ');
dlmwrite(varargin{1},tmp,'delimiter','')

end
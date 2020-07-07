function mcrSplit(numCores, filename)

tmp1 = strfind(pwd,'/');
tmp2 = pwd;
foldername = tmp2(tmp1(end)+1:end); clear tmp1 tmp2;
load(filename);

numCases=length(mcr.cases(:,1));
numJobPerCor = ceil(numCases/numCores);

mcr_org=mcr;
mcr.header = mcr_org.header;
mcr.cases= [];
fileID = fopen('wecSimScript','w');
for i=1:numCores
    newfoldername = append(foldername,'_',num2str(i));
    str1=sprintf('mkdir ../%s',newfoldername);      evalc(str1);
    str2=sprintf('copyfile * ../%s',newfoldername); evalc(str2);
    mcr.CPUstart = (i-1)*numJobPerCor+1;
    mcr.CPUend   = i*numJobPerCor;
    if mcr.CPUend>numCases; mcr.CPUend=numCases; end
    mcr.cases=mcr_org.cases(mcr.CPUstart:mcr.CPUend,1:end);
    outputname = sprintf('../%s/%s%d.mat', newfoldername,filename);
    save(outputname, 'mcr','-v7.3');
    fprintf(fileID,sprintf('cd ../%s \n', newfoldername));
    fprintf(fileID,'nohup matlab -nodesktop -r "wecSimMCR; quit force;" > wecSimoutput.log & \n');
end
fprintf(fileID,sprintf('wait \n'));
fprintf(fileID,sprintf('cd ../%s \n', foldername));
fclose(fileID);


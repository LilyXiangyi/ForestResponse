%% processing Raw Data
% Temperature-1901-2016 degrees Celsius
clc;clear;
data=ncread('CRUv4.01\cru_ts4.01.1901.2016.tmp.dat.nc','tmp');
data=permute(data,[2,1,3]);
for i=1:1392
    data1=data(:,:,i);
    data1=flipud(data1);
    tmp(:,:,i)=data1;
end
save('\tmp1901-2016.mat','tmp','-v7.3');

% Precipitation-1901-2016: mm/month
clc;clear;
data=ncread('\CRUv4.01\cru_ts4.01.1901.2016.pre.dat.nc','pre');
data=permute(data,[2,1,3]);
for i=1:1392
    data1=data(:,:,i);
    data1=flipud(data1);
    pre(:,:,i)=data1;
end
save('\pre1901-2016.mat','pre','-v7.3');

% PET-1901-2016: mm/day->month
clc;clear;
data=ncread('\CRUv4.01\cru_ts4.01.1901.2016.pet.dat.nc','pet');
data=permute(data,[2,1,3]);
month1=[31 28 31 30 31 30 31 31 30 31 30 31];
month2=[31 29 31 30 31 30 31 31 30 31 30 31];
for i=1:1392
    year=floor(i/12)+1901;
    imonth=mod(i,12);
    if imonth==0
        imonth1=12;
    else
        imonth1=imonth;
    end
    data1=data(:,:,i);
    data1=flipud(data1);
    if mod(year,4)==0
       pet(:,:,i)=data1*month2(imonth1);
    else
        pet(:,:,i)=data1*month1(imonth1);
    end
end
save('\pet1901-2016.mat','pet','-v7.3');

% p-pet
clc;clear;
load('\pet1901-2016.mat');
load('\pre1901-2016.mat');
month1=[31 28 31 30 31 30 31 31 30 31 30 31];
month2=[31 29 31 30 31 30 31 31 30 31 30 31];
for i=1:1392
    iyear=mod(fix(i/12)+1901,4);
    imonth=mod(i,12);
    if imonth==0
        imonth=12;
    end
    if iyear==0
       cwd(:,:,i)=pre(:,:,i)-pet(:,:,i)*month2(imonth);
    else
        cwd(:,:,i)=pre(:,:,i)-pet(:,:,i)*month1(imonth);
    end
end
save('\p-pet.mat','cwd','-v7.3');

clc;clear;
load('\p-pet.mat','cwd');
[a b c]=xlsread('\Siteinfo.xlsx');
lat=a(:,1);
lon=a(:,2);
latid=(90-lat)*2;
lonid=(180+lon)*2;
for i=1:length(lat)
    % 3x3 window
    latpos=round(latid(i))-1:round(latid(i))+1;
    lonpos=round(lonid(i))-1:round(lonid(i))+1;
    datacwd=cwd(latpos,lonpos,1:1380);
    datacwd1=reshape(datacwd,length(latpos)*length(lonpos),1380);
    datasite_cwd(i,:)=nanmean(datacwd1)';
    if length(find(isnan(datasite_cwd(i,:))))==1380
       clear latpos lonpos datacwd datacwd1
       latpos=round(latid(i))-2:round(latid(i))+2;
       lonpos=round(lonid(i))-2:round(lonid(i))+2;
       datacwd=cwd(latpos,lonpos,1:1380);
       datacwd1=reshape(datacwd,length(latpos)*length(lonpos),1380);
       datasite_cwd(i,:)=nanmean(datacwd1)';
    end
end
table(:,1)=b(2:end,1);
table(:,2:2936)=num2cell(datasite_cwd);
xlswrite('\Site_p-pet.xlsx',table);

%% Identifying Drought events
clc;clear;
[a b c]=xlsread('\Site_p-pet.xlsx');
for i=1:length(b)
    for iyear=1:115
        data=a(i,1+(iyear-1)*12:iyear*12);
        datamean=nanmean(data);
        dataano=data-datamean;
        num=find(dataano<0);% dry
        num1=setdiff(1:12,num);% wet 
        
        arrset=cell(0,0);
        arrset1=cell(0,0);
%       a. starting from a dry month
       if length(find(num==1))~=0
          c1=1;
          while(c1<=numel(num))
               c2=0;
               while (c1+c2+1<=numel(num)&&num(c1)+c2+1==num(c1+c2+1))
               c2=c2+1;
               end
              if(c2>=1)
                 arrset= [arrset;(num(c1:1:c1+c2))];
                 elseif c1~=1&(num(c1)~=12)
                        gap=num(c1)-num(c1-1)-1;
                        if gap<2 %only one month gap
                           arrset=[arrset;num(c1-1)+1:num(c1)];
                        end
                elseif c1==1
                       if iyear>1
                          data_pre=a(i,1+(iyear-2)*12:(iyear-1)*12);
                          datamean_pre=nanmean(data_pre);
                          dataano_pre=data_pre-datamean_pre;
                          num_pre=find(dataano_pre<0);
                          if length(find(num_pre==12))~=0
                             arrset=[arrset;num(1)];
                          end
                       else
                          arrset=[arrset;num(1)];
                       end 
                      elseif num(c1)==12
                          if iyear<115
                             data_post=a(i,1+iyear*12:(iyear+1)*12);
                             datamean_post=nanmean(data_post);
                             dataano_post=data_post-datamean_post;
                             num_post=find(dataano_post<0);
                             if length(find(num_post==1))~=0
                                arrset=[arrset;num(c1)];
                             end
                          else
                             arrset=[arrset;num(c1)];
                          end
              end
              c1=c1+c2+1;
          end
          matrix=nan;
          for j=1:length(arrset)
              matrix=[matrix arrset{j}];
          end
          matrix1=matrix(2:length(matrix));
          flag=diff(matrix1);
          numflag=find(flag==2);
          flagmatrix=[];
          for iflag=1:length(numflag)
              flagmatrix=[flagmatrix matrix1(numflag(iflag)) matrix1(numflag(iflag)+1)];
          end
          matrix_re=setdiff(matrix1,flagmatrix);
          for iflag=1:length(numflag)
              matrix_re=[matrix_re matrix1(numflag(iflag)):matrix1(numflag(iflag)+1)];
          end
          matrix_dry=sort(matrix_re,'ascend');
          matrix_wet=setdiff(1:12,matrix_dry);% wet month
       end

% b.if starting from a wet season
     if length(find(num1==1))~=0
        c1=1;
        while(c1<=numel(num1))
             c2=0;
             while (c1+c2+1<=numel(num)&&num(c1)+c2+1==num(c1+c2+1))
                  c2=c2+1;
             end
             if(c2>=1)
                 arrset1= [arrset1;(num1(c1:1:c1+c2))];
             elseif c1~=1&(num1(c1)~=12) %1月份和12月份不是单独的干旱月
                 gap=num1(c1)-num1(c1-1)-1;
                 if gap<2 %单独的干旱月与前面连续的干旱月之间只间隔一个月
                    arrset1=[arrset1;num1(c1-1)+1:num1(c1)];
                 end
            elseif c1==1
                if iyear>1
                   data_pre=a(i,1+(iyear-2)*12:(iyear-1)*12);
                   datamean_pre=nanmean(data_pre);
                   dataano_pre=data_pre-datamean_pre;
                   num_pre=find(dataano_pre>0);
                   if length(find(num_pre==12))~=0
                      arrset1=[arrset1;num1(1)];
                   end 
                else
                   arrset1=[arrset1;num1(1)];
                end 
            elseif num1(c1)==12
               if iyear<115
                  data_post=a(i,1+iyear*12:(iyear+1)*12);
                  datamean_post=nanmean(data_post);
                  dataano_post=data_post-datamean_post;
                  num_post=find(dataano_post>0);
                  if length(find(num_post==1))~=0
                     arrset1=[arrset1;num1(c1)];
                  end
               else
                 arrset1=[arrset1;num1(c1)];
               end
             end
             c1=c1+c2+1;
        end
        matrix=nan;
        for j=1:length(arrset1)
            matrix=[matrix arrset1{j}];
        end
        matrix1=matrix(2:length(matrix));
        flag=diff(matrix1);
        numflag=find(flag==2);
        flagmatrix=[];
        for iflag=1:length(numflag)
            flagmatrix=[flagmatrix matrix1(numflag(iflag)) matrix1(numflag(iflag)+1)];
        end
        matrix_re=setdiff(matrix1,flagmatrix);
        for iflag=1:length(numflag)
           matrix_re=[matrix_re matrix1(numflag(iflag)):matrix1(numflag(iflag)+1)];
        end  
    matrix_wet=sort(matrix_re,'ascend');
    matrix_dry=setdiff(1:12,matrix_wet);% wet month
     end
     dryseason(i,iyear)=num2cell({matrix_dry});
     wetseason(i,iyear)=num2cell({matrix_wet});
     clear matrix_wet matrix_dry matrix
    end
end
tabled=cell(2935,116);
tablew=cell(2935,116);
tabled(:,1)=b;
tabled(:,2:116)=dryseason;
tablew(:,1)=b;
tablew(:,2:116)=wetseason;
save('\season.mat','tabled','tablew');

% 1. extreme events in dry season
clc;clear;
load('\season.mat','tabled');
sitename=table1(:,1);
cwddata=table1(:,2:116);
[a b c]=xlsread('\siteSPEI12.xlsx');
spei=a;
sitename1=b;
clear a b c;
eventmark=zeros(length(sitename1),115);
for i=1:length(sitename)
    for iyear=1:115
        data=cwddata(i,iyear);
        data1=data{:};
        data2=cell2mat(data1);
        speidata=spei(i,1+(iyear-1)*12:iyear*12);
        speidata1=speidata(data2);
        speimean_dryseason(iyear)=nanmean(speidata1);
    end
    speirank=sort(speimean_dryseason,'ascend');
    lownum=round(length(speirank)*0.1);
    lowcutoff=speirank(lownum); 
    num=find(speimean_dryseason<=lowcutoff);
    eventmark(i,num)=1;
end
table(1,1)={'Sitename'};
table(1,2:115)=num2cell(1901:2015);
table(2:2936,1)=sitename;
table(2:2936,2:116)=num2cell(eventmark);
save('\EventIndryseason.mat','table');

% 2. extreme events in wet season
clc;clear;
load('\season.mat','tablew');
sitename=table2(:,1);
cwddata=table2(:,2:116);
[a b c]=xlsread('\siteSPEI12.xlsx');
spei=a;
sitename1=b;
clear a b c;
eventmark=zeros(length(sitename1),114);
for i=1:length(sitename)
    for iyear=1:115 
        data=cwddata(i,iyear);
        data1=data{:};
        data2=cell2mat(data1);
        speidata=spei(i,1+(iyear-1)*12:iyear*12);
        speidata1=speidata(data2);
        speimean_wetseason(iyear)=nanmean(speidata1);
    end
    speirank=sort(speimean_wetseason,'ascend');
    lownum=round(length(speirank)*0.1);
    lowcutoff=speirank(lownum); 
    num=find(speimean_wetseason<=lowcutoff);
    eventmark(i,num)=1;
end
table(1,1)={'Sitename'};
table(1,2:115)=num2cell(1901:2015);
table(2:2936,1)=sitename;
table(2:2936,2:116)=num2cell(eventmark);
save('\EventInwetseason.mat','table');

clc;clear;
load('\EventIndryseason.mat','table');
dryseasontable=table;
sitename=table(2:end,1);
clear table;
load('\EventInwetseason.mat','table');
wetseasontable=table;
clear table;
drymark=cell2mat(dryseasontable(2:2936,2:116));
wetmark=cell2mat(wetseasontable(2:2936,2:116));
markevent=zeros(2935,114);
n=0;
for i=1:2935
    drymark1=drymark(i,:);
    wetmark1=wetmark(i,:);
    num=find(drymark1==1|wetmark1==1);
    markevent(i,num)=1;
end
table(1,1)={'Sitename'};
table(1,2:115)=num2cell(1901:2015);
table(2:2936,1)=sitename;
table(2:2936,2:116)=num2cell(markevent);
save('\Eventyear.mat','table');

clc;clear;
load('\Eventyear.mat');
eventdata=table(2:236,2:116);
year=1901:2015;
load('\EventIndryseason.mat','table');
dryseasontable=table;
sitename=table(2:end,1);
clear table;
load('\EventInwetseason.mat','table');
wetseasontable=table;
clear table;
drymark=cell2mat(dryseasontable(2:2936,2:116));
wetmark=cell2mat(wetseasontable(2:2936,2:116));
n=0;
for i=1:2935
    mark=cell2mat(eventdata(i,:))';
    num=find(mark==1);
    % remove the consecutive drought years
    numdiff=diff(num);
    num([find(numdiff==1),(find(numdiff==1))+1])=[];
    if length(find(num==113))~=0
        num(find(num==113))=[];
    end
    if length(find(num==114))~=0
        num(find(num==114))=[];
    end  
    % independent events
    postyearmark=nan(length(num),2);
    for iyear=1:length(num)
        postyearmark(iyear,:)=mark(num(iyear)+1:num(iyear)+2,1);
    end
    num1=num(find(sum(postyearmark,2)==0));
    if length(num1)>0
        n=n+1;
        table(n,1)=sitename(i);
        table(n,2)={year(num1)};
        table(n,3)={drymark(i,num1)};
        table(n,4)={wetmark(i,num1)};
    end
end
save('\SiteEvent.mat','table');

%% Metrics of resistance and resilience
clc;clear;
load('\SiteEvent.mat');
sitename=table(:,1);
eventyear=table(:,2);
dsevent=table(:,3);
wsevent=table(:,4);
clear table;
load('\Eventyear.mat');
sitename1=table(2:end,1);
eventmark=table(2:end,2:115);

Year=1901:2015;
clear num1 num2;
for i=1:2935
    num=ismember(sitename1,sitename(i));
    eventmark1(i,:)=eventmark(find(num==1),:);
end
clear eventmark;
for i=1:length(sitename)
    load(['\Chron\',char(sitename(i)),'.mat'],'chrontable');
    year=chrontable(:,1);
    chron=chrontable(:,2);
    
    yeardata=eventyear(i);
    singleyear=yeardata{:};
    dsmarki=dsevent(i);
    wsmarki=wsevent(i);
    dsmarki1=dsmarki{:};
    wsmarki1=wsmarki{:};
    
    if length(find(singleyear==year(length(year)-1)))>0
        singleyear(find(singleyear==year(length(year)-1)))=[];
        dsmarki1(find(singleyear==year(length(year)-1)))=[];
        wsmarki1(find(singleyear==year(length(year)-1)))=[];
    end
    if length(find(singleyear==year(length(year))))>0
        singleyear(find(singleyear==year(length(year))))=[];
        dsmarki1(find(singleyear==year(length(year))))=[];
        wsmarki1(find(singleyear==year(length(year))))=[];
    end
    
    [siteyear1,num1,num2]=intersect(year,singleyear);
    eventchron=chron(num1);
    postchron=chron(num1+2);
    sitedsmark=dsmarki1(num2);
    sitewsmark=wsmarki1(num2);
    clear num1 num2;
    
    eventmarki=eventmark1(i,:);
    normalyear=Year(find(cell2mat(eventmarki)==0));
    [normalyear1,num1,num2]=intersect(year,normalyear);
    normalchron=chron(num1);
    normalchronmean=nanmean(normalchron(:));
    resis=normalchronmean./(eventchron-normalchronmean);
    resili=(eventchron-normalchronmean)./(postchron-normalchronmean);
    if length(siteyear1)~=0
       title={'Year','dsmark','wsmark','Resistance','Resilience'};
       result(:,1)=siteyear1;
       result(:,2)=sitedsmark';
       result(:,3)=sitewsmark';
       result(:,4)=resis;
       result(:,5)=resili;
       save(['\Allsites\',char(sitename(i)),'.mat'],'result','title');
       clear result;
    end
end

clc;clear;
dirOutput=dir(fullfile('\Allsites\','*.mat'));
fileNames={dirOutput.name}';
for i=1:length(fileNames)
    data=char(fileNames(i));
    sitename(i,1)=cellstr(data(1:length(data)-4));
end
table(1,1:7)=cellstr({'Sitename','resistance_mean','log_resis','resistance_std','resilience_mean','log_resili','resilience_std'});
% 1. All drought years
for i=1:length(fileNames)
    load(['\Allsites\',char(fileNames(i))],'result','title');
    resisdata=result(:,4);
    resilidata=result(:,5);
    resismean=nanmean(abs(resisdata));
    resilimean=nanmean(abs(resilidata));
    log_resis=log(resismean);
    log_resili=log(resilimean);
    resisstd=nanstd(abs(resisdata));
    resilistd=nanstd(abs(resilidata));
    table(1+i,1)=sitename(i);
    table(1+i,2)=num2cell(resismean);
    table(1+i,3)=num2cell(log_resis);
    table(1+i,4)=num2cell(resisstd);
    table(1+i,5)=num2cell(resilimean);
    table(1+i,6)=num2cell(log_resili);
    table(1+i,7)=num2cell(resilistd);
end
xlswrite('\Eventyear.xlsx',table);

% DS drought
clc;clear;
dirOutput=dir(fullfile('\Allsites\','*.mat'));
fileNames={dirOutput.name}';
for i=1:length(fileNames)
    data=char(fileNames(i));
    sitename(i,1)=cellstr(data(1:length(data)-4));
end
table(1,1:7)=cellstr({'Sitename','resistance_mean','log_resis','resistance_std','resilience_mean','log_resili','resilience_std'});
n=0;
for i=1:length(fileNames)
    load(['\Allsites\',char(fileNames(i))],'result','title');
    dsmark=result(:,2);
    wsmark=result(:,3);
    num=find(dsmark==1&wsmark==0);
    if length(num)>0
       n=n+1;
       resisdata=result(num,4);
       resilidata=result(num,5);
       resismean=nanmean(abs(resisdata));
       resilimean=nanmean(abs(resilidata));
       log_resis=log(resismean);
       log_resili=log(resilimean);
       resisstd=nanstd(abs(resisdata));
       resilistd=nanstd(abs(resilidata));
       table(1+n,1)=sitename(i);
       table(1+n,2)=num2cell(resismean);
       table(1+n,3)=num2cell(log_resis);
       table(1+n,4)=num2cell(resisstd);
       table(1+n,5)=num2cell(resilimean);
       table(1+n,6)=num2cell(log_resili);
       table(1+n,7)=num2cell(resilistd);
    end
end
xlswrite('\Eventyear_ds.xlsx',table);

% WS drought
clc;clear;
dirOutput=dir(fullfile('\Allsites\','*.mat'));
fileNames={dirOutput.name}';
for i=1:length(fileNames)
    data=char(fileNames(i));
    sitename(i,1)=cellstr(data(1:length(data)-4));
end
table(1,1:7)=cellstr({'Sitename','resistance_mean','log_resis','resistance_std','resilience_mean','log_resili','resilience_std'});
n=0;
for i=1:length(fileNames)
    load(['\Allsites\',char(fileNames(i))],'result','title');
    dsmark=result(:,2);
    wsmark=result(:,3);
    num=find(dsmark==0&wsmark==1);
    if length(num)>0
       n=n+1;
       resisdata=result(num,4);
       resilidata=result(num,5);
       resismean=nanmean(abs(resisdata));
       resilimean=nanmean(abs(resilidata));
       log_resis=log(resismean);
       log_resili=log(resilimean);
       resisstd=nanstd(abs(resisdata));
       resilistd=nanstd(abs(resilidata));
       table(1+n,1)=sitename(i);
       table(1+n,2)=num2cell(resismean);
       table(1+n,3)=num2cell(log_resis);
       table(1+n,4)=num2cell(resisstd);
       table(1+n,5)=num2cell(resilimean);
       table(1+n,6)=num2cell(log_resili);
       table(1+n,7)=num2cell(resilistd);
    end
end
xlswrite('\Eventyear_ws.xlsx',table);

% DS+WS drought
clc;clear;
dirOutput=dir(fullfile('\Allsites\','*.mat'));
fileNames={dirOutput.name}';
for i=1:length(fileNames)
    data=char(fileNames(i));
    sitename(i,1)=cellstr(data(1:length(data)-4));
end
table(1,1:7)=cellstr({'Sitename','resistance_mean','log_resis','resistance_std','resilience_mean','log_resili','resilience_std'});
n=0;
for i=1:length(fileNames)
    load(['\Allsites\',char(fileNames(i))],'result','title');
    dsmark=result(:,2);
    wsmark=result(:,3);
    num=find(dsmark==1&wsmark==1);
    if length(num)>0
       n=n+1;
       resisdata=result(num,4);
       resilidata=result(num,5);
       resismean=nanmean(abs(resisdata));
       resilimean=nanmean(abs(resilidata));
       log_resis=log(resismean);
       log_resili=log(resilimean);
       resisstd=nanstd(abs(resisdata));
       resilistd=nanstd(abs(resilidata));
       table(1+n,1)=sitename(i);
       table(1+n,2)=num2cell(resismean);
       table(1+n,3)=num2cell(log_resis);
       table(1+n,4)=num2cell(resisstd);
       table(1+n,5)=num2cell(resilimean);
       table(1+n,6)=num2cell(log_resili);
       table(1+n,7)=num2cell(resilistd);
    end
end
xlswrite('\Eventyear_dw.xlsx',table);

%% Analysis of temporal change
% All sites-1950-2009
clc;clear;
[a b c]=xlsread('\BRTtable.xlsx');
sitename=b(2:end,1);
interval1=[1910 1950 1970 1990];
interval2=[1949 1969 1989 2009];
n1=0;
n2=0;
n3=0;
for i=1:length(sitename)
    load(['\Allsites\',char(sitename(i)),'.mat']);
    year=result(:,1);
    for inum=2:4
        num=find(year>=interval1(inum)&year<=interval2(inum));
        if length(num)~=0
            count(inum)=length(num);
        else
            count(inum)=nan;
        end
    end
    % find sites experiencing drought in all three periods
    if length(find(~isnan(count)))==3
        n1=n1+1;
        sitename1(n1,1)=sitename(i);
    end
end
save('\Alldroughts1950-2009_site.mat','sitename1');

clc;clear;
[a b c]=xlsread('\BRTtable.xlsx');
group=c(2:end,19);
sitename=b(2:end,1);
load('\Alldroughts1950-2009_site.mat','sitename1');
for i=1:length(sitename1)
   flag=ismember(sitename,sitename1(i));
   group1(i,1)=group(flag==1);
end
num=ismember(group1,{'Gymnosperms'});
sitename1_g=sitename1(find(num==1));
sitename1_a=sitename1(find(num==0));
clear flag group1;
save('\Alldroughts1950-2009_differentGroup.mat',...
    'sitename1_g','sitename1_a');


clc;clear;
load('\Alldroughts1950-2009_differentGroup.mat',...
    'sitename1_g','sitename1_a');
interval1=[1950 1970 1990];
interval2=[1969 1989 2009];
for i1=1:length(sitename1_g)
    load(['\Allsites\',char(sitename1_g(i1)),'.mat']);
    year=result(:,1);
    for inum=1:3
        num=find(year>=interval1(inum)&year<=interval2(inum));
        eventyear=year(num);
        resis=abs(result(num,4));
        resili=abs(result(num,5));
        log_resis(i1,inum)=nanmean(log(resis+1));
        log_resili(i1,inum)=nanmean(log(resili+1));
    end
end
log_resismean=log_resis;
log_resilimean=log_resili;
table1(1,:)=cellstr({'sitename','1950-1969','1970-1989','1990-2009'});
table2(1,:)=cellstr({'sitename','1950-1969','1970-1989','1990-2009'});
table1(2:length(sitename1_g)+1,1)=sitename1_g;
table1(2:length(sitename1_g)+1,2:4)=num2cell(log_resismean);
table2(2:length(sitename1_g)+1,1)=sitename1_g;
table2(2:length(sitename1_g)+1,2:4)=num2cell(log_resilimean);
xlswrite('\resistance1950-2009_g.xlsx',table1,'1950-2009');
xlswrite('\resilience1950-2009_g.xlsx',table2,'1950-2009');
clearvars -except interval1 interval2 sitename1_a;

for i1=1:length(sitename1_a)
    load(['\Allsites\',char(sitename1_a(i1)),'.mat']);
    year=result(:,1);
    for inum=1:3
        num=find(year>=interval1(inum)&year<=interval2(inum));
        eventyear=year(num);
        resis=abs(result(num,4));
        resili=abs(result(num,5));
        log_resis(i1,inum)=nanmean(log(resis+1));
        log_resili(i1,inum)=nanmean(log(resili+1));
    end
end
log_resismean=log_resis;
log_resilimean=log_resili;
table1(1,:)=cellstr({'sitename','1950-1969','1970-1989','1990-2009'});
table2(1,:)=cellstr({'sitename','1950-1969','1970-1989','1990-2009'});
table1(2:length(sitename1_a)+1,1)=sitename1_a;
table1(2:length(sitename1_a)+1,2:4)=num2cell(log_resismean);
table2(2:length(sitename1_a)+1,1)=sitename1_a;
table2(2:length(sitename1_a)+1,2:4)=num2cell(log_resilimean);
xlswrite('\resistance1950-2009_a.xlsx',table1,'1950-2009');
xlswrite('\resilience1950-2009_a.xlsx',table2,'1950-2009');

% Temporal correlation
% selecting sites experiencing at least five times
clc;clear;
load('\Alldroughts1950-2009_site.mat','sitename1');
n=0;n1=0;
for i=1:332
    load(['E:\Resilience\Data\Cutoff8\Allsites\',char(sitename1(i)),'.mat']);
    year=result(:,1);
    num=find(year>=1950&year<=2009);
    year1=year(num);
    if length(num)>=5
        n=n+1;
        if length(num)>n1
            n1=length(num);
        end
        resis=abs(result(num,4));
        resili=abs(result(num,5));
        log_resis=log(resis);
        log_resili=log(resili);
        [r p]=corrcoef(log_resis,log_resili);
        R(n)=r(2);
        P(n)=p(2);
        Sitename_tcorr(n)=sitename(i);
        nevent(n)=length(num);
    end  
end
save('\Correlation\TemporalCorr.mat','Sitename_tcorr','R','P','nevent');

% resistance
% A: 1950-1969, B:1970-1989, C:1990-2009
clc;clear;
[a b c]=xlsread('\resistance1950-2009_g.xlsx','1950-2009');
dataA=a(:,1);
dataB=a(:,2);
dataC=a(:,3);
dataAB=dataB-dataA;
dataBC=dataC-dataB;
dataAC=dataC-dataA;
table(:,1)=c(2:end,1);
table(:,2:4)=num2cell([dataAB dataBC dataAC]);
xlswrite('\Tempoealchange\resistance_g.xlsx',table,'delta');

clc;clear;
[a b c]=xlsread('\resistance1950-2009_a.xlsx','1950-2009');
dataA=a(:,1);
dataB=a(:,2);
dataC=a(:,3);
dataAB=dataB-dataA;
dataBC=dataC-dataB;
dataAC=dataC-dataA;
table(:,1)=c(2:end,1);
table(:,2:4)=num2cell([dataAB dataBC dataAC]);
xlswrite('\Temporalchange\resistance_a.xlsx',table,'delta');

% resilience
% A: 1950-1969, B:1970-1989, C:1990-2009
clc;clear;
[a b c]=xlsread('\resilience1950-2009_g.xlsx','1950-2009');
dataA=a(:,1);
dataB=a(:,2);
dataC=a(:,3);
dataAB=dataB-dataA;
dataBC=dataC-dataB;
dataAC=dataC-dataA;
table(:,1)=c(2:end,1);
table(:,2:4)=num2cell([dataAB dataBC dataAC]);
xlswrite('\Temporalchange\resilience_g.xlsx',table,'delta');

clc;clear;
[a b c]=xlsread('\resilience1950-2009_a.xlsx','1950-2009');
dataA=a(:,1);
dataB=a(:,2);
dataC=a(:,3);
dataAB=dataB-dataA;
dataBC=dataC-dataB;
dataAC=dataC-dataA;
table(:,1)=c(2:end,1);
table(:,2:4)=num2cell([dataAB dataBC dataAC]);
xlswrite('\Temporalchange\resilience_a.xlsx',table,'delta');

clc;clear;
[a1 b1 c1]=xlsread('\Temporalchange\resistance_g.xlsx','delta');
resisg5089=a1(:,1);
resisg7009=a1(:,2);
resisg5009=a1(:,3);
[a2 b2 c2]=xlsread('\Temporalchange\resilience_g.xlsx','delta');
resilig5089=a2(:,1);
resilig7009=a2(:,2);
resilig5009=a2(:,3);
percent1=length(find((resisg5089<0&resilig5089>0)|(resisg5089>0&resilig5089<0)))/332;
percent2=length(find((resisg7009<0&resilig7009>0)|(resisg7009>0&resilig7009<0)))/332;
percent3=length(find(resisg5009<0&resilig5009>0|(resisg5009>0&resilig5009<0)))/332;
[R1 P1]=corrcoef(resisg5089,resilig5089);
[R2 P2]=corrcoef(resisg7009,resilig7009);
[R3 P3]=corrcoef(resisg5009,resilig5009);
percent=[percent1 percent2 percent3];
R=[R1 R2 R3];
P=[P1 P2 P3];
point1=[resisg5089 resilig5089];
point2=[resisg7009 resilig7009];
point3=[resisg5009 resilig5009];
save('\Correlation\PeriodCorrg.mat','percent','R','P','point1','point2','point3');
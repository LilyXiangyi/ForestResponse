%% Code for main figures
%% Figure 1
%£¨a£© Spatial pattern of resistance of DS+WS droughts
clc;clear;
load('\resis_dw.mat');
load('\resili_dw.mat');
resis_threshold=[0 5 10 15 20 25 30 35 40];
resili_threshold=[0 1.5 3 4.5 6 7.5 9 10.5 12];
mark_resisg=nan(length(resis_dwg),1);
mark_resisa=nan(length(resis_dwa),1);
mark_resilig=nan(length(resili_dwg),1);
mark_resilia=nan(length(resili_dwa),1);
markcolor_resisg=nan(length(resis_dwg),1);
markcolor_resisa=nan(length(resis_dwa),1);
markcolor_resilig=nan(length(resili_dwg),1);
markcolor_resilia=nan(length(resili_dwa),1);
for i=1:9
    if i<9
        num1=find(resis_dwg>resis_threshold(i)&resis_dwg<=resis_threshold(i+1));
        num2=find(resis_dwa>resis_threshold(i)&resis_dwa<=resis_threshold(i+1));
    else
        num1=find(resis_dwg>40);
        num2=find(resis_dwa>40);
    end
    mark_resisg(num1)=i-0.5;
    mark_resisa(num2)=i-0.5;
end
mapcolor=brewermap(9,'YlOrRd');
markcolor_resisg=mapcolor(ceil(mark_resisg),:);
markcolor_resisa=mapcolor(ceil(mark_resisa),:);

for i=1:9
    if i<9
        num3=find(resili_dwg>resili_threshold(i)&resili_dwg<=resili_threshold(i+1));
        num4=find(resili_dwa>resili_threshold(i)&resili_dwa<=resili_threshold(i+1));
    else
        num3=find(resili_dwg>12);
        num4=find(resili_dwa>12);
    end
    mark_resilig(num3)=i-0.5;
    mark_resilia(num4)=i-0.5;
end
markcolor_resilig=mapcolor(ceil(mark_resilig),:);
markcolor_resilia=mapcolor(ceil(mark_resilia),:);

figure;
a1=axes('position',[0.4 0.5 0.01 0.01]);
plot(1,1,'color',[1 1 1]);
a1.YAxis.Visible = 'off';
a1.XAxis.Visible = 'off';
caxis([0 9]);
colormap(mapcolor);
bar1=colorbar('location','southoutside','position',[0.184+0.2 0.44 0.18 0.012]);
set(bar1,'YTick',[0,1:2:8,8.5],'Yticklabel',{'0','5','15','25','35','>40'},'fontsize',8);
title(bar1,'Rt','fontsize',11,'position',[215 -3.9 0]);

h=worldmap('world');setm(h,'maplatlimit',[-60 90]);
set(h,'position',[0.15+0.2 0.4 0.25 0.3]);
setm(h,'frame','on','grid','off','FLineWidth',1);
set(findall(h,'Tag','PLabel'),'visible','off')
set(findall(h,'Tag','MLabel'),'visible','off')
load coastlines
scatterm(lat_g(1),lon_g(1),23,markcolor_resisg(1,:),'filled','markeredgecolor',[50 50 50]/255,'linewidth',0.5);
hold on;
plotm(coastlat, coastlon,'color',[0.4 0.4 0.4]);
hold on;
scatterm(lat_g(2:2153),lon_g(2:2153),23,markcolor_resisg(2:2153,:),'filled','markeredgecolor',[50 50 50]/255,'linewidth',0.5);
hold on;
scatterm(lat_a,lon_a,22,markcolor_resisa,'filled','markeredgecolor',[50 50 50]/255,'linewidth',0.5,'Marker','^');
title(h,'Mean resistance in DS+WS drought','position',[42,1.0230e7 0]);
text('String','a','Position',[-1.7400e7 1.1400e7 0],'fontsize',12,'fontweight','bold');
print('-dpdf','f1_a.pdf')

%£¨b£© Spatial pattern of resistance of DS+WS droughts
figure
a1=axes('position',[0.4 0.5 0.01 0.01]);
plot(1,1,'color',[1 1 1]);
a1.YAxis.Visible = 'off';
a1.XAxis.Visible = 'off';
caxis([0 9]);
colormap(mapcolor);
bar1=colorbar('location','southoutside','position',[0.184+0.2 0.44 0.18 0.012]);
set(bar1,'YTick',[0,1:2:8,8.5],'Yticklabel',{'0','1.5','4.5','7.5','10.5','>12'},'fontsize',8);
title(bar1,'Rs','fontsize',11,'position',[215 -3.9 0]);

h1=worldmap('world');setm(h1,'maplatlimit',[-60 90]);
set(h1,'position',[0.35 0.4 0.25 0.3]);
setm(h1,'frame','on','grid','off','FLineWidth',1);
set(findall(h1,'Tag','PLabel'),'visible','off')
set(findall(h1,'Tag','MLabel'),'visible','off')
load coastlines
scatterm(lat_g(1),lon_g(1),23,markcolor_resilig(1,:),'filled','markeredgecolor',[50 50 50]/255,'linewidth',0.5);
hold on;
plotm(coastlat, coastlon,'color',[0.4 0.4 0.4]);
hold on;
scatterm(lat_g(2:2153),lon_g(2:2153),23,markcolor_resilig(2:2153,:),'filled','markeredgecolor',[50 50 50]/255,'linewidth',0.5);
hold on;
scatterm(lat_a,lon_a,22,markcolor_resilia,'filled','markeredgecolor',[50 50 50]/255,'linewidth',0.1,'Marker','^');
title(h1,'Mean resilience in DS+WS drought','position',[42,1.0230e7 0]);
text('String','b','Position',[-1.7400e7 1.1400e7 0],'fontsize',12,'fontweight','bold');
print('-dpdf','f1_b.pdf')

% (c)Mean ln-transformed resistance
clc;clear;
dataresis=nan(3000,6);
dataresili=nan(3000,6);
[a,~,~]=xlsread('\siteinfo_brt_dsg.xlsx');
logresisdsg=a(:,19);
logresilidsg=a(:,20);
dataresis(1:length(logresisdsg),1)=logresisdsg;
dataresili(1:length(logresilidsg),1)=logresilidsg;
clear a;
[a,~,~]=xlsread('\siteinfo_brt_dsa.xlsx');
logresisdsa=a(:,19);
logresilidsa=a(:,20);
dataresis(1:length(logresisdsa),2)=logresisdsa;
dataresili(1:length(logresilidsa),2)=logresilidsa;

[a,~,~]=xlsread('\siteinfo_brt_wsg.xlsx');
logresiswsg=a(:,19);
logresiliwsg=a(:,20);
dataresis(1:length(logresiswsg),3)=logresiswsg;
dataresili(1:length(logresiliwsg),3)=logresiliwsg;
clear a;
[a,~,~]=xlsread('\siteinfo_brt_wsa.xlsx');
logresiswsa=a(:,19);
logresiliwsa=a(:,20);
dataresis(1:length(logresiswsa),4)=logresiswsa;
dataresili(1:length(logresiliwsa),4)=logresiliwsa;

[a,~,~]=xlsread('\siteinfo_brt_dwg.xlsx');
logresisdwg=a(:,19);
logresilidwg=a(:,20);
dataresis(1:length(logresisdwg),5)=logresisdwg;
dataresili(1:length(logresilidwg),5)=logresilidwg;
clear a;
[a,~,~]=xlsread('\siteinfo_brt_dwa.xlsx');
logresisdwa=a(:,19);
logresilidwa=a(:,20);
dataresis(1:length(logresisdwa),6)=logresisdwa;
dataresili(1:length(logresilidwa),6)=logresilidwa;
clearvars -except dataresis dataresis1 dataresili dataresili1

% resistance
data_int=nan(8,6);
for i=1:6
    data=dataresis(:,i);
    data1=data(~isnan(data));
    data_int(2,i)=quantile(data1,0.75);
    data_int(6,i)=quantile(data1,0.25);
    maxabnorm=2.5*quantile(data1,0.75)-1.5*quantile(data1,0.25);
    minabnorm=2.5*quantile(data1,0.25)-1.5*quantile(data1,0.75);
    data2=data1(data1>=minabnorm&data1<=maxabnorm);
    data_int(1,i)=max(data2);
    data_int(7,i)=min(data2); 
    data_int(3,i)=quantile(data1,0.6);
    data_int(4,i)=median(data1);
    data_int(5,i)=quantile(data1,0.4);
    data_int(8,i)=mean(data1);
end
datamean=nanmean(data_int(8,:));
line_color=brewermap(10,'paired');color1=brewermap(12,'RdBu');

figure;
%a1=axes('position',[0.31 0.37 0.315 0.413]);
a1=axes('position',[0.31 0.37 0.2 0.25]);
plot([0 6.3],[datamean datamean],'--','linewidth',1.5,'color',[0.7 0.7 0.7]);
hold on;
for i=1:3
    plot([0.7 0.7]+2*(i-1),[data_int(6,1+(i-1)*2) data_int(7,1+(i-1)*2)],'Color',line_color(8,:),'linewidth',1);
    hold on
    plot([0.7 0.7]+2*(i-1),[data_int(1,1+(i-1)*2) data_int(2,1+(i-1)*2)],'Color',line_color(8,:),'linewidth',1);
    patch([0.5 0.5 0.9 0.9 0.5]+2*(i-1),[data_int(2,1+(i-1)*2) data_int(6,1+(i-1)*2) data_int(6,1+(i-1)*2) data_int(2,1+(i-1)*2) data_int(2,1+(i-1)*2)],ones(1,5),'FaceColor',line_color(7,:),'FaceAlpha',0.8,'edgecolor','none');
    patch([0.5 0.5 0.9 0.9 0.5]+2*(i-1),[data_int(3,1+(i-1)*2) data_int(5,1+(i-1)*2) data_int(5,1+(i-1)*2) data_int(3,1+(i-1)*2) data_int(3,1+(i-1)*2)],ones(1,5),'FaceColor',line_color(8,:),'FaceAlpha',0.25,'edgecolor','none');
    plot([0.5 0.9]+2*(i-1),[data_int(4,1+(i-1)*2) data_int(4,1+(i-1)*2)],'Color',line_color(8,:),'linewidth',1.5);
    hold on;
    plot(0.7+2*(i-1),data_int(8,1+(i-1)*2),'^','Color',line_color(8,:),'linewidth',1.5,'linestyle','none')
    
    plot([1.3 1.3]+2*(i-1),[data_int(6,2+(i-1)*2) data_int(7,2+(i-1)*2)],'Color',line_color(2,:),'linewidth',1);
    hold on
    plot([1.3 1.3]+2*(i-1),[data_int(1,2+(i-1)*2) data_int(2,2+(i-1)*2)],'Color',line_color(2,:),'linewidth',1);
    patch([1.1 1.1 1.5 1.5 1.5]+2*(i-1),[data_int(2,2+(i-1)*2) data_int(6,2+(i-1)*2) data_int(6,2+(i-1)*2) data_int(2,2+(i-1)*2) data_int(2,2+(i-1)*2)],ones(1,5),'FaceColor',line_color(1,:),'FaceAlpha',0.8,'edgecolor','none');
    patch([1.1 1.1 1.5 1.5 1.5]+2*(i-1),[data_int(3,2+(i-1)*2) data_int(5,2+(i-1)*2) data_int(5,2+(i-1)*2) data_int(3,2+(i-1)*2) data_int(3,2+(i-1)*2)],ones(1,5),'FaceColor',line_color(2,:),'FaceAlpha',0.25,'edgecolor','none');
    plot([1.1 1.5]+2*(i-1),[data_int(4,2+(i-1)*2) data_int(4,2+(i-1)*2)],'Color',line_color(2,:),'linewidth',1.5);
    hold on;
    plot(1.3+2*(i-1),data_int(8,2+(i-1)*2),'^','Color',line_color(2,:),'linewidth',1.5,'linestyle','none')
end
ylabel('ln(Rt)'); 
xlabel('Drought timings');
set(gca,'fontsize',11,'xtick',[1 3 5],'xticklabel',{'DS','WS','DS + WS'})
xlim([0 6.3]);ylim([0 7]);set(gca,'ytick',0:2:6);
hold on;
plot([2.7 2.8], [4.8 4.85]+0.5, '-k','color',line_color(8,:),'linewidth',1.5);
hold on;plot([2.8 3], [4.85 4.85]+0.5, '-k','color',line_color(8,:),'linewidth',1.5);
hold on;plot([3.2 3.3], [4.85 4.8]+0.5, '-k','color',line_color(2,:),'linewidth',1.5);
hold on;plot([3 3.2], [4.85 4.85]+0.5, '-k','color',line_color(2,:),'linewidth',1.5);
text(2.95,4.95+0.5,'*','color',[0.31 0.31 0.31],'fontsize',20);
hold on;
plot([2.7 2.8]+2, [4.8 4.85]+0.5, '-k','color',line_color(8,:),'linewidth',1.5);
hold on;plot([2.8 3]+2, [4.85 4.85]+0.5, '-k','color',line_color(8,:),'linewidth',1.5);
hold on;plot([3.2 3.3]+2, [4.85 4.8]+0.5, '-k','color',line_color(2,:),'linewidth',1.5);
hold on;plot([3 3.2]+2, [4.85 4.85]+0.5, '-k','color',line_color(2,:),'linewidth',1.5);
text(3.95+1,4.95+0.5,'*','color',[0.31 0.31 0.31],'fontsize',20);

text(5.7,data_int(1,6),'Max','fontsize',8,'fontweight','bold');
hold on; plot([5.3,5.7],[data_int(1,6) data_int(1,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(7,6),'Min','fontsize',8,'fontweight','bold');
hold on; plot([5.3,5.7],[data_int(7,6) data_int(7,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(3,6),'Q_{0.6}','fontsize',8,'fontweight','bold');
hold on; plot([5.5,5.7],[data_int(3,6) data_int(3,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(5,6),'Q_{0.4}','fontsize',8,'fontweight','bold');
hold on; plot([5.5,5.7],[data_int(5,6) data_int(5,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(2,6),'Q_{0.75}','fontsize',8,'fontweight','bold');
hold on; plot([5.5,5.7],[data_int(2,6) data_int(2,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(6,6),'Q_{0.25}','fontsize',8,'fontweight','bold');
hold on; plot([5.5,5.7],[data_int(6,6) data_int(6,6)],'--','color',line_color(2,:),'linewidth',0.5)
title('Mean ln-transformed resistance','Position',[3.05 7.4 0]);
tx=text('String','c','Position',[-0.68 7.8 0],'fontsize',12,'fontweight','bold');

a2=axes('position',[0.313 0.555 0.082 0.057]);xlim([0 10]); ylim([0 10]);
x=[0,2,2,0,0];
y=[7,7,10,10,7];
r=patch(x,y,line_color(7,:),'linewidth',0.1);text(2.5,8.8,'Gymnosperms');
x=[0,2,2,0,0];
y=[1,1,4,4,1];
r1=patch(x,y,line_color(1,:),'linewidth',0.1);text(2.5,2.8,'Angiosperms');
a2.XAxis.Visible = 'off';a2.YAxis.Visible = 'off';
print('-dpdf','f1_c.pdf')

% resilience
data_int=nan(8,6);
for i=1:6
    data=dataresili(:,i);
    data1=data(~isnan(data));
    data_int(2,i)=quantile(data1,0.75);
    data_int(6,i)=quantile(data1,0.25);
    maxabnorm=2.5*quantile(data1,0.75)-1.5*quantile(data1,0.25);
    minabnorm=2.5*quantile(data1,0.25)-1.5*quantile(data1,0.75);
    data2=data1(data1>=minabnorm&data1<=maxabnorm);
%     data_int(1,i)=2.5*quantile(data1,0.75)-1.5*quantile(data1,0.25);
%     data_int(7,i)=2.5*quantile(data1,0.25)-1.5*quantile(data1,0.75); 
    data_int(1,i)=max(data2);
    data_int(7,i)=min(data2); 
    data_int(3,i)=quantile(data1,0.6);
    data_int(4,i)=median(data1);
    data_int(5,i)=quantile(data1,0.4);
    data_int(8,i)=mean(data1);
end
datamean=nanmean(data_int(8,:));
line_color=brewermap(10,'paired');color1=brewermap(12,'RdBu');
figure;
%a1=axes('position',[0.31 0.37 0.315 0.413]);
a1=axes('position',[0.31 0.37 0.2 0.25]);
plot([0 6.3],[datamean datamean],'--','linewidth',1.5,'color',[0.7 0.7 0.7]);hold on;
for i=1:3
    plot([0.7 0.7]+2*(i-1),[data_int(6,1+(i-1)*2) data_int(7,1+(i-1)*2)],'Color',line_color(8,:),'linewidth',1);
    hold on
    plot([0.7 0.7]+2*(i-1),[data_int(1,1+(i-1)*2) data_int(2,1+(i-1)*2)],'Color',line_color(8,:),'linewidth',1);
    patch([0.5 0.5 0.9 0.9 0.5]+2*(i-1),[data_int(2,1+(i-1)*2) data_int(6,1+(i-1)*2) data_int(6,1+(i-1)*2) data_int(2,1+(i-1)*2) data_int(2,1+(i-1)*2)],ones(1,5),'FaceColor',line_color(7,:),'FaceAlpha',0.8,'edgecolor','none');
    patch([0.5 0.5 0.9 0.9 0.5]+2*(i-1),[data_int(3,1+(i-1)*2) data_int(5,1+(i-1)*2) data_int(5,1+(i-1)*2) data_int(3,1+(i-1)*2) data_int(3,1+(i-1)*2)],ones(1,5),'FaceColor',line_color(8,:),'FaceAlpha',0.25,'edgecolor','none');
    plot([0.5 0.9]+2*(i-1),[data_int(4,1+(i-1)*2) data_int(4,1+(i-1)*2)],'Color',line_color(8,:),'linewidth',1.5);
    hold on;
    plot(0.7+2*(i-1),data_int(8,1+(i-1)*2),'^','Color',line_color(8,:),'linewidth',1.5,'linestyle','none')
    
    plot([1.3 1.3]+2*(i-1),[data_int(6,2+(i-1)*2) data_int(7,2+(i-1)*2)],'Color',line_color(2,:),'linewidth',1);
    hold on
    plot([1.3 1.3]+2*(i-1),[data_int(1,2+(i-1)*2) data_int(2,2+(i-1)*2)],'Color',line_color(2,:),'linewidth',1);
    patch([1.1 1.1 1.5 1.5 1.5]+2*(i-1),[data_int(2,2+(i-1)*2) data_int(6,2+(i-1)*2) data_int(6,2+(i-1)*2) data_int(2,2+(i-1)*2) data_int(2,2+(i-1)*2)],ones(1,5),'FaceColor',line_color(1,:),'FaceAlpha',0.8,'edgecolor','none');
    patch([1.1 1.1 1.5 1.5 1.5]+2*(i-1),[data_int(3,2+(i-1)*2) data_int(5,2+(i-1)*2) data_int(5,2+(i-1)*2) data_int(3,2+(i-1)*2) data_int(3,2+(i-1)*2)],ones(1,5),'FaceColor',line_color(2,:),'FaceAlpha',0.25,'edgecolor','none');
    plot([1.1 1.5]+2*(i-1),[data_int(4,2+(i-1)*2) data_int(4,2+(i-1)*2)],'Color',line_color(2,:),'linewidth',1.5);
    hold on;
    plot(1.3+2*(i-1),data_int(8,2+(i-1)*2),'^','Color',line_color(2,:),'linewidth',1.5,'linestyle','none')
    
end
ylabel('ln(Rs)'); 
xlabel('Drought timings');
set(gca,'fontsize',11,'xtick',[1 3 5],'xticklabel',{'DS','WS','DS + WS'})
xlim([0 6.3]);ylim([-3 5.5]);set(gca,'ytick',-2:2:4);

text(5.7,data_int(1,6),'Max','fontsize',8,'fontweight','bold');
hold on; plot([5.3,5.7],[data_int(1,6) data_int(1,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(7,6),'Min','fontsize',8,'fontweight','bold');
hold on; plot([5.3,5.7],[data_int(7,6) data_int(7,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(3,6),'Q_{0.6}','fontsize',8,'fontweight','bold');
hold on; plot([5.5,5.7],[data_int(3,6) data_int(3,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(5,6),'Q_{0.4}','fontsize',8,'fontweight','bold');
hold on; plot([5.5,5.7],[data_int(5,6) data_int(5,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(2,6),'Q_{0.75}','fontsize',8,'fontweight','bold');
hold on; plot([5.5,5.7],[data_int(2,6) data_int(2,6)],'--','color',line_color(2,:),'linewidth',0.5)
text(5.7,data_int(6,6),'Q_{0.25}','fontsize',8,'fontweight','bold');
hold on; plot([5.5,5.7],[data_int(6,6) data_int(6,6)],'--','color',line_color(2,:),'linewidth',0.5)
title('Mean ln-transformed resilience','Position',[3.05 5.9 0]);
tx=text('String','d','Position',[-0.68 6.3 0],'fontsize',12,'fontweight','bold');

a2=axes('position',[0.313 0.555 0.082 0.057]);xlim([0 10]); ylim([0 10]);
x=[0,2,2,0,0];
y=[7,7,10,10,7];
r=patch(x,y,line_color(7,:),'linewidth',0.1);text(2.5,8.8,'Gymnosperms');
x=[0,2,2,0,0];
y=[1,1,4,4,1];
r1=patch(x,y,line_color(1,:),'linewidth',0.1);text(2.5,2.8,'Angiosperms');
a2.XAxis.Visible = 'off';a2.YAxis.Visible = 'off';
print('-dpdf','f1_d.pdf')

%% Figure 2 
% results estimated by BRT
% a. resistance 
clc;clear;
%colortext(1:4,:)=repmat([51 153 51]./255,4,1);% color for environmental factors
colortext(1:4,:)=repmat([0 0 0],4,1);% color for environmental factors
colortext(5:10,:)=repmat([0.87 0.49 0],6,1);% color for hydraulic traits
colortext(11:13,:)=repmat([0.4941 0.1843 0.5597],3,1);% color for folair traits
colortext(14,:)=[153 102 0]./255;% color for stem density
colortext(15,:)=[41 148 255]./255; % color for drought severity
colortext(16,:)=[255 57 42]/255;% color for age

load('\BRT\Contribution\ResisMatrix.mat');
colorbar0=brewermap(10,'PuBuGn');
colorbar1(1,:)=[0.7 0.7 0.7];
colorbar1(2:6,:)=colorbar0([1,3,5,7,8],:);
var_origin(1:16,1)={'TEMP','PREC','CEC','AWC','Isohydricity','P50','HSM','Height','RootingDepth','WD',...
   'SLA','Pm','Nm','StemDensity','Intensity','Age'};
var(1:16,1)={'TEMP','PREC','CEC','AWC','Isohydricity','P50','HSM','Height','Rooting depth','WD',...
   'SLA','Pm','Nm','Tree density','Severity','Age'};
mark=zeros(16,6);
for ncol=1:6
    data_col=contri(:,ncol);
    datasort=sort(data_col,'descend');
    datasort1=datasort;
    datasort1(isnan(datasort1))=[];
    num1=find(data_col==datasort1(1));
    num2=find(data_col==datasort1(2));
    num3=find(data_col==datasort1(3));
    mark([num1,num2,num3],ncol)=1;
end

figure;
ax=axes('position',[0.16+0.2 0.425-0.2 0.15 0.515]);
for i=1:6
    for j=1:16
        if ~isnan(contri(j,i))
            if contri(j,i)>=0&contri(j,i)<3
               color_num=2;
            elseif contri(j,i)>=3&contri(j,i)<6
                color_num=3;
            elseif contri(j,i)>=6&contri(j,i)<9
                color_num=4;
             elseif contri(j,i)>=9&contri(j,i)<12
                color_num=5;
              elseif contri(j,i)>=12
                  color_num=6;
            end
        else
             color_num=1;
        end
        x=[i-0.47+0.05*(6-color_num),i+0.47-0.05*(6-color_num),i+0.47-0.05*(6-color_num),i-0.47+0.05*(6-color_num),i-0.47+0.05*(6-color_num)];
        y=[j-0.47+0.05*(6-color_num),j-0.47+0.05*(6-color_num),j+0.47-0.05*(6-color_num),j+0.47-0.05*(6-color_num),j-0.47+0.05*(6-color_num)];
        r=patch(x,y,colorbar1(color_num,:),'linewidth',1);
        set(r,'EdgeColor',[1 1 1]);
        if contri(j,i)>6&contri(j,i)<9
           text(i-0.24,j,num2str(contri(j,i),'%.1f'),'fontsize',8);
        elseif contri(j,i)>=9
           text(i-0.24,j,num2str(contri(j,i),'%.1f'),'fontsize',8,'fontweight','bold'); 
        end
    end
end
set(gca,'Box','on','XLim',[0.35 6.65],'YLim',[0.35 16.65]);
set(gca,'xtick',1:6,'ytick',1:16);
caxis([1 6]);
colormap(gca,colorbar1(2:end,:));
set(gca,'yticklabel',var);
for i = 1:16
    ax.YTickLabel{i} = sprintf('\\color[rgb]{%f,%f,%f}%s', colortext(i,:), ax.YTickLabel{i});
end
set(gca,'xticklabel',{'DS_G','DS_A','WS_G','WS_A','DS+WS_G','DS+WS_A'},...
    'xticklabelrotation',90,'fontsize',9.5);
h1=colorbar('position',[0.317+0.2 0.426-0.2 0.006 0.49],'xtick',[1:1:6],'xticklabel',{'0','3','6','9','12','18'});
annotation('textbox','position',[0.3118+0.2 0.93-0.2 0.012 0.021],'string','%','edgecolor','none');
title('Relative contributions to resistance',...
         'Position',[3.5 17 0],'fontsize',12);
text('String','a','fontweight','bold','fontsize',12,'Position',[-1.75 17.5 0]);

% b. resilience
clc;clear;
%colortext(1:4,:)=repmat([51 153 51]./255,4,1);% color for environmental factors
colortext(1:4,:)=repmat([0 0 0],4,1);% color for environmental factors
colortext(5:10,:)=repmat([0.87 0.49 0],6,1);% color for hydraulic traits
colortext(11:13,:)=repmat([0.4941 0.1843 0.5597],3,1);% color for folair traits
colortext(14,:)=[153 102 0]./255;% color for stem density
colortext(15,:)=[41 148 255]./255; % color for drought severity
colortext(16,:)=[255 57 42]/255;% color for age

load('\BRT\Contribution\ResiliMatrix.mat');
colorbar0=brewermap(10,'PuBuGn');
colorbar1(1,:)=[0.7 0.7 0.7];
colorbar1(2:6,:)=colorbar0([1,3,5,7,8],:);
var_origin(1:16,1)={'TEMP','PREC','CEC','AWC','Isohydricity','P50','HSM','Height','RootingDepth','WD',...
   'SLA','Pm','Nm','StemDensity','Intensity','Age'};
var(1:16,1)={'TEMP','PREC','CEC','AWC','Isohydricity','P50','HSM','Height','Rooting depth','WD',...
   'SLA','Pm','Nm','Tree density','Severity','Age'};
mark=zeros(16,6);
for ncol=1:6
    data_col=contri(:,ncol);
    datasort=sort(data_col,'descend');
    datasort1=datasort;
    datasort1(isnan(datasort1))=[];
    num1=find(data_col==datasort1(1));
    num2=find(data_col==datasort1(2));
    num3=find(data_col==datasort1(3));
    mark([num1,num2,num3],ncol)=1;
end
ax=axes('position',[0.16+0.2 0.425-0.2 0.15 0.515]);
for i=1:6
    for j=1:16
        if ~isnan(contri(j,i))
            if contri(j,i)>=0&contri(j,i)<3
               color_num=2;
            elseif contri(j,i)>=3&contri(j,i)<6
                color_num=3;
            elseif contri(j,i)>=6&contri(j,i)<9
                color_num=4;
             elseif contri(j,i)>=9&contri(j,i)<12
                color_num=5;
              elseif contri(j,i)>=12
                  color_num=6;
            end
        else
             color_num=1;
        end
       x=[i-0.47+0.05*(6-color_num),i+0.47-0.05*(6-color_num),i+0.47-0.05*(6-color_num),i-0.47+0.05*(6-color_num),i-0.47+0.05*(6-color_num)];
        y=[j-0.47+0.05*(6-color_num),j-0.47+0.05*(6-color_num),j+0.47-0.05*(6-color_num),j+0.47-0.05*(6-color_num),j-0.47+0.05*(6-color_num)];
        r=patch(x,y,colorbar1(color_num,:),'linewidth',1);
        set(r,'EdgeColor',[1 1 1]);
        if contri(j,i)>6&contri(j,i)<9
           text(i-0.24,j,num2str(contri(j,i),'%.1f'),'fontsize',8);
        elseif contri(j,i)>=9
           text(i-0.24,j,num2str(contri(j,i),'%.1f'),'fontsize',8,'fontweight','bold'); 
        end
    end
end
set(gca,'Box','on','XLim',[0.35 6.65],'YLim',[0.35 16.65]);
set(gca,'xtick',1:6,'ytick',1:16);
caxis([1 6]);
colormap(gca,colorbar1(2:end,:));
set(gca,'yticklabel',var);
for i = 1:16
    ax.YTickLabel{i} = sprintf('\\color[rgb]{%f,%f,%f}%s', colortext(i,:), ax.YTickLabel{i});
end
set(gca,'xticklabel',{'DS_G','DS_A','WS_G','WS_A','DS+WS_G','DS+WS_A'},...
    'xticklabelrotation',90,'fontsize',9.5);
h1=colorbar('position',[0.317+0.2 0.426-0.2 0.006 0.49],'xtick',[1:1:6],'xticklabel',{'0','3','6','9','12','18'});
annotation('textbox','position',[0.3118+0.2 0.93-0.2 0.012 0.021],'string','%','edgecolor','none');
title('Relative contributions to resilience',...
         'Position',[3.5 17 0],'fontsize',12);
text('String','b','fontweight','bold','fontsize',12,'Position',[-1.75 17.5 0]);

%% Figure 3
% (a) Gymnosperm resistance
clc;clear;
figure;
figcolor=[69 118 191;232 136 49;128 54 168]./255;
color1=brewermap(12,'paired');
[a1 b1 c1]=xlsread('\resistance1950-2009_g.xlsx','1950-2009'); 
D1=a1(:,2)-a1(:,1);
D2=a1(:,3)-a1(:,1);
ax=axes('position',[0.31 0.37 0.2 0.3]);
yyaxis left;
[h1,centers]=hist(a1(:,1),0:0.1:9);
bar(centers,h1,'facecolor',figcolor(1,:),'edgecolor','w','FaceAlpha',0.5);
hold on;
[h2,centers]=hist(a1(:,2),0:0.1:9);
bar(centers,h2,'facecolor',figcolor(2,:),'edgecolor','w','FaceAlpha',0.5);
hold on;
[h3,centers]=hist(a1(:,3),0:0.1:9);
bar(centers,h3,'facecolor',figcolor(3,:),'edgecolor','w','FaceAlpha',0.5);
ylim([0 35]);set(ax,'Ycolor',[0 0 0],'ytick',0:10:35);
ylabel('Number of gymnosperm sites','fontsize',12);xlabel('ln(Rt+1)','fontsize',12);
text(0.6,22.5,'¦¤ln(Rt+1) relative to 1950-1969','fontsize',9);

pd = fitdist(a1(:,1),'Kernel','Kernel','epanechnikov');
pd1 = fitdist(a1(:,2),'Kernel','Kernel','epanechnikov');
pd2= fitdist(a1(:,3),'Kernel','Kernel','epanechnikov');
x_values = 0:0.1:9;
y= pdf(pd,x_values);y1= pdf(pd1,x_values);y2= pdf(pd2,x_values);
yyaxis right;
hold on
plot(x_values,y,'-','color',figcolor(1,:),'linewidth',1.5);
hold on
plot(x_values,y1,'-','color',figcolor(2,:),'linewidth',1.5);
hold on
plot(x_values,y2,'-','color',figcolor(3,:),'linewidth',1.5);
xlim([0 5.5]);ylim([0 0.875]);
set(ax,'Ycolor',[0 0 0],'ytick',0:0.25:0.875);
ylabel('Kernel density','fontsize',12);
hold on;
plot([0 5.5],[0 0],'-k','linewidth',1);
title(ax,'Temporal change of gymnosperm resistance','fontsize',12,'position',[2.68 37 -0.5]);
text(ax,'String','a','fontweight','bold','fontsize',12,'position',[-0.6 0.971 -0.5]);

ax1=axes('position',[0.347 0.598 0.079 0.068]);
plot([0 0],[0.7 1.3],'-','color',[232 221 73]./255,'linewidth',1);hold on;
b_h1=boxplotCsub(D1,0,[''],0,1,'k',true,1,false,[1,2],2.4,0.05,'.');
b_h2=boxplotCsub(D2,0,[''],0,1,'k',true,1,false,[2,2],2.4,0.05,'.');
set(b_h1(6,1),'Color',[232 221 73]./255,'linewidth',1.5);
set(b_h1(9,1),'Color',color1(8,:),'linewidth',1.5,'markersize',10);
set(b_h1(3:4,1),'Color','w');
set(b_h1([1:2,5],1),'Color',color1(8,:),'linewidth',1.5,'linestyle','-');
set(b_h1(8,1),'facecolor',color1(7,:));
set(b_h2(6,1),'Color',[232 221 73]./255,'linewidth',1.5);
set(b_h2(9,1),'Color',color1(10,:),'linewidth',1.5,'markersize',10);
set(b_h2(3:4,1),'Color','w');
set(b_h2([1:2,5],1),'Color',color1(10,:),'linewidth',1.5,'linestyle','-');
set(b_h2(8,1),'facecolor',color1(9,:));
xlim([-2 2]);ylim([0.7 1.3])
xlabel('');ylabel('') 
set(ax1,'xtick',-2:2:2,'ytick',[0.9,1.1],'yticklabel',{'1970-1989','1990-2009'});
ax1.YTickLabel{1} = sprintf('\\color[rgb]{%f,%f,%f}%s', color1(8,:), ax1.YTickLabel{1});
ax1.YTickLabel{2} = sprintf('\\color[rgb]{%f,%f,%f}%s', color1(10,:), ax1.YTickLabel{2});
text(1.6,1.07,'*','color',color1(10,:),'fontsize',12,'fontweight','bold');
text(0.5,1.19,'(+) 41%','color',color1(10,:),'fontweight','bold','fontsize',8);
text(-1.5,1.19,'(-) 59%','color',color1(10,:),'fontweight','bold','fontsize',8);
text(0.5,0.82,'(+) 44%','color',color1(8,:),'fontweight','bold','fontsize',8);
text(-1.5,0.82,'(-) 56%','color',color1(8,:),'fontweight','bold','fontsize',8);
set(ax1,'fontsize',8);

ax2=axes('position',[0.431 0.57 0.076 0.079]);
plot(ax2,2,9,'.','color',figcolor(1,:),'markersize',20);
text(3.3,9.1,'1950-1969','fontsize',10);
hold on;
plot(ax2,2,5.5,'.','color',figcolor(2,:),'markersize',20);
text(3.3,5.6,'1970-1989','fontsize',10);
hold on;
plot(ax2,2,2,'.','color',figcolor(3,:),'markersize',20);
text(3.3,2.1,'1990-2009','fontsize',10);
xlim([0 10]); ylim([0 10]);
ax2.XAxis.Visible = 'off';
ax2.YAxis.Visible = 'off';

% (b) Angiosperm resistance
clc;clear;
figure;
figcolor=[69 118 191;232 136 49;128 54 168]./255;
color1=brewermap(12,'paired');
[a1 b1 c1]=xlsread('\resistance1950-2009_a.xlsx','1950-2009'); 
D1=a1(:,2)-a1(:,1);
D2=a1(:,3)-a1(:,1);
ax=axes('position',[0.31 0.37 0.2 0.3]);
yyaxis left;
[h1,centers]=hist(a1(:,1),0:0.1:9);
bar(centers,h1,'facecolor',figcolor(1,:),'edgecolor','w','FaceAlpha',0.5);
hold on;
[h2,centers]=hist(a1(:,2),0:0.1:9);
bar(centers,h2,'facecolor',figcolor(2,:),'edgecolor','w','FaceAlpha',0.5);
hold on;
[h3,centers]=hist(a1(:,3),0:0.1:9);
bar(centers,h3,'facecolor',figcolor(3,:),'edgecolor','w','FaceAlpha',0.5);
ylim([0 12]);set(ax,'Ycolor',[0 0 0],'ytick',0:3:12);
ylabel('Number of angiosperm sites','fontsize',12);xlabel('ln(Rt+1)','fontsize',12);
text(0.6,7.6,'¦¤ln(Rt+1) relative to 1950-1969','fontsize',9);

pd = fitdist(a1(:,1),'Kernel','Kernel','epanechnikov');
pd1 = fitdist(a1(:,2),'Kernel','Kernel','epanechnikov');
pd2= fitdist(a1(:,3),'Kernel','Kernel','epanechnikov');
x_values = 0:0.1:9;
y= pdf(pd,x_values);y1= pdf(pd1,x_values);y2= pdf(pd2,x_values);
yyaxis right;
hold on
plot(x_values,y,'-','color',figcolor(1,:),'linewidth',1.5);
hold on
plot(x_values,y1,'-','color',figcolor(2,:),'linewidth',1.5);
hold on
plot(x_values,y2,'-','color',figcolor(3,:),'linewidth',1.5);
xlim([0 5.5]);ylim([0 1]);
set(ax,'Ycolor',[0 0 0],'ytick',0:0.25:1);
ylabel('Kernel density','fontsize',12);
hold on;
plot([0 5.5],[0 0],'-k','linewidth',1);
title(ax,'Temporal change of angiosperm resistance','fontsize',12,'position',[2.68 12.7 -0.5]);
t=text(ax,'String','b','fontweight','bold','fontsize',12,'position',[-0.6 1.1 -0.5]);

ax1=axes('position',[0.347 0.598 0.079 0.068]);
plot([0 0],[0.7 1.3],'-','color',[232 221 73]./255,'linewidth',1);hold on;
b_h1=boxplotCsub(D1,0,[''],0,1,'k',true,1,false,[1,2],2.4,0.05,'.');
b_h2=boxplotCsub(D2,0,[''],0,1,'k',true,1,false,[2,2],2.4,0.05,'.');
set(b_h1(6,1),'Color',[232 221 73]./255,'linewidth',1.5);
set(b_h1(9,1),'Color',color1(8,:),'linewidth',1.5,'markersize',10);
set(b_h1(3:4,1),'Color','w');
set(b_h1([1:2,5],1),'Color',color1(8,:),'linewidth',1.5,'linestyle','-');
set(b_h1(8,1),'facecolor',color1(7,:));
set(b_h2(6,1),'Color',[232 221 73]./255,'linewidth',1.5);
set(b_h2(9,1),'Color',color1(10,:),'linewidth',1.5,'markersize',10);
set(b_h2(3:4,1),'Color','w');
set(b_h2([1:2,5],1),'Color',color1(10,:),'linewidth',1.5,'linestyle','-');
set(b_h2(8,1),'facecolor',color1(9,:));
xlim([-2.2 2]);ylim([0.7 1.3])
xlabel('');ylabel('') 
set(ax1,'xtick',-2:2:2,'ytick',[0.9,1.1],'yticklabel',{'1970-1989','1990-2009'});
ax1.YTickLabel{1} = sprintf('\\color[rgb]{%f,%f,%f}%s', color1(6,:), ax1.YTickLabel{1});
ax1.YTickLabel{2} = sprintf('\\color[rgb]{%f,%f,%f}%s', color1(10,:), ax1.YTickLabel{2});
text(0.5,1.19,'(+) 52%','color',color1(10,:),'fontweight','bold','fontsize',8);
text(-1.5,1.19,'(-) 48%','color',color1(10,:),'fontweight','bold','fontsize',8);
text(0.5,0.82,'(+) 46%','color',color1(8,:),'fontweight','bold','fontsize',8);
text(-1.5,0.82,'(-) 54%','color',color1(8,:),'fontweight','bold','fontsize',8);
set(ax1,'fontsize',8);

ax2=axes('position',[0.431 0.57 0.076 0.079]);
plot(ax2,2,9,'.','color',figcolor(1,:),'markersize',20);
text(3.3,9.1,'1950-1969','fontsize',10);
hold on;
plot(ax2,2,5.5,'.','color',figcolor(2,:),'markersize',20);
text(3.3,5.6,'1970-1989','fontsize',10);
hold on;
plot(ax2,2,2,'.','color',figcolor(3,:),'markersize',20);
text(3.3,2.1,'1990-2009','fontsize',10);
xlim([0 10]); ylim([0 10]);
ax2.XAxis.Visible = 'off';
ax2.YAxis.Visible = 'off';

% (c) Gymnosperm resilience
clc;clear;
figure;
figcolor=[69 118 191;232 136 49;128 54 168]./255;
color1=brewermap(12,'paired');
[a1 b1 c1]=xlsread('\resilience_g.xlsx','1950-2009'); 
D1=a1(:,2)-a1(:,1);
D2=a1(:,3)-a1(:,1);
ax=axes('position',[0.31 0.37 0.2 0.3]);
yyaxis left;
[h1,centers]=hist(a1(:,1),0:0.1:9);
bar(centers,h1,'facecolor',figcolor(1,:),'edgecolor','w','FaceAlpha',0.5);
hold on;
[h2,centers]=hist(a1(:,2),0:0.1:9);
bar(centers,h2,'facecolor',figcolor(2,:),'edgecolor','w','FaceAlpha',0.5);
hold on;
[h3,centers]=hist(a1(:,3),0:0.1:9);
bar(centers,h3,'facecolor',figcolor(3,:),'edgecolor','w','FaceAlpha',0.5);
ylim([0 35]);set(ax,'Ycolor',[0 0 0],'ytick',0:10:35);
ylabel('Number of gymnosperm sites','fontsize',12);xlabel('ln(Rs+1)','fontsize',12);
text(0.6,22.5,'¦¤ln(Rs+1) relative to 1950-1969','fontsize',9);

pd = fitdist(a1(:,1),'Kernel','Kernel','epanechnikov');
pd1 = fitdist(a1(:,2),'Kernel','Kernel','epanechnikov');
pd2= fitdist(a1(:,3),'Kernel','Kernel','epanechnikov');
x_values = 0:0.1:9;
y= pdf(pd,x_values);y1= pdf(pd1,x_values);y2= pdf(pd2,x_values);
yyaxis right;
hold on
plot(x_values,y,'-','color',figcolor(1,:),'linewidth',1.5);
hold on
plot(x_values,y1,'-','color',figcolor(2,:),'linewidth',1.5);
hold on
plot(x_values,y2,'-','color',figcolor(3,:),'linewidth',1.5);
xlim([0 4]);ylim([0 0.875]);
set(ax,'Ycolor',[0 0 0],'ytick',0:0.25:0.875);
ylabel('Kernel density','fontsize',12);
hold on;
plot([0 4],[0 0],'-k','linewidth',1);
title(ax,'Temporal change of gymnosperm resilience','fontsize',12,'position',[1.9769 37 -0.5000]);
text(ax,'String','c','fontweight','bold','fontsize',12,'position',[-0.5089 0.9710 -0.5000]);

ax1=axes('position',[0.347 0.598 0.079 0.068]);
plot([0 0],[0.7 1.3],'-','color',[232 221 73]./255,'linewidth',1);hold on;
b_h1=boxplotCsub(D1,0,[''],0,1,'k',true,1,false,[1,2],2.4,0.05,'.');
b_h2=boxplotCsub(D2,0,[''],0,1,'k',true,1,false,[2,2],2.4,0.05,'.');
set(b_h1(6,1),'Color',[232 221 73]./255,'linewidth',1.5);
set(b_h1(9,1),'Color',color1(8,:),'linewidth',1.5,'markersize',10);
set(b_h1(3:4,1),'Color','w');
set(b_h1([1:2,5],1),'Color',color1(8,:),'linewidth',1.5,'linestyle','-');
set(b_h1(8,1),'facecolor',color1(7,:));
set(b_h2(6,1),'Color',[232 221 73]./255,'linewidth',1.5);
set(b_h2(9,1),'Color',color1(10,:),'linewidth',1.5,'markersize',10);
set(b_h2(3:4,1),'Color','w');
set(b_h2([1:2,5],1),'Color',color1(10,:),'linewidth',1.5,'linestyle','-');
set(b_h2(8,1),'facecolor',color1(9,:));
xlim([-2 2.5]);ylim([0.7 1.3]);
xlabel('');ylabel('') 
set(ax1,'xtick',-2:2:2,'ytick',[0.9,1.1],'yticklabel',{'1970-1989','1990-2009'});
ax1.YTickLabel{1} = sprintf('\\color[rgb]{%f,%f,%f}%s', color1(8,:), ax1.YTickLabel{1});
ax1.YTickLabel{2} = sprintf('\\color[rgb]{%f,%f,%f}%s', color1(10,:), ax1.YTickLabel{2});
text(2.05,1.07,'*','color',color1(10,:),'fontsize',12,'fontweight','bold');
text(2.05,0.87,'*','color',color1(8,:),'fontsize',12,'fontweight','bold');
text(0.8,1.19,'(+) 56%','color',color1(10,:),'fontweight','bold','fontsize',8);
text(-1.5,1.19,'(-) 44%','color',color1(10,:),'fontweight','bold','fontsize',8);
text(0.8,0.82,'(+) 56%','color',color1(8,:),'fontweight','bold','fontsize',8);
text(-1.5,0.82,'(-) 44%','color',color1(8,:),'fontweight','bold','fontsize',8);
set(ax1,'fontsize',8);

ax2=axes('position',[0.431 0.57 0.076 0.079]);
plot(ax2,2,9,'.','color',figcolor(1,:),'markersize',20);
text(3.3,9.1,'1950-1969','fontsize',10);
hold on;
plot(ax2,2,5.5,'.','color',figcolor(2,:),'markersize',20);
text(3.3,5.6,'1970-1989','fontsize',10);
hold on;
plot(ax2,2,2,'.','color',figcolor(3,:),'markersize',20);
text(3.3,2.1,'1990-2009','fontsize',10);
xlim([0 10]); ylim([0 10]);
ax2.XAxis.Visible = 'off';
ax2.YAxis.Visible = 'off';

% £¨d£© Angiosperm resilience
clc;clear;
figure;
figcolor=[69 118 191;232 136 49;128 54 168]./255;
color1=brewermap(12,'paired');
[a1 b1 c1]=xlsread('\resilience_a.xlsx','1950-2009'); 
D1=a1(:,2)-a1(:,1);
D2=a1(:,3)-a1(:,1);
ax=axes('position',[0.31 0.37 0.2 0.3]);
yyaxis left;
[h1,centers]=hist(a1(:,1),0:0.1:9);
bar(centers,h1,'facecolor',figcolor(1,:),'edgecolor','w','FaceAlpha',0.5);
hold on;
[h2,centers]=hist(a1(:,2),0:0.1:9);
bar(centers,h2,'facecolor',figcolor(2,:),'edgecolor','w','FaceAlpha',0.5);
hold on;
[h3,centers]=hist(a1(:,3),0:0.1:9);
bar(centers,h3,'facecolor',figcolor(3,:),'edgecolor','w','FaceAlpha',0.5);
ylim([0 12]);set(ax,'Ycolor',[0 0 0],'ytick',0:3:12);
ylabel('Number of angiosperm sites','fontsize',12);xlabel('ln(Rs+1)','fontsize',12);

pd = fitdist(a1(:,1),'Kernel','Kernel','epanechnikov');
pd1 = fitdist(a1(:,2),'Kernel','Kernel','epanechnikov');
pd2= fitdist(a1(:,3),'Kernel','Kernel','epanechnikov');
x_values = 0:0.1:9;
y= pdf(pd,x_values);y1= pdf(pd1,x_values);y2= pdf(pd2,x_values);
yyaxis right;
hold on
plot(x_values,y,'-','color',figcolor(1,:),'linewidth',1.5);
hold on
plot(x_values,y1,'-','color',figcolor(2,:),'linewidth',1.5);
hold on
plot(x_values,y2,'-','color',figcolor(3,:),'linewidth',1.5);
xlim([0 4]);ylim([0 1]);
set(ax,'Ycolor',[0 0 0],'ytick',0:0.25:1);
ylabel('Kernel density','fontsize',12);
hold on;
plot([0 4],[0 0],'-k','linewidth',1);
text(0.45,0.65,'¦¤ln(Rs+1) relative to 1950-1969','fontsize',9);
title(ax,'Temporal change of angiosperm resilience','fontsize',12,'position',[1.954 12.7 -0.5]);
t=text(ax,'String','d','fontweight','bold','fontsize',12,'position',[-0.46 1.1 -0.5]);

ax1=axes('position',[0.347 0.598 0.079 0.068]);
plot([0 0],[0.7 1.3],'-','color',[232 221 73]./255,'linewidth',1);hold on;
b_h1=boxplotCsub(D1,0,[''],0,1,'k',true,1,false,[1,2],2.4,0.05,'.');
b_h2=boxplotCsub(D2,0,[''],0,1,'k',true,1,false,[2,2],2.4,0.05,'.');
set(b_h1(6,1),'Color',[232 221 73]./255,'linewidth',1.5);
set(b_h1(9,1),'Color',color1(8,:),'linewidth',1.5,'markersize',10);
set(b_h1(3:4,1),'Color','w');
set(b_h1([1:2,5],1),'Color',color1(8,:),'linewidth',1.5,'linestyle','-');
set(b_h1(8,1),'facecolor',color1(7,:));
set(b_h2(6,1),'Color',[232 221 73]./255,'linewidth',1.5);
set(b_h2(9,1),'Color',color1(10,:),'linewidth',1.5,'markersize',10);
set(b_h2(3:4,1),'Color','w');
set(b_h2([1:2,5],1),'Color',color1(10,:),'linewidth',1.5,'linestyle','-');
set(b_h2(8,1),'facecolor',color1(9,:));
xlim([-2.5 2.5]);ylim([0.7 1.3])
xlabel('');ylabel('') 
set(ax1,'xtick',-2:2:2,'ytick',[0.9,1.1],'yticklabel',{'1970-1989','1990-2009'});
ax1.YTickLabel{1} = sprintf('\\color[rgb]{%f,%f,%f}%s', color1(6,:), ax1.YTickLabel{1});
ax1.YTickLabel{2} = sprintf('\\color[rgb]{%f,%f,%f}%s', color1(10,:), ax1.YTickLabel{2});
text(0.8,1.19,'(+) 43%','color',color1(10,:),'fontweight','bold','fontsize',8);
text(-1.8,1.19,'(-) 57%','color',color1(10,:),'fontweight','bold','fontsize',8);
text(0.8,0.82,'(+) 54%','color',color1(8,:),'fontweight','bold','fontsize',8);
text(-1.8,0.82,'(-) 46%','color',color1(8,:),'fontweight','bold','fontsize',8);
set(ax1,'fontsize',8);

ax2=axes('position',[0.431 0.57 0.076 0.079]);
plot(ax2,2,9,'.','color',figcolor(1,:),'markersize',20);
text(3.3,9.1,'1950-1969','fontsize',10);
hold on;
plot(ax2,2,5.5,'.','color',figcolor(2,:),'markersize',20);
text(3.3,5.6,'1970-1989','fontsize',10);
hold on;
plot(ax2,2,2,'.','color',figcolor(3,:),'markersize',20);
text(3.3,2.1,'1990-2009','fontsize',10);
xlim([0 10]); ylim([0 10]);
ax2.XAxis.Visible = 'off';
ax2.YAxis.Visible = 'off';

%% Figure 4
% £¨a£©Frequency of temporal correlation (R)
clc;clear;
load('\Correlation\TemporalCorr.mat',...
    'Sitename_tcorr','R','P','nevent');
interval=0:0.01:0.1;
for i=1:10
    num=find(P>=interval(i)&P<interval(i+1));
    percent_p(i)=length(num)/161*100;
    clear num
end

interval1=-1:0.2:1;
for i=1:10
    num=find(R>=interval1(i)&R<interval1(i+1));
    percent_r(i)=length(num)/161*100;
    clear num
end
figure;
ax=axes('position',[0.27 0.6 0.2 0.23]);
hb1=bar(percent_r);
set(hb1,'facecolor',[0.93 0.69 0.13]);
xlim([0 11]);ylim([0 38]);
set(gca,'fontsize',10);
set(gca,'xtick',0.5:2.5:10.5,'xticklabel',-1:0.5:1,'tickdir','out');
hold on;
plot([5.5 5.5],[0 38],'--','color',[0.6 0.6 0.6],'linewidth',1.5);
ylabel('Frequency (%)','fontsize',12)
text(0.03,34,'Negative correlation','fontsize',9.5,'color',[69 118 191]./255,'fontweight','bold');
text(6.65,34,'Positive correlation','fontsize',9.5,'color',[232 136 49]./255,'fontweight','bold');
arrow([5.43 34],[4.4 34],'EdgeColor',[69 118 191]./255,'FaceColor',[69 118 191]./255,'BaseAngle',60,'TipAngle',30,'length',2.5,'width',0.2);
arrow([5.57 34],[6.6 34],'EdgeColor',[232 136 49]./255,'FaceColor',[232 136 49]./255,'BaseAngle',60,'TipAngle',30,'length',2.5,'width',0.2);
title('Frequency of temporal correlation','fontsize',12,'Position',[5.5 41 0]);
tx=text('String','a','fontsize',12,'fontweight','bold','Position',[-1.4 44 0]);

% (b) P value
ax=axes('position',[0.55 0.6 0.2 0.23]);
hb2=bar(percent_p);
set(hb2,'facecolor',[0.93 0.69 0.13]);
xlim([0 11]);ylim([0 15]);
set(gca,'fontsize',10);
set(gca,'xtick',[0.6,1.6,5.6:5:9.6],'xticklabel',[0,0.01,0.05],'tickdir','out');
hold on;plot([5.5 5.5],[0 38],'--','color',[0.6 0.6 0.6],'linewidth',1.5);
ylabel('Frequency (%)','fontsize',12)
text(1.7,13.5,'Significant','fontsize',9.5,'color',[69 118 191]./255,'fontweight','bold');
text(6.65,13.5,'Not significant','fontsize',9.5,'color',[232 136 49]./255,'fontweight','bold');
arrow([5.43 13.5],[4.4 13.5],'EdgeColor',[69 118 191]./255,'FaceColor',[69 118 191]./255,...
    'BaseAngle',60,'TipAngle',30,'length',2.5,'width',0.2);
arrow([5.57 13.5],[6.6 13.5],'EdgeColor',[232 136 49]./255,'FaceColor',[232 136 49]./255,...
    'BaseAngle',60,'TipAngle',30,'length',2.5,'width',0.2);
title('Frequency of {\it p} values','fontsize',12,'Position',[5.5 16.278 0]);
text('String','b','fontsize',12,'fontweight','bold','Position',[-1.4 17.33 0]);

% (c) Percentage
num1=length(find(R<0))/161*100;
num2=length(find(R<0&P<0.05))/161*100;
num3=length(find(R>0))/161*100;
num4=length(find(R>0&P<0.05))/161*100;
bardata(1,1:4)=[24 num1-24 0 0];
bardata(2,1:4)=[0 0 num4 num3-num4];
figcolor=brewermap(12,'paired');
% barcolor(1,1:3)=[0.93 0.69 0.13];
% barcolor(2,1:3)=[0.95 0.87 0.73];
% barcolor(3,1:3)=[0 0.75 0.75];
% barcolor(4,1:3)=[0.76 0.87 0.78];
barcolor(1:2,1:3)=figcolor([2,1],:);
barcolor(3:4,1:3)=figcolor([10,9],:);

figure;
ax=axes('position',[0.45 0.6 0.18 0.23]);
bh=bar([1 1.5],bardata,'stack','barwidth',0.4);
for i=1:4
    set(bh(i),'Facecolor',barcolor(i,:),'barwidth',0.5);
end
xlim([0.7 1.8]);ylim([0 110])
set(gca,'ytick',0:25:100);
text(0.95,14,'25%','color',barcolor(1,:),'fontsize',10,'fontweight','bold');
text(0.95,97,'91%','color',[0 0 0],'fontsize',10,'fontweight','bold');
text(1.45,3,'1%','color',barcolor(3,:),'fontsize',10,'fontweight','bold');
text(1.45,15,'9%','color',[0 0 0],'fontsize',10,'fontweight','bold');
set(gca,'xtick',[1 1.5],'xticklabel',{'Negative correlation','Positive correlation'},...
    'xticklabelrotation',8,'tickdir','out');
set(gca,'fontsize',10);
ylb=ylabel('Percentage (%)');
set(ylb,'fontsize',10)
title('Percentage','fontsize',12,'Position',[1.25 120 0]);
tx=text('String','c','fontsize',12,'fontweight','bold','Position',[0.51 130.4 0]);

% (d) Spatial relationship of ¦¤Rt and ¦¤Rs between 1950-1969 and 1970-1989
clc;clear;
load('\Correlation\PeriodCorrg.mat');
X=[ones(size(point1(:,1))) point1(:,1)];
[b,bint,r,rint,stats] = regress(point1(:,2),X);
figure;
ax=axes('position',[0.37 0.4 0.18 0.32]);
scatter(point1(:,1),point1(:,2),25,[0.6 0.6 0.6],'filled','markeredgecolor',[0.5 0.5 0.5],'linewidth',1);
hold on;
plot(point1(:,1),b(2)*point1(:, 1)+b(1),'color',[0.85 0.33 0.1],'linewidth',2);
xlim([-6 6]);ylim([-5 6]);xlabel('¦¤Rt');ylabel('¦¤Rs');
text(-5,-4,'{\it R} = -0.31, {\it p} < 0.001','fontsize',10);
text(-5.5,5,'1950-1969 vs. 1970-1989','fontsize',9.5,'fontweight','bold');
title(ax,'Relationship of ¦¤Rt and ¦¤Rs','Position',[-0.18 6.89 0],'fontsize',12);
text(ax,'String','d','fontsize',12,'fontweight','bold','Position',[-7.5 7.36 0]);
%set(ax,'tickdir','out');
box on;
ax1=axes('position',[0.492 0.62 0.057 0.092]);box off;
hbar=bar([0 percent(1);1-percent(1) 0],'barwidth',1.5);xlim([0.5 2.5]);
set(hbar(1),'facecolor',[1 1 1]);
set(hbar(2),'facecolor',[0.6 0.6 0.6]);
set(gca,'fontsize',8);
% set(gca,'yticklabel',{})
text(0.9,0.8,'70%','fontsize',8);
text(1.65,0.4,'30%','fontsize',8);
ax1.XAxis.Visible = 'off';
set(gca,'ytick',0:0.5:1,'yticklabel',0:50:100)
box off

% (e)
X=[ones(size(point2(:,1))) point2(:,1)];
[b,bint,r,rint,stats] = regress(point2(:,2),X);
figure;
ax=axes('position',[0.37 0.4 0.18 0.32]);
scatter(point2(:,2),point2(:,1),25,[0.6 0.6 0.6],'filled','markeredgecolor',[0.5 0.5 0.5],'linewidth',1);
hold on;
plot(point2(:,1),b(2)*point2(:, 1)+b(1),'color',[0.85 0.33 0.1],'linewidth',2);
xlim([-6 6]);ylim([-5 6]);xlabel('¦¤Rt');ylabel('¦¤Rs');
text(-5,-4,'{\it R} = -0.23, {\it p} < 0.001','fontsize',10);
text(-5.5,5,'1970-1989 vs. 1990-2009','fontsize',9.5,'fontweight','bold');
title(ax,'Relationship of ¦¤Rt and ¦¤Rs','Position',[-0.18 6.89 0],'fontsize',12);
text(ax,'String','e','fontsize',12,'fontweight','bold','Position',[-7.5 7.36 0]);
box on;
ax1=axes('position',[0.492 0.62 0.057 0.092]);box off;
hbar=bar([0 percent(1);1-percent(1) 0],'barwidth',1.5);xlim([0.5 2.5]);
set(hbar(1),'facecolor',[1 1 1]);
set(hbar(2),'facecolor',[0.6 0.6 0.6]);
set(gca,'fontsize',8);
text(0.9,0.8,'66%','fontsize',8);
text(1.65,0.4,'34%','fontsize',8);
set(gca,'ytick',0:0.5:1,'yticklabel',0:50:100)
ax1.XAxis.Visible = 'off';
box off

% (f)
X=[ones(size(point3(:,1))) point3(:,1)];
[b,bint,r,rint,stats] = regress(point3(:,2),X);
figure;
ax=axes('position',[0.37 0.4 0.18 0.32]);
scatter(point3(:,1),point3(:,2),25,[0.6 0.6 0.6],'filled','markeredgecolor',[0.5 0.5 0.5],'linewidth',1);
hold on;
plot(point3(:,1),b(2)*point3(:, 1)+b(1),'color',[0.85 0.33 0.1],'linewidth',2);
xlim([-6 6]);ylim([-5 6]);xlabel('¦¤Rt');ylabel('¦¤Rs');
text(-5,-4,'{\it R} = -0.34, {\it p} < 0.001','fontsize',10);
text(-5.5,5,'1950-1969 vs. 1990-2009','fontsize',9.5,'fontweight','bold');
title(ax,'Relationship of ¦¤Rt and ¦¤Rs','Position',[-0.18 6.89 0],'fontsize',12);
text(ax,'String','f','fontsize',12,'fontweight','bold','Position',[-7.5 7.36 0]);
box on;
ax=axes('position',[0.492 0.62 0.057 0.092]);box off;
hbar=bar([0 percent(1);1-percent(1) 0],'barwidth',1.5);xlim([0.5 2.5]);
set(hbar(1),'facecolor',[1 1 1]);
set(hbar(2),'facecolor',[0.6 0.6 0.6]);
set(gca,'fontsize',8);
text(0.9,0.8,'70%','fontsize',8);
text(1.65,0.4,'30%','fontsize',8);
set(gca,'ytick',0:0.5:1,'yticklabel',0:50:100)
ax.XAxis.Visible = 'off';
box off

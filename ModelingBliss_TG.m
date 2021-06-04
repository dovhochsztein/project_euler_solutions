clear
drugvol = zeros(10,1);
drugvol(1) = 200;
for i = 1:9
    drugvol(i+1) = drugvol(i)/1.5;
end

HillOpts = 1;
for h = 1:length(HillOpts)
    clearvars -except HillOpts h drugvol FICMultBliss FICLoewe
    Hill = HillOpts(h);

modelfunx = @(x) 1./((50./x).^Hill+1);
Emax = 1;
% Hill = 2.7106;

EC50 = 50;
numbDrugs = 2;
combofunx = @(x) 1./((50./x).^Hill+1);


ICs = [.1 .25 .5 .75 .9 .95];
% initGuesses = [25,25,50,50,100,100];
initGuesses = [10 25 50 100 1000 3000]; % works for Hill .9, 1.1, 1.5
% initGuesses = [1 5 50 450 4000 10000]; % for Hill .5
projectedICs = zeros(length(ICs),1);
for n = 1:length(ICs)
    funk = @(x) 1./((50./x).^Hill+1) - ICs(n);
    x0 = initGuesses(n);
    projectedICs(n) = fzero(funk,x0);
end

ObservedICs = projectedICs;

drugfunx = repmat({modelfunx},numbDrugs,1);
DrugEmax = ones(numbDrugs,1);
DrugEC50 = repmat(EC50,numbDrugs,1);
DrugHill = repmat(Hill,numbDrugs,1);
LowestVol = repmat(drugvol(10),numbDrugs,1)/numbDrugs;
LastVol = repmat(drugvol(1),numbDrugs,1)/numbDrugs;
P10 = diag(ones(numbDrugs,1)).*repmat(projectedICs(1),numbDrugs,1);
P25 = diag(ones(numbDrugs,1)).*repmat(projectedICs(2),numbDrugs,1);
P50 = diag(ones(numbDrugs,1)).*repmat(projectedICs(3),numbDrugs,1);
P75 = diag(ones(numbDrugs,1)).*repmat(projectedICs(4),numbDrugs,1);
P90 = diag(ones(numbDrugs,1)).*repmat(projectedICs(5),numbDrugs,1);
P95 = diag(ones(numbDrugs,1)).*repmat(projectedICs(6),numbDrugs,1);

A10 = zeros(numbDrugs,numbDrugs-1);
A25 = zeros(numbDrugs,numbDrugs-1);
A50 = zeros(numbDrugs,numbDrugs-1);
A75 = zeros(numbDrugs,numbDrugs-1);
A90 = zeros(numbDrugs,numbDrugs-1);
A95 = zeros(numbDrugs,numbDrugs-1);
for i = 1:length(P50)-1
    A10(:,i) = P10(i,:) - P10(i+1,:);
    A25(:,i) = P25(i,:) - P25(i+1,:);
    A50(:,i) = P50(i,:) - P50(i+1,:);
    A75(:,i) = P75(i,:) - P75(i+1,:);
    A90(:,i) = P90(i,:) - P90(i+1,:);
    A95(:,i) = P95(i,:) - P95(i+1,:);
end
Acell = {A10 A25 A50 A75 A90 A95};
Pcell = {P10 P25 P50 P75 P90 P95};

gtotal = @(t) 1-prod(DrugEmax./(1+(t*LowestVol./DrugEC50).^DrugHill));
syms t
line = LowestVol + t*(LastVol - LowestVol);
options = optimset('Display','off');
for c = 1:length(ICs)
    BlissFunx = @(x) BlissMult(drugfunx,LowestVol + x*(LastVol - LowestVol)) - ICs(c);
    if ~any(any(isnan(Acell{c})))
        normalVector = null(Acell{c}');
        plane = dot(normalVector, line - Pcell{c}(:,1));
        tLoewe = double(solve(plane));
        LoeweICs(c) = sum(LowestVol + tLoewe*(LastVol - LowestVol));
        tBliss = fzero(BlissFunx, LoeweICs(c), options);
        tMultBliss = fzero(@(t) gtotal(t) - ICs(c), LoeweICs(c), options);
%         loewe = LowestVol + tLoewe*(LastVol - LowestVol);
%         plot(P90(1,:),P90(2,:),'b-','LineWidth',2)
%         hold on
%         plot(loewe(1),loewe(2),'ro','LineWidth',2,'Markersize',10)
%         plot([0,1.5*loewe(1)],[0,1.5*loewe(2)],'k-','Linewidth',2)
%         RandoVectorX = linspace(0,projectedICs(5),1500);
%         gMeow = @(x,y) (1-drugfunx{1}(x))*(1-drugfunx{2}(y));
%         for p = 1:length(RandoVectorX)
%             RandoVectorY(p) = fsolve(@(y) gMeow(RandoVectorX(p),y) - .1,100,options);
%         end
%         plot(RandoVectorX,RandoVectorY,'m-','LineWidth',2)
        
        if isnan(tBliss)
            counter = 0;
            initGuess = LoeweICs(c);
            if BlissFunx(LoeweICs(c)) > 0
                while isnan(tBliss)
                    initGuess = initGuess/2;
                    tBliss = fzero(BlissFunx, initGuess, options);
                    counter = counter + 1;
                    if counter == 5
                        break
                    end
                end
            else
                while isnan(tBliss)
                    initGuess = initGuess*2;
                    tBliss = fzero(BlissFunx, initGuess, options);
                    counter = counter + 1;
                    if counter == 5
                        break
                    end
                end
            end
        end
        if isnan(tMultBliss)
            counter = 0;
            initGuess = LoeweICs(c);
            tempfunk =  @(t) gtotal(t) - ICs(c);
            if tempfunk(LoeweICs(c)) > 0
                while isnan(tMultBliss)
                    initGuess = initGuess/2;
                    tMultBliss = fzero(tempfunk, initGuess, options);
                    counter = counter + 1;
                    if counter == 5
                        break
                    end
                end
            else
                while isnan(tMultBliss)
                    initGuess = initGuess*2;
                    tMultBliss = fzero(tempfunk, initGuess, options);
                    counter = counter + 1;
                    if counter == 5
                        break
                    end
                end
            end
        end
        MultBlissICs(c) = sum(tMultBliss*LowestVol);
        BlissICs(c) = sum(LowestVol + tBliss*(LastVol - LowestVol));
        FICMultBliss(1,c) = log2(ObservedICs(c)/MultBlissICs(c));
        FICLoewe(1,c) = log2(ObservedICs(c)/LoeweICs(c));
        FICBliss(c) = ObservedICs(c)/BlissICs(c);
    end
end

end

ICsforsolve = [-100 .1 .25 .5 .75 .9 .95 100]; % extended so that the interpolation would be neater
initGuessesforsolve = [0 10 25 50 100 1000 3000 6000];
% pp=spline(ICs,initGuesses);
% p=polyfit(ICs,initGuesses,6);
% pp=interp1(ICs,initGuesses);
% K = fittype('a-b*exp(-c*x)');
% f0 = fit(ICs',initGuesses',K,'StartPoint',[[ones(size(ICs')), -exp(-ICs')]\initGuesses'; 1]);

FUNK = @(x,IC) 1./((50./x).^Hill+1) - IC;
% initGuess = @(IC) 10*(IC/.1)^(log(300)/log(9.5));
% initGuess = @(IC) polyval(p,IC);
% initGuess = @(IC) ppval(pp,IC);
initGuess = @(IC) interp1(ICsforsolve,initGuessesforsolve,IC);
projectedIC = @(IC) fzero(@(x) FUNK(x,IC),initGuess(IC));
tMultBliss = @(IC) fzero(@(t) gtotal(t) - IC, projectedIC(IC), options)
MultBlissICs = @(IC) sum(tMultBliss(IC)*LowestVol);

ICplot=linspace(0,.99,100);
for i=1:length(ICplot)
    projectedICplot(i)=projectedIC(ICplot(i));
    MultBlissICplot(i)=MultBlissICs(ICplot(i));
end
figure;
hold on
plot(ICplot,projectedICplot);
plot(ICplot,MultBlissICplot);

ICcrit=fsolve(@(IC) MultBlissICs(IC)-projectedIC(IC),.1)



% figure
% hold on
% plot([10 25 50 75 90 95],FICMultBliss(1,:),'-o','Linewidth',2)
% set(gca,'Fontsize',14)
% plot([10 25 50 75 90 95],FICMultBliss(2,:),'-o','Linewidth',2)
% plot([10 25 50 75 90 95],FICMultBliss(3,:),'-o','Linewidth',2)
% plot([10 25 50 75 90 95],FICMultBliss(4,:),'-o','Linewidth',2)
% plot([10 25 50 75 90 95],FICMultBliss(5,:),'-o','Linewidth',2)
% plot([10 25 50 75 90 95],FICMultBliss(6,:),'-o','Linewidth',2)
% plot([10 25 50 75 90 95],FICMultBliss(7,:),'-o','Linewidth',2)
% plot([10 25 50 75 90 95],FICMultBliss(8,:),'k-o','Linewidth',2)
% lgd = legend('Hill = 0.5','Hill = 0.9','Hill = 1','Hill = 1.1','Hill = 1.5', 'Hill = 2.7106', 'Hill = 5', 'Hill = 10');
% lgd.Location = 'Northwest';
% lgd.FontSize = 14;
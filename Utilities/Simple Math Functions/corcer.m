function corcer(X,CP,pa,pb,varnames,Col,disp)
%
% CORCER :         Cercle de corrélations : Représentation sur un cercle
%    des coefficients de corrélation entre deux nouvelles variables et
%    l'ensemble des variables initiales (colonnes de la matrice X).
%    Ces coefficients sont représentés par un vecteur flèche à partir de 
%    l'origine 0.
%
% corcer(X,CP,pa,pb,varnames,Col,disp);
%
% Entrée :
% -------- 
% X        : Matrice des données d'origines (variables en colonne)
% CP       : Composantes principales résultants d'une ACP (composante en colonnes).
%            Doit etre de meme dimension que X.
% pa, pb   : indice (n°) des 2 axes à traiter (i.e. des 2 nouvelles variables)
% varnames : Tableau des labels des variables d'origines à associer aux variables
%            de X. Il doit donc avoir la meme longueur que X a de colonnes.
%            Des variables peuvent avoir le meme nom de label auquel cas leurs
%            vecteurs flèches seront tracés dans la meme couleur (c.f. paramètre
%            Col)
% Col      : Map de couleur pour les traits des vecteurs flèches à associer dans 
%            l'ordre à chaque "cas" de nom de variables (varnames). Ansi, si par 
%            exemple, plusieurs variables sont associés au meme nom (par
%            exemple 'AVRIL'), toutes les flèches des coefficients de ces variables 
%            auront la meme couleur. La taille de la map doit au moins etre égale
%            au nombre de "cas" de noms de variable différents.
%            Par défaut : les flèches seront de couleur bleu.
% disp     : Choix d'un type d'affichage :                  
%             1 : tous les vecteurs avec un seul label par "cas de nom de variable"  
%	              positionné sur le vecteur moyen du "cas"; colorbar  affichée    
%             2 : un subplot par "cas"; pas de label, pas de colorbar
%             3 : vecteurs moyens des "cas" ; label sur les vecteurs moyens; colorbar affichée 
%             Par defaut : comme 1 sans la colorbar.

%_________________________________________________________
% Auteur : unknown 
% modification : 2012 C. Sorror
%---------------------------------------------------------
% some checks and set
if (nargin<5)
   error('corcer syntaxe error : corcer(X,CP,pa,pb,varnames,Col,disp)');
end
[Ndata, NbVar] = size(X);
%if (size(CP,1)~=Ndata | size(CP,2)~=NbVar)
%   error('corcer error : Matrices X and CP must have the same dimension');
%end
if (size(CP,1)~=Ndata)
   error('corcer error : Matrices X and CP must have the same number of row');
end
if (pa<1 | pa>NbVar | pb<1 | pb>NbVar)
   error('corcer error : pa and pb index must be between 1 and the number of variables');
end
if (length(varnames)~=NbVar)
   error('corcer error : Variable label names must have the same size than the number of column in X');
end
%---------------------------------------------------------
% Définition des "cas" de variable , c'est à dire de noms différents
[varcas,si] = unique(varnames);
varcas      = varnames(sort(si));
nbvarcas    = length(varcas);
%
if (nargin==5) % Map de couleur des vecteurs par défaut : bleu
    Col = repmat([0.0 0.0 0.65],nbvarcas,1);    
else
   if (length(Col)<nbvarcas)
      error('corcer error : the map ''Col'' must have at least a number of vector equal the number of variable names case');
   end
end
%
%---------------------------------------------------------
% Valeurs par defaut des paramètres d'affichage
ALL=0;  SUB=1;  MOY=2; NONE=0; TOUT=1; MEAN=2;
% Vecteurs à ploter
Kplot=0; % 0 : tous les vecteurs sur un seul cercle
         % 1 : un subplot par "cas" de variable
         % 2 : un vecteur moyen par "cas" de variable 
% Labels à indiquer
Klab=2;  % 0 : on ne labelise rien
         % 1 : on labelise les vecteurs plotés
         % 2 : on ne labelise que sur le vecteur moyen
% Affichage colorbar
Kcbar=0; % 0 : la colorbar n'est pas affiché
%        % 1 : la colorbar est affiché
% Toutes les combinaisons de paramètres ne sont pas heureuses;
% n'en prévoir que certaines (plm)      .
if (nargin==7)
   if     (disp==1) Kplot=0; Klab=2; Kcbar=1; 
   elseif (disp==2) Kplot=1; Klab=0; Kcbar=0; 
   elseif (disp==3) Kplot=2; Klab=2; Kcbar=1; 
   end    % plm, je limite à ces 3 combinaisons (+ the default one)
end
%---------------------------------------------------------
% Calcul des coéfficients de corrélations linéaire
% sur les axes (pa et pb) demandés 
CCOR = corrcoef([X, CP(:,pa), CP(:,pb)]);
CCOR = CCOR(1:NbVar,NbVar+1:end);
ccora= CCOR(:,1); ccorb=CCOR(:,2); 
%---------------------------------------------------------
hold on;  
%
% Element pour tracer le cercle de rayon 1 et de centre 0
t = [-pi:0.01:pi];
x = cos(t);
y = sin(t);
if (Kplot~=SUB)
   plot(x,y,'r');  %trace le cercle de rayon 1 et de centre 0
else
   % definir les subplots
   subpa=ceil(sqrt(nbvarcas));
   subpb=ceil(nbvarcas/subpa);
end
%
%---------------------------------------------------------
for v=1:nbvarcas 
    Iv = find(strcmp(varnames,varcas(v)));     
    if (Kplot==SUB)
       subplot(subpb,subpa,v); hold on; 
       plot(x,y,'r');  %trace le cercle de rayon 1 et de centre 0
       % Plot les axes principaux dans le cercle
       axe = axis;
       plot([axe(1) axe(2)],[0 0],'k',[0 0],[axe(3) axe(4)],'k');
       if (exist('OCTAVE_VERSION'))
          axis([-1 1 -1 1]);
       else
          axis('equal');
       end
       title(varcas{v});
    end
    if (Kplot==MOY)
       moya = mean(ccora(Iv));
       moyb = mean(ccorb(Iv));
       h=compass(moya,moyb);
       if (Klab==TOUT | Klab==MEAN)
          text(moya,moyb,varcas{v},'fontsize',10,'fontweight','bold');
       end
    else
       h=compass(ccora(Iv),ccorb(Iv)); 
       if (Klab==MEAN)
          moya = mean(ccora(Iv));
          moyb = mean(ccorb(Iv));
          text(moya,moyb,varcas{v},'fontsize',10,'fontweight','bold');
       end
       if (Klab==TOUT)
          for i=1:length(ccora)
             text(ccora(i),ccorb(i),varnames{v},'fontsize',10,'fontweight','bold');
          end
       end 
    end
    set(h,'color',Col(v,:));
    if (Kplot==SUB & Kcbar==1) 
       colormap(Col(1:nbvarcas,:)); hc=colorbar;
        if (exist('OCTAVE_VERSION'))
           set(hc,'YTick',[0.05:(0.95-0.05)/(nbvarcas-1):0.95]','YTickLabel',varcas);
        else
           set(hc,'YTick',[1.5:1:nbvarcas+0.5]','YTickLabel',varcas);
        end
   end
end
%
if (Kplot~=SUB)
   if (Kcbar==1) 
      colormap(Col(1:nbvarcas,:)); hc=colorbar;
      if (exist('OCTAVE_VERSION'))
         set(hc,'YTick',[0.05:(0.95-0.05)/(nbvarcas-1):0.95]','YTickLabel',varcas);
      else
         set(hc,'YTick',[1.5:1:nbvarcas+0.5]','YTickLabel',varcas);
      end
   end
   % Plot les axes principaux dans le cercle
   axe = axis;
   plot([axe(1) axe(2)],[0 0],'k',[0 0],[axe(3) axe(4)],'k');
   if (exist('OCTAVE_VERSION'))
      axis([-1 1 -1 1]);
   else
      axis('equal');
   end
end
%
% Intitulé des axes
xlabel(['axe ', int2str(pa)],'fontsize',11,'fontweight','bold'); 
ylabel(['axe ', int2str(pb)],'fontsize',11,'fontweight','bold');
%
%===============================================================
%

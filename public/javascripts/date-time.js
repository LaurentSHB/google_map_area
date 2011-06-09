<!-- Begin
function aff_hd()
{
var mois=new Array(13);
mois[1]="Janvier";mois[2]="Février";mois[3]="Mars";mois[4]="Avril";mois[5]="Mai";
mois[6]="Juin";mois[7]="Juillet";mois[8]="Août";mois[9]="Septembre";
mois[10]="Octobre";mois[11]="Novembre";mois[12]="Décembre";
var time=new Date();
var month=mois[time.getMonth() + 1];
var date=time.getDate();
var year=time.getYear();
if (year < 2000)
year = year + 1900;
var my_date= new Date();
var hour=my_date.getHours();
if(hour<10)
{ hour="0"+hour; }
var minute=my_date.getMinutes();
if(minute<10)
{ minute="0"+minute; }
var second=my_date.getSeconds();
if(second<10)
{ second="0"+second; }
code = date + ' ' + month + ' ' + year + ' ' + hour + 'h' + minute + ':' + second + '&nbsp;&nbsp;&nbsp;';
horloge.innerHTML = code;
setTimeout("aff_hd()",1000);
}
// -->
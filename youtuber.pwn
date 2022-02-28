// YouTuber Sistemi - R4IN [GTAMulti.com]

// Kitaplik
// ----------------------------------------- |
// GTAMulti.com - R4IN [YouTuber Sistemi]    |
// ----------------------------------------- |

#include 	<a_samp>
#include    <a_mysql>
#include    <sscanf2>
#include    <zcmd>


// MySQL Defineleri

#define     Baglan  	"localhost"
#define     Kullanici   "root"
#define     Sifre       ""
#define     Veritabani  "ytsistemi"

// Defineler
#define     YouTube_Yayin   			(1)
#define     YouTube_Kanal       		(2)
#define     YouTube_Sifre       		(3)
#define     YouTube_Durum       		(4)

// enum
enum Youtubers {

	id,
	mychannel[24],
	mypassword[32],
	mylevel,
	mylibrary,
	mystatus,
	myvideos,
	mylive
	
};

// news
new pYouTube[MAX_PLAYERS][Youtubers];

new MySQL:youtuber;

public OnFilterScriptInit()
{
    youtuber = mysql_connect(Baglan, Kullanici, Sifre, Veritabani);
	if(mysql_errno(youtuber) == 0)
	{
		print("YouTuber sistemi yüklendi - R4IN");
	}
	else
	{
		print("YouTuber sistemi yuklenemedi - R4IN");
	}
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	new vQuery[256];
	mysql_format(youtuber, vQuery, sizeof(vQuery), "SELECT * FROM `youtubers` WHERE `yt_name` = '%s'", PlayerName(playerid));
	mysql_tquery(youtuber, vQuery, "LoadYouTuber", "i", playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new cStr[128];
	if(pYouTube[playerid][mylevel] == 1)
	{
	    format(cStr, sizeof(cStr), "{ff0000}YouTuber: {ffffff}%s: %s", PlayerName(playerid), text);
	}
	else
	{
		format(cStr, sizeof(cStr), "{ffffff}%s: %s", PlayerName(playerid), text);
	}
	SendClientMessageToAll(-1, cStr);
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case YouTube_Kanal:
	    {
	        if(response)
	        {
				new strings[98];
				format(strings, sizeof(strings), "{00ff00}%s isimli oyuncu kanal ismini %s olarak ayarladi.", PlayerName(playerid), inputtext);
				SendClientMessage(playerid, -1, "Basarili bir sekilde YouTube kanal isminizi olusturdunuz simdi sifre giriniz");
				new sQuery[124];
				mysql_format(youtuber, sQuery, sizeof(sQuery), "UPDATE `youtubers` SET `yt_chname` = '%s' WHERE `yt_name` = '%s'", inputtext, PlayerName(playerid));
				mysql_query(youtuber, sQuery);
				// password olustrma yolu
				ShowPlayerDialog(playerid, YouTube_Sifre, DIALOG_STYLE_INPUT, "{ff0000}YouTube: {ffffff}Kanal Sifre", "{ffffff}Simdi ise asagiya YouTube kanal sifrenizi giriniz:", "Tamam", "");
			}
			else
			{
				SendClientMessage(playerid, -1, "Kanal olusturmaktan vazgectiniz.");
			}
		}
		case YouTube_Sifre:
		{
			if(response)
			{
				new stringz[54];
				format(stringz, sizeof(stringz), "Kanal sifreniz: {b0e0e6}%s", inputtext);
				SendClientMessage(playerid, -1, stringz);
				new sQuery[124];
				mysql_format(youtuber, sQuery, sizeof(sQuery), "UPDATE `youtubers` SET `yt_passw` = '%s' WHERE `yt_name` = '%s'", inputtext, PlayerName(playerid));
				mysql_query(youtuber, sQuery);
			}
			else
			{
				SendClientMessage(playerid, -1, "Kanal olusturmaktan vazgectiniz.");
			}
		}
		case YouTube_Yayin:
		{
		    if(response)
		    {
		        new lStr[128];
		        format(lStr, sizeof(lStr), "{6699ff}%s {ffffff}isimli {ff0000}YouTuber {ffffff}yayin yapiyor: {6699ff}%s", PlayerName(playerid), inputtext);
				SendClientMessageToAll(-1, lStr);
			}
		    else
		    {
		        SendClientMessage(playerid, -1, "{ff0000}Yayin yapmaktan vazgectiniz!");
		    }
		}
	}
	return 1;
}

CMD:setyoutuber(playerid, params[])
{
	new userid, level;
	if(sscanf(params, "ud", userid, level))
	    return SendClientMessage(playerid, -1, "/SetYoutuber [isim/id] [level]");
	if(level < 0 || level > 2)
	{
	    SendClientMessage(playerid, -1, "En fazla 1 verilebilir!");
	}
	pYouTube[userid][mylevel] = level;
	new string[94];
	format(string, sizeof(string), "{ff8400}=> {ffffff}%s isimli yetkili %s isimli oyuncuyu {ff0000}YouTuber {ffffff}yapti.", PlayerName(playerid), PlayerName(userid));
	SendClientMessage(playerid, -1, string);
	ShowPlayerDialog(userid, YouTube_Kanal, DIALOG_STYLE_INPUT, "{ff0000}YouTube: {ffffff}Kanal Ismi", "{ffffff}YouTube kanal isminizi lutfen asagiya giriniz:", "Ileri", "");
	new query[128];
	mysql_format(youtuber, query, sizeof(query), "INSERT INTO `youtubers` (`yt_name`, `yt_level`) VALUES ('%s', '%d')", PlayerName(userid), level);
	mysql_query(youtuber, query);
	return true;
}

CMD:yayinyap(playerid, params[])
{
	if(pYouTube[playerid][mylevel] == 1)
	{
	    ShowPlayerDialog(playerid, YouTube_Yayin, DIALOG_STYLE_INPUT, "{ff0000}YouTube: {ffffff}Yayin", "{ffffff}Yapmak istediginiz yayin ismini giriniz:", "Baslat", "Iptal");
	}
	else
	{
	    SendClientMessage(playerid, -1, "{ff0000}YouTuber degilsiniz.");
	}
	return true;
}

forward LoadYouTuber(playerid);
public  LoadYouTuber(playerid)
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
	{
 		cache_get_value_int(0, "yt_id", pYouTube[playerid][id]);
		cache_get_value_int(0, "yt_level", pYouTube[playerid][mylevel]);
		SendClientMessage(playerid, -1, "{ff0000}YouTuber olarak giris yaptiniz!");
	}
	else
	{
	    SendClientMessage(playerid, -1, "{3de5a7}Oyuncu olarak giris yaptiniz!");
	}
	return true;
}

stock PlayerName(playerid)
{
	new name[24];
	GetPlayerName(playerid, name, 24);
	return name;
}

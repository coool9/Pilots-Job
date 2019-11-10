//   CREATOR: COOOL
//   Version: 1

new WorkBucks = 5000;
new Penality = -650;

#define FILTERSCRIPT


#include <a_samp>
#include <streamer>


#define PH_D        4834
new TakingPs[MAX_PLAYERS] = 2;
///////////////CHECKPOINTS || LANDING OR TAKING////////////
new Float:RandomCPs[][3] =
{
	{1678.4602,-2625.2407,13.1195},   //LS
	{-1275.9586,10.1346,15.5220},   //SF
	{1347.2815,1281.2484,12.1943}, //LV
	{394.8399,2509.7869,17.8583}  //Desert
};


new cp[MAX_PLAYERS];

/////////VEHICLES || PLANES ////////////

new pilotvehs[9] =
{ 460, 511, 512, 513, 519, 553, 577, 592, 593 };

////////////////////////////////////////

new rand;
new rand2;

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n*************************************");
	print(" +++++++Pilot Work FS BY COOOL+++++++");
	print("***************************************\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (!strcmp(cmdtext, "/pcmds"))
	{
		SendClientMessage(playerid, 0x12FF12AA, "/pwork for work, /pwstop for stopping work, /phelp for some help.");
		return 1;
	}
	if (!strcmp(cmdtext, "/pwork"))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
					new strin[45];
		 			format(strin, sizeof(strin), "%i, %i, %i", pilotvehs[0], pilotvehs[1], pilotvehs[2]);
		 			SendClientMessage(playerid, -1, strin);
		 			new bool:IsPassing[MAX_PLAYERS] = false;
		 			for (new o; o < 9; o++)
					{
		    			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == pilotvehs[o])
						{
							// 476 Rustler
							rand = random(sizeof(RandomCPs));
	        				SendClientMessage(playerid, 0x34AA33AA, "As you were in your plane. An airport officer noticed you then he approached you. And");
		        			SendClientMessage(playerid, 0x34AA33AA, "He said: This plane is looking very good while you are");
		        			SendClientMessage(playerid, 0x34AA33AA, "sitting in it. I think you have got the skills for a pilot, So, what about a job in a plane?");
		        			SendClientMessage(playerid, 0x34AA33AA, "You said: Oh my blessing! I was looking for a pilot's job. I want the job.");
		        			SendClientMessage(playerid, 0x34AA33AA, "He said: You are Hiried. Have fun with your job");
	  		 				cp[playerid] = CreateDynamicCP(RandomCPs[rand][0],RandomCPs[rand][1],RandomCPs[rand][2], 20, -1, playerid, -1, 6000);
	  		 				TakingPs[playerid] = 1;
	  		 				IsPassing[playerid] = true;
	  		 				return 1;
						}
					}
		   			if(IsPassing[playerid] == false) {
					    SendClientMessage(playerid, 0xFF6347AA, "Please use planes. Hydra and Rustler not included in planes category.");
					}
		}
		else
		{
			SendClientMessage(playerid, 0xFF6347AA, "Please get in a plane and then start your work.");
		}
		return 1;
	}


	if(!strcmp(cmdtext, "/phelp"))
	{
	    new phstr[256];
	    format(phstr, sizeof(phstr),  "If you want to became a pilot then worry not we have\n some thing for you, just get in a plane and use /pwork.\n While you are doing your work you will also be \ngiven your payment it is %i per trip. So, have fun and fly just\n one.In last, use /pwstop to stop.", WorkBucks);
	    ShowPlayerDialog(playerid, PH_D, DIALOG_STYLE_MSGBOX, "Pilots Work Help", phstr, "OK", "Cancel");
	    return 1;
	}

	if(!strcmp(cmdtext, "/pwstop"))
	{
		SendClientMessage(playerid, 0xFFFF00AA, "You were flying your plane in a very much fun");
		SendClientMessage(playerid, 0xFFFF00AA, "but then a sudden impulse from your heart to your brain made you thought about leaving your job.");
		SendClientMessage(playerid, 0xFFFF00AA, "You then got the telephone attached in plane and quickly dialed airport officer's number and");
 		SendClientMessage(playerid, 0xFFFF00AA, "You said: I am bored of this. I can't handle any plane. Now just I want a leave from my work.");
		SendClientMessage(playerid, 0xFFFF00AA, "He said: Are you sure, you really want to quit your job.");
		SendClientMessage(playerid, 0xFFFF00AA, "You said: I am sure thrice. I want to quit my job.");
		SendClientMessage(playerid, 0xFFFF00AA, "He said: OK! you are out of duty. Have fun in your life.");
	    DestroyDynamicCP(cp[playerid]);
	    TakingPs[playerid] = 2;
	    return 1;
	}
	return 0;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(IsPlayerInDynamicCP(playerid, cp[playerid]))
	{
	    if(TakingPs[playerid] == 1)
	    {
     		rand2 = random(sizeof(RandomCPs));
	        while (rand2 == rand)
	        {
	            rand2 = random(sizeof(RandomCPs));
			}
	    	SendClientMessage(playerid, 0x00FF24AA, "You took passengers and now are looking to leave, when ready.");
	    	DestroyDynamicCP(cp[playerid]);
 			rand = random(sizeof(RandomCPs));
 			TakingPs[playerid] = 0;
	 		cp[playerid] = CreateDynamicCP(RandomCPs[rand2][0],RandomCPs[rand2][1],RandomCPs[rand2][2], 20, -1, playerid, -1, 6000);
	 		return 1;
		}

		if(TakingPs[playerid] == 0)
		{
		    new wst[180];
			new pilotN[MAX_PLAYER_NAME];
		    GetPlayerName(playerid, pilotN, sizeof(pilotN));
		    format(wst, sizeof(wst), "Officer looking at you said: Well work MR.%s you have done your job honestly then he fetches something from his pocket and handes to you.", pilotN);
		    SendClientMessage(playerid, 0x26CF12AA, "You completed your passengers' trip (Which you must have to do), then a staff officer approached you...");
		    SendClientMessage(playerid, 0x26CF12AA, wst);
		    SendClientMessage(playerid, 0x26CF12AA, "You then hurried and opened you hand, it was filled with bucks i.e cash. You were payed. If you again need the work type /pwork");
			GivePlayerMoney(playerid, WorkBucks);
			DestroyDynamicCP(cp[playerid]);
			TakingPs[playerid] = 2;
			return 1;
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(TakingPs[playerid] == 1 || TakingPs[playerid] == 0)
	{
	    SendClientMessage(playerid, 0xFF0000AA, "You left your plane, your job, your passengers, your trip and your bucks also because you left your plane... Sad!");
	    SendClientMessage(playerid, 0xFF0000AA, "The next day an off-duty airport officer (who hired you) was walking on the road. You saw him but you don't think that he had also seen you.");
	    SendClientMessage(playerid, 0xFF0000AA, "As your thinking glanced your mind. The officer glanced at you. You were seen. You were recognized, So you took off stress on your legs and ran.");
	    SendClientMessage(playerid, 0xFF0000AA, "You ran and the officer ran also, you ran fast indeed and the officer ran faster then you.");
	    SendClientMessage(playerid, 0xFF0000AA, "But your bad luck, you slipped but the officer didn't and he caught you with his hands on your face.");
 	    new pstri[198];
	    format(pstri, sizeof(pstri), "Officer: You are the same one who left the plane, don't you know how many passengers were travelling. I charge you %i for your stupid thing.", Penality);
	    SendClientMessage(playerid, 0xFF0000AA, pstri);
	    SendClientMessage(playerid, 0xDFDFDFAA, "Use /pwstop to take no penality charges while leaving your plane.");
	    GivePlayerMoney(playerid, Penality);
	    DestroyDynamicCP(cp[playerid]);
	    TakingPs[playerid] = 2;
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(TakingPs[playerid] == 1 || TakingPs[playerid] == 0) {
		DestroyDynamicCP(cp[playerid]);
		TakingPs[playerid] = 2;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(TakingPs[playerid] == 1 || TakingPs[playerid] == 0) {
		DestroyDynamicCP(cp[playerid]);
		TakingPs[playerid] = 2;
	}
	return 1;
}

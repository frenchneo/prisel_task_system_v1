if SERVER then
	priselTimer = {
	{
		name = "Travail pénitentiaire ",
		time = 1000
	},  
	{
		name = "Cantine ",
		time = 600
	}, 
	{
		name = "Sport ",
		time = 600
	}, 
	{
		name = "Douches ",
		time = 500
	},
	{
		name = "Cellule ",
		time = 500
	},
	{
		name = "Jeux ",
		time = 1200
	},
	{
		name = "Temps libre ",
		time = 1200
	}
	}
		
	priselActual = 1		locasound = Sound("sound/timersound.mp3")	
	SetGlobalString("PriselGlobalTacheName",priselTimer[priselActual].name)
		SetGlobalInt("PriselGlobalTacheTime",priselTimer[priselActual].time + CurTime())
		timer.Create("PriselTimerAutoActualizer",0.1,0,function()
			if math.Round(GetGlobalInt("PriselGlobalTacheTime") - CurTime()) < 1 then
				priselActual = priselActual + 1				if priselActual > table.Count(priselTimer) then priselActual = 1 end
				SetGlobalString("PriselGlobalTacheName",priselTimer[priselActual].name)
				SetGlobalInt("PriselGlobalTacheTime",priselTimer[priselActual].time + CurTime())
			end
		end)
end
if CLIENT then
	hook.Add("HUDPaint","PriselTimerHUD",function()
		local tempsRestant = string.FormattedTime( GetGlobalInt("PriselGlobalTacheTime") - CurTime(), "%02i:%02i" )
		draw.RoundedBox(0, ScrW() - 200, 100, 190, 25, Color(30, 30, 30, 240))
		draw.RoundedBox(0, ScrW() - 200, 125, 190, 55, Color(40, 40, 40, 220))
		draw.SimpleText("Tâche en cours","PriselFront",ScrW() - 105 ,112,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("Nom : " .. GetGlobalString("PriselGlobalTacheName"),"PriselFront",ScrW() - 190 ,140,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		draw.SimpleText("Temps restant : " .. tempsRestant,"PriselFront",ScrW() - 190 ,160,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	end)

end

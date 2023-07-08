#SingleInstance,Force

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

;++++++++++++++++++++++++++Variables++++++++++++++++++++++++++

;#Include, CaptureScreen.ahk ; assumes it's in the same folder as script

pToken := Gdip_Startup()

Global CDLModus := ""
Global CDLMode := ""
Global CDLMAPs := ""
Global CDLPlayerName := ""
Global CDLPlayerID := ""

Global CDLCurrentStat1 := ""
Global CDLCurrentStat2 := ""
Global CDLCurrentStat3 := ""
Global CDLCurrentStat4 := ""
Global CDLCurrentStat5 := ""
Global CDLCurrentStat6 := ""
Global AspectRatio := 0
Global MaxFile := 0
Global LatestGame := ""
Global NewPlayerID := ""
Global NewPlayerIDNick := ""
Global CDLFolderFileName := ""

;FileInfo
Global MaxValue := ""
Global MaxFile := ""
Global MaxFileContent := ""
Global LatestFileDat := ""
Global FileDat := 0


Global CDLUserDataFolder := A_WorkingDir "\Data\"

Global ScoreLobbyData := A_WorkingDir "\Score\PROD\"
Global ScoreLobbyResult := A_WorkingDir "\Score\PROD\Result\"
Global ScoreLobbyTestResult := A_WorkingDir "\Score\TEST\Result\"

Global ScoreFolder := A_WorkingDir "\Score\PROD\Score\"
Global ScoreTestFolder := A_WorkingDir "\Score\TEST\Score\"

Global OCRFolder := A_WorkingDir "\Score\PROD\Score\"
Global OCRTestFolder := A_WorkingDir "\Score\TEST\Score\"

Global VisualFolder := A_WorkingDir "\Visual\"
Global SoundFolder := A_WorkingDir "\Sound\"
Global ProgFolder := A_WorkingDir "\Prog\"

Global CDLCalloutsFolder := A_WorkingDir "\Visual\CDLCallouts\"

Global OCRProg := "Capture2Text_v4.6.3_64bit\Capture2Text\Capture2Text.exe"

Global GifSuccess := VisualFolder "success.gif"

Global PrimaryMon := SysGet, screenWidth, Monitor, 1

Global Testinputdata := ""

;EZQ Variables
Global CapDataPath := A_WorkingDir "\EzQ\Data\"
Global CapSoundPath := A_WorkingDir "\EzQ\Sound\"
Global MapSelection := A_WorkingDir "\EzQ\Visual\"
Global CapSuccessSound := CapSoundPath "pingu_not_not.mp3"
Global QLogFile := CapDataPath "Quicksearch_Log.txt"
Global codid := 0
Global AspectRatio := 0
Global NewMapSelect := ""
Global EzQStatusMode := ""
Global ScriptStatus := 0

Global Map1Status := 0
Global Map2Status := 0
Global Map3Status := 0
Global Map4Status := 0
Global Map5Status := 0
Global Map6Status := 0
Global Map7Status := 0
Global Map8Status := 0
Global Map9Status := 0
Global Map10Status := 0
Global Map11Status := 0
Global Map12Status := 0
Global Map13Status := 0
Global Map14Status := 0
Global Map15Status := 0
Global Map16Status := 0
Global Map17Status := 0
Global Map18Status := 0
Global Map19Status := 0
Global Map20Status := 0
Global Map21Status := 0
Global Map22Status := 0
Global Map23Status := 0
Global Map24Status := 0
Global Map25Status := 0

;pToken := Gdip_Startup()
;OnExit, Exit

;Get Screen Resolution
Global screenWidth := A_ScreenWidth
Global screenHeight := A_ScreenHeight


IF (screenWidth = 3840 && screenHeight = 2160)
	{
		AspectRatio := 1.5
	}
Else IF (screenWidth = 2560 && screenHeight = 1440)
	{
		AspectRatio := 1
	}
Else IF (screenWidth = 2304 && screenHeight = 1296)
	{
		AspectRatio := 0.9
	}
Else IF (screenWidth = 2176 && screenHeight = 1224)
	{
		AspectRatio := 0.85
	}
Else IF (screenWidth = 2048 && screenHeight = 1152)
	{
		AspectRatio := 0.8
	}
Else IF (screenWidth = 1920 && screenHeight = 1080)
	{
		AspectRatio := 0.75
	}
Else IF (screenWidth = 1280 && screenHeight = 720)
	{
		AspectRatio := 0.5
	} 
Else
	{
		AspectRatio := 1.0
		MsgBox, Unsupported Primary Monitor Screen Resolution for Data ingestion. `n`nSupported Resolutions: `n3840 * 2160 `n2560 * 1440 `n2304 * 1296 `n2176 * 1224 `n2048 * 1152 `n1920 * 1080 `n1280 * 720 `n`nOCR Recognition was done on 2560*1440 `nUsing Ratio of 1 `nTry Your luck!
	}


;++++++++++++++++++++++++++Gui Stuff++++++++++++++++++++++++++

;Gui1 Stuff
; basic elements

	
	gui, 1:add, picture, x10 y50 w200 h200 vMainPic gMainPic, %VisualFolder%MW2RT_Logo.png
	gui, 1:add, picture, x10 y39 w200 h198 vSNDPic, %VisualFolder%Snd_grey.png
	GuiControl,hide, SNDPic, 
	gui, 1:add, picture, x10 y65 w200 h171 vHPPic, %VisualFolder%HP_grey.png
	GuiControl,hide, HPPic,
	gui, 1:add, picture, x28 y38 w163 h200 vCONTPic, %VisualFolder%Control_grey.png
	GuiControl,hide, CONTPic,
	
	;gui, 1:add, picture, x0 y0, %VisualFolder%backgroundtest.png
	
	;Set tray icon
	Menu, Tray, Icon , %VisualFolder%trackericon.ico
	
	;set text properties for "Header" 
	;Gui, font,s20 Bold, Bahnschrift
	;Gui, Add, Text, +Center x20 y230 w180 h30, MODE

	;Game Mode selection buttons
	;set text properties for Button
		Gui, font,s25 Norm cBlack, Bahnschrift Condensed
		;Gui, Add, Button, x20 y280 w180 h40 vMODEBUTTON1 gSND ,SEARCH
		;Gui, Add, Button, x20 y330 w180 h40 vMODEBUTTON2 gHP ,HARDPOINT
		;Gui, Add, Button, x20 y380 w180 h40 vMODEBUTTON3 gCONT ,CONTROL
		Gui, Add, Text, x20 y250 w180 h40 Center vMODEBUTTON1 gSND, SEARCH
		;Add small horizontal line below
		Gui, Add, Text, x95 y300 w30 h1 0x7  ;Horizontal Line > Black
		Gui, Add, Text, x20 y310 w180 h40 Center vMODEBUTTON2 gHP, HARDPOINT
		;Add small horizontal line below
		Gui, Add, Text, x95 y360 w30 h1 0x7  ;Horizontal Line > Black
		Gui, Add, Text, x20 y370 w180 h40 Center vMODEBUTTON3 gCONT, CONTROL
				
				
		Gui, font,s25 Norm cBlack, Bahnschrift Condensed
		Gui, Add, Text, x230 y10 w146 h45 +Center vMAPBUTTON1 gCDLMAP1 , 
		GuiControl,Hide, MAPBUTTON1
		
		;add vertical line next to map
		;Gui, font,s3 Bold, Bahnschrift
		;Gui, Add, Text, x360 y15 h35 w1 0x7 vMap1_2_divider ;Vertical Line > Black
		;GuiControl,Hide, Map1_2_divider
		
		Gui, font,s25 Norm cBlack, Bahnschrift Condensed
		Gui, Add, Text, x376 y10 w146 h45 +Center vMAPBUTTON2 gCDLMAP2 ,
		GuiControl,Hide, MAPBUTTON2
		
		;add vertical line next to map
		;Gui, font,s3 Bold, Bahnschrift
		;Gui, Add, Text, x520 y15 h35 w1 0x7 vMap2_3_divider ;Vertical Line > Black
		;GuiControl,Hide, Map2_3_divider
		
		Gui, font,s25 Norm cBlack, Bahnschrift Condensed
		Gui, Add, Text, x522 y10 w146 h45 +Center vMAPBUTTON3 gCDLMAP3 ,
		GuiControl,Hide, MAPBUTTON3
		
		;add vertical line next to map
		;Gui, font,s3 Bold, Bahnschrift
		;Gui, Add, Text, x660 y15 h35 w1 0x7 vMap3_4_divider ;Vertical Line > Black
		;GuiControl,Hide, Map3_4_divider
		
		Gui, font,s25 Norm cBlack, Bahnschrift Condensed		
		Gui, Add, Text, x668 y10 w146 h45 +Center vMAPBUTTON4 gCDLMAP4 ,
		GuiControl,Hide, MAPBUTTON4
		
		;add vertical line next to map
		;Gui, font,s3 Bold, Bahnschrift
		;Gui, Add, Text, x820 y15 h35 w1 0x7 vMap4_5_divider ;Vertical Line > Black
		;GuiControl,Hide, Map4_5_divider
		
		Gui, font,s25 Norm cBlack, Bahnschrift Condensed
		Gui, Add, Text, x814 y10 w146 h45 +Center vMAPBUTTON5 gCDLMAP5 ,
		GuiControl,Hide, MAPBUTTON5


	;Add vertical line infront of Submit button
		Gui, font,s3 Bold, Bahnschrift
		Gui, Add, Text, x1120 y10 h45 w1 0x7  ;Vertical Line > Black
	
	;Add Field Button for Callout Maps
		Gui, font,s25 Norm cBlack, Webdings
		Gui, Add, Picture,+Center x990 y5 w45 h45 vCDLMapBTN gCDLMapBTN, %VisualFolder%map.png
		GuiControl,Hide, CDLMapBTN
	
	;Add 2 Textfields and Button in the top right corner to show selection and run the statsaver
		Gui, font,s10 Norm cBlack, Bahnschrift Light
		Gui, Add, Text,vModeStats +right x1055 y10 w60 h20, --
		Gui, Add, Text,vMapStats +right x1055 y35 w60 h20, --

		;Submit Button
		Gui, font,s25 Bold cBlack, Webdings
		Gui, Add, Picture,vSubmitStats +Center x1128 y10 w40 h40 gSubmitAction, %VisualFolder%cap.png
		GuiControl,Hide, SubmitStats
		Gui, Add, Picture,vSubmitStatsNo +Center x1128 y10 w40 h40 gSubmitAction, %VisualFolder%nocap.png
		GuiControl,Hide, SubmitStatsNo
		Gui, Add, Picture,vSubmitStatsSucess +Center x1128 y10 w42 h42 gSuccessBTNDisap, %VisualFolder%success.png
		GuiControl,Hide, SubmitStatsSucess

	;Add Field for stats display in ~"center" gui	
	;+++++Search
		Gui, font,s20 Bold, Bahnschrift
		Gui, Add, Text, x225 y100,Search
			;other infops to the right of Search desc
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x225 y225, Matches
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x280 y225 vSNDMatchesFound, 0000
			
			;Add Win loss stat
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x225 y245, W Pct
			Gui, font,s20 Norm, Bahnschrift
			Gui, Add, Text, +left x280 y240 w75 vSNDWinLoss, ""
		
			;other infos below Search
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x225 y130,K/D
			;Textfield for actual K/D Data
			Gui, font,s50 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vKDValueSearch x225 y145 w130,N/A		
			
			;Add seperator Line next to KD
			Gui, font,s3 Bold, Bahnschrift
			Gui, Add, Text, x360 y140 h110 w1 0x7  ;Vertical Line > Black
			
			;Textfield for desc Avg Score
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x370 y130,AvG Score
			;Textfield for actual Avg Score
			Gui, font,s20 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgSCOREValueSearch x370 y145 w130,N/A	
				
			;Textfield for desc Avg Kills
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x370 y185,AvG Kills
			;Textfield for actual avg kills
			Gui, font,s15 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgKILLSValueSearch x370 y200 w130,N/A	
				
			;Textfield for desc Avg Deaths
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x370 y225,AvG Deaths
			;Textfield for actual avg deaths
			Gui, font,s15 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgDEATHSValueSearch x370 y240 w130,N/A	
			
			;create label for current Map selection
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, vMainSNDMapText c0x5438FA x370 y110 w100,All
			
	;+++++Hardpoint		
		Gui, font,s20 Bold, Bahnschrift	
		Gui, Add, Text, x525 y100,Hardpoint
			;other infos below HP
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x525 y225, Matches
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x580 y225 vHPMatchesFound, 0000
			
			;Add Win loss stat
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x525 y245, W Pct
			Gui, font,s20 Norm, Bahnschrift
			Gui, Add, Text, +left x580 y240 w75 vHPWinLoss, ""

			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x525 y130,K/D
			;Textfield for actual K/D Data
			Gui, font,s50 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vKDValueHardpoint x525 y145 w130,N/A	

			;Add seperator Line next to KD
			Gui, font,s3 Bold, Bahnschrift
			Gui, Add, Text, x660 y140 h110 w1 0x7  ;Vertical Line > Black			
			
			;Textfield for desc Avg Score
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x670 y130,AvG Score
			;Textfield for actual Avg Score
			Gui, font,s20 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgSCOREValueHardpoint x670 y145 w130,N/A	
				
			;Textfield for desc Avg Kills
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x670 y185,AvG Kills
			;Textfield for actual Avg Kills
			Gui, font,s15 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgKILLSValueHardpoint x670 y200 w130,N/A	
				
			;Textfield for desc Avg Time
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x670 y225,AvG Time
			;Textfield for actual Avg Time
			Gui, font,s15 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgTimeValueHardpoint x670 y240 w130,N/A	
			
			;create label for current Map selection
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, vMainHPMapText c0x5438FA x670 y110 w100,All
			
	;+++++Control	
		Gui, font,s20 Bold, Bahnschrift
		Gui, Add, Text, x825 y100,Control
		;other infos below Control
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x825 y225, Matches
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x880 y225 vCONTMatchesFound, 0000

			;Add Win loss stat
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x825 y245, W Pct
			Gui, font,s20 Norm, Bahnschrift
			Gui, Add, Text, +left x880 y240 w75 vCONTWinLoss, ""

			;Textfield for desc Avg Kill Data
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x825 y130,AvG Kills
			;Textfield for actual Avg Kill Data
			Gui, font,s50 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgKILLSValueControl x825 y145 w130,N/A	

			;Add seperator Line next to KD
			Gui, font,s3 Bold, Bahnschrift
			Gui, Add, Text, x960 y140 h110 w1 0x7  ;Vertical Line > Black	

			;Textfield for desc Avg Dmg
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x970 y130,AvG Score
			;Textfield for actual Avg Dmg
			Gui, font,s20 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgSCOREValueControl x970 y145 w130,N/A	
				
			;Textfield for desc Avg Score
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x970 y185,AvG Damage
			;Textfield for actual Avg Dmg
			Gui, font,s15 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgDMGValueControl x970 y200 w130,N/A	
				
			;Textfield for desc Avg Dmg
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, x970 y225,AvG Captures
			;Textfield for actual Avg Dmg
			Gui, font,s15 Norm, Bahnschrift SemiLight
			Gui, Add, Text, vAvgCAPTURESValueControl x970 y240 w130,N/A	
			
			;create label for current Map selection
			Gui, font,s10 Norm, Bahnschrift
			Gui, Add, Text, vMainCONTROLMapText c0x5438FA x970 y110 w100,All



	;Display a Banner in place of buttons until buttons shown
	;set text properties for Header 
		Gui, font,s20 Bold cBlack, Bahnschrift
		Gui, Add, Text,vModeSelect +Center +BackgroundTrans x245 y10 w850 h40, Select a Mode

	;add vertical line next to mode selection
		Gui, font,s3 Bold, Bahnschrift
		Gui, Add, Text, x220 y10 h425 w1 0x7  ;Vertical Line > Black

	;Add horizontal line under maps
		Gui, font,s3 Bold, Bahnschrift
		Gui, Add, Text, x225 y60 w950 h1 0x7  ;Horizontal Line > Black

	;Add vertical line on top right next to maps for a potential info field?
		Gui, font,s3 Bold, Bahnschrift
		Gui, Add, Text, x960 y10 h45 w1 0x7 vMap5_Callout_divider  ;Vertical Line > Black
		GuiControl,Hide, Map5_Callout_divider
		
	
	;Add vertical line to the left of hardpoint	
		Gui, font,s3 Bold, Bahnschrift
		Gui, Add, Text, x520 y100 h180 w1 0x7  ;Vertical Line > Black
		
	;Add vertical line to the left of Control	
		Gui, font,s3 Bold, Bahnschrift
		Gui, Add, Text, x820 y100 h180 w1 0x7  ;Vertical Line > Black

	;Add vertical line to the right of Control
		Gui, font,s3 Bold, Bahnschrift
		Gui, Add, Text, x1120 y65 h370 w1 0x7  ;Vertical Line > Black

	;Add horizontal line under mode statistics
		Gui, font,s3 Bold, Bahnschrift
		Gui, Add, Text, x225 y285 w890 h1 0x7  ;Horizontal Line > Black

	;Add Banner for EzQ startup
		Gui, Add, Picture,w56 h356 x1122 y62 gEzQBanner vEzQBanner, %VisualFolder%EzQBannerOff.png

	;Add small Checkbox to determine if test mode or Not
		Gui, font,s8 norm cGrey, Arial
		Gui, Add, Text, x1125 y420,Debug
		Gui, font,s10 Bold cBlack, Bahnschrift
		Gui, Add, CheckBox, x1160 y420 vTestMode,

	;Create Dropdown for Selected Player and add Btn
		Gui, font,s8 norm, Bahnschrift
		Gui Add,DropDownList, x55 y10 w150 vPlayerSelect gPlayerSelect,
		Gui Add,Picture, x25 y10 w22 h22 vAddNewPlayer gAddNewPlayer, %VisualFolder%add.png
		Gui Add,Picture, x0 y0 w22 h22 vGetLatest10 gGetLatest10, %VisualFolder%graph.png

;++++++++++++++Latest game Gui info+++++++++++++++++


;Info about map and mode of last saved 
	Gui, font,s10 norm, Bahnschrift
	Gui, Add, Text, w150 x370 y290,Last Captured Game
	Gui, font,s12 norm, Wingdings
	Gui, Add, picture, w16 h16 gLatestMapModeTime x525 y290, %VisualFolder%folder.png
	Gui, font,s10 norm, Bahnschrift
	Gui, Add, Text, +Right w250 vLatestMapModeTime gLatestMapModeTime x541 y290,

		
;Add seperator Line next to result and Latestgame 
	Gui, font,s3 Bold, Bahnschrift
	Gui, Add, Text, x360 y310 h120 w1 0x7  ;Vertical Line > Black
	
	;Title for last data
	Gui, font,s8 norm, Bahnschrift
	Gui, Add, Text, w80 vLatestFiledesc1 x370 y310,
	Gui, Add, Text, w80 vLatestFiledesc2 x505 y310,
	Gui, Add, Text, w80 vLatestFiledesc3 x595 y310,
	Gui, Add, Text, w80 vLatestFiledesc4 x675 y310,
	Gui, Add, Text, w80 vLatestFiledesc5 x785 y310,
	Gui, Add, Text, w80 vLatestFiledesc6 x875 y310,
		
	;Valuefields for last data
	;Values for last Data
	Gui, font,s12 norm, Bahnschrift
	Gui, Add, Text, w80 r1 vLatestFile11 x370 y330,
	Gui, Add, Text, w80 r1 vLatestFile12 x505 y330,
	Gui, Add, Text, w80 r1 vLatestFile13 x595 y330,
	Gui, Add, Text, w80 r1 vLatestFile14 x675 y330,
	Gui, Add, Text, w80 r1 vLatestFile15 x785 y330,
	Gui, Add, Text, w80 r1 vLatestFile16 x875 y330,

	Gui, Add, Text, w80 r1 vLatestFile21 x370 y355,
	Gui, Add, Text, w80 r1 vLatestFile22 x505 y355,
	Gui, Add, Text, w80 r1 vLatestFile23 x595 y355,
	Gui, Add, Text, w80 r1 vLatestFile24 x675 y355,
	Gui, Add, Text, w80 r1 vLatestFile25 x785 y355,
	Gui, Add, Text, w80 r1 vLatestFile26 x875 y355,
	
	Gui, Add, Text, w80 r1 vLatestFile31 x370 y380,
	Gui, Add, Text, w80 r1 vLatestFile32 x505 y380,
	Gui, Add, Text, w80 r1 vLatestFile33 x595 y380,
	Gui, Add, Text, w80 r1 vLatestFile34 x675 y380,
	Gui, Add, Text, w80 r1 vLatestFile35 x785 y380,
	Gui, Add, Text, w80 r1 vLatestFile36 x875 y380,
	
	Gui, Add, Text, w80 r1 vLatestFile41 x370 y405,
	Gui, Add, Text, w80 r1 vLatestFile42 x505 y405,
	Gui, Add, Text, w80 r1 vLatestFile43 x595 y405,
	Gui, Add, Text, w80 r1 vLatestFile44 x675 y405,
	Gui, Add, Text, w80 r1 vLatestFile45 x785 y405,
	Gui, Add, Text, w80 r1 vLatestFile46 x875 y405,
	
	;Add seperator Line next to result and buttons 
	Gui, font,s3 Bold, Bahnschrift
	Gui, Add, Text, x960 y310 h120 w1 0x7  ;Vertical Line > Black
	
	
	;Add 3 buttons open the screenshot / text file with game score / Folder in explorer containing the data
	;Gui, font,s10 Bold, Wingdings
	
	;Gui, Add, Picture, x970 y290 w20 h20 gLatestGameFLD, %VisualFolder%explorer.png
	Gui, Add, Picture, x970 y290 w22 h22 gLatestGameReload, %VisualFolder%reload.png
	Gui, Add, Picture, x970 y320 w22 h22 gLatestGameTXT, %VisualFolder%document.png
	Gui, Add, Picture, x970 y350 w22 h22 gLatestGameCAP, %VisualFolder%picture.png
	Gui, Add, Picture, x970 y380 w22 h22 gLatestGameSCR, %VisualFolder%score.png
	Gui, Add, Picture, x970 y410 w22 h22 gLatestGameDEL, %VisualFolder%trash.png
	
	;Add horizontal line to split team score Win/loss
	Gui, font,s15 Bold, Bahnschrift
	Gui, Add, Text, x263 y360 w60 h1 0x7  ;Horizontal Line > Black	Gui, font,s15 Bold, Bahnschrift
	Gui, Add, Text, x263 y361 w60 h1 0x7  ;Horizontal Line > Black
	Gui, Add, Text, x263 y362 w60 h1 0x7  ;Horizontal Line > Black
	
	;Show Result own team 
	Gui, font,s40 Norm, Bahnschrift
	;Gui, Add, Text, +Right vOwnTeamRes c0x10758A x226 y300 w125, 000
	Gui, Add, Text, +center vOwnTeamRes +cBlack x228 y292 w130, 000
	
	;Show Result enemy team 
	Gui, font,s40 Norm, Bahnschrift
	;Gui, Add, Text, +Right vEnemyTeamRes c0x805F82 x226 y368 w125,000
	Gui, Add, Text, +center vEnemyTeamRes +cBlack x228 y363 w130, 000	
	
;++++++++++++++++++++++++++Player Select Dropdown++++++++++++++++++++++++++

DefaultUser := GetDefaultUser()

;Display current user or selected user
	Gui, font,s15 Norm cBlack, Microsoft YaHei UI Light
	Gui Add,Text, x225 y64 w890 vDefaultPlayer, %DefaultUser%
	
;++++++++++++++++++++++++++Call Function and subroutines on startup++++++++++++++++++++++++++	

;Call Overview stats calculator with default values for the 
;Alter variable to get default user ID

DefaultUserImputString := InStr(DefaultUser, " - ")
DefaultUserID := SubStr(DefaultUser, 1, DefaultUserImputString - 1)
CDLPlayerID = %DefaultUserID%

CalcOverviewStats(DefaultUserID,"Search","_")
CalcOverviewStats(DefaultUserID,"Hardpoint","_")
CalcOverviewStats(DefaultUserID,"Control","_")
GetLatestFile()


EZQStatus()

;+++++++++++++++Other guis++++++++++++++++++++++++++

;Player Add Gui
Gui, 2:Color, Gray
Gui, 2:font,s15 Bold, Bahnschrift
Gui, 2:Add, Edit, x10 y10 w140 h30 vNewActivisionID, ActivisionID
Gui, 2:Add, Edit, x170 y10 w140 h30 vNewActivisionIDNick, Nickname

Gui, 2:font,s10 Norm, Bahnschrift
Gui, 2:Add, Checkbox, x10 y50 w140 h20 vNewDefaultActivisionID, Default User

Gui, 2:font,s10 Norm, Bahnschrift
Gui, 2:Add, Button, x170 y50 w68 h30 gPlayerIDOk, Save
Gui, 2:Add, Button, x242 y50 w68 h30 gPlayerIDCancel, Cancel

;Gui for OCR Capping with fullscreen Screenshotdisplay
Gui, 3:destroy
Gui, 3:+AlwaysOnTop +LastFound +Owner -Caption
Gui, 3:Color, Black

;++++++++++++++++++EzQ Map Selection GUI ++++++++++++++++++++++

Gui, 9:add, picture, x10 y10 w300 h75 vMap1 gMap1, %MapSelection%Alboran.png
Gui, 9:add, picture, x10 y95 w300 h75 vMap2 gMap2, %MapSelection%Expo.png
Gui, 9:add, picture, x10 y180 w300 h75 vMap3 gMap3, %MapSelection%Kunstenaar.png
Gui, 9:add, picture, x10 y265 w300 h75 vMap4 gMap4, %MapSelection%SantaSena.png
Gui, 9:add, picture, x10 y350 w300 h75 vMap5 gMap5, %MapSelection%Vondel.png

Gui, 9:add, picture, x320 y10 w300 h75 vMap6 gMap6, %MapSelection%Asilo.png
Gui, 9:add, picture, x320 y95 w300 h75 vMap7 gMap7, %MapSelection%Farm.png
Gui, 9:add, picture, x320 y180 w300 h75 vMap8 gMap8, %MapSelection%Lighthouse.png
Gui, 9:add, picture, x320 y265 w300 h75 vMap9 gMap9, %MapSelection%Shipment.png
Gui, 9:add, picture, x320 y350 w300 h75 vMap10 gMap10, %MapSelection%Penthouse.png

Gui, 9:add, picture, x630 y10 w300 h75 vMap11 gMap11, %MapSelection%BlackGold.png
Gui, 9:add, picture, x630 y95 w300 h75 vMap12 gMap12, %MapSelection%Fortress.png
Gui, 9:add, picture, x630 y180 w300 h75 vMap13 gMap13, %MapSelection%Mercado.png
Gui, 9:add, picture, x630 y265 w300 h75 vMap14 gMap14, %MapSelection%Shoothouse.png
;Gui, 9:add, picture, x630 y350 w300 h75 vMap15 gMap15, %MapSelection%

Gui, 9:add, picture, x940 y10 w300 h75 vMap16 gMap16, %MapSelection%Dome.png
Gui, 9:add, picture, x940 y95 w300 h75 vMap17 gMap17, %MapSelection%Hotel.png
Gui, 9:add, picture, x940 y180 w300 h75 vMap18 gMap18, %MapSelection%Museum.png
Gui, 9:add, picture, x940 y265 w300 h75 vMap19 gMap19, %MapSelection%Showdown.png
;Gui, 9:add, picture, x940 y350 w300 h75 vMap20 gMap20, %MapSelection%

Gui, 9:add, picture, x1250 y10 w300 h75 vMap21 gMap21, %MapSelection%Embassy.png
Gui, 9:add, picture, x1250 y95 w300 h75 vMap22 gMap22, %MapSelection%Hydro.png
Gui, 9:add, picture, x1250 y180 w300 h75 vMap23 gMap23, %MapSelection%Raceway.png
Gui, 9:add, picture, x1250 y265 w300 h75 vMap24 gMap24, %MapSelection%Taraq.png
;Gui, 9:add, picture, x1250 y350 w300 h75 vMap25, %MapSelection%

Gui, 9:font,s20 Norm cBlack, Bahnschrift Condensed
Gui, 9:add, Button, x1250 y350 w300 h75 vOKSelect gOKSelect, Save Selection
Gui, 9:add, Button, x940 y350 w300 h75 vStartQueX gStartQue, Start EzQ

;+++++++++++++++++++++++++++Graph Data Window+++++++++++++++++++++++

Gui, 4:Add, Text, w80 r1 vGraphHeader x10 y10, MW2 Ranked Tracker Graph 
Gui, 4:add, Button, x1250 y350 w300 h75 vOKSelect gOKSelect, Save Selection
Gui, 4:add, Button, x940 y350 w300 h75 vStartQueX gStartQue, Start EzQ




;++++++++++++++++++++++++++Show Gui++++++++++++++++++++++++++

Gui, Show , w1180 h440, MW2 Ranked tracker
return

GuiClose:
ExitApp

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++END of Gui Part+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++Stats Graph+++++++++++

;show the gui on button press

MainPic(){

WinGetPos,TargetX,TargetY,,, MW2 Ranked tracker

TargetX := TargetX + 455
TargetY := TargetY + 210

Gui, 4:+LastFound
Gui, 4:Show, Center, MW2 RT Graph
WinMove, MW2 RT Graph,, %TargetX%, %TargetY%

}

;+++++++++++++++++++++++++++default User++++++++++++++++++++++++++++++++++

GetDefaultUser(){

myArray := []
;Read Data from PLayer DB File and look for default user
	Loop Read, %CDLUserDataFolder%PlayerID_DB.txt
	{
		currLine := A_LoopReadLine
		ScorePart := StrSplit(currLine, ",")
		UsrID:= ScorePart[1]
		Nick := ScorePart[2]
		DefaultUsr := ScorePart[3]
		
		If (DefaultUsr = "1"){
			DefaultUser := UsrID " - " Nick
		}
		myArray.Push(UsrID " - " Nick)
		
	}
	
	;FileRead, fileContent, %CDLUserDataFolder%PlayerID_DB.txt
	;StringSplit, lines, fileContent, `n
	
;set value for default user
	Gui, font,s15 Norm cBlack, Bahnschrift Light

;Fill Fropdown with data from array
	for index, value in myArray
	{
		GuiControl,, PlayerSelect, %value%
	}

return DefaultUser
}

;++++++++++++++++++++++++++get latest file funtions++++++++++++++++++++++++++

LatestGameTXT()
{
	if (FileExist(ScoreFolder LatestGame))
	{
	run, %ScoreFolder%%LatestGame%
	return
	}
	Else
	{
	MsgBox, Latest Game File `n%ScoreFolder%%LatestGame% `ncould not be found.
	return
	}
	return
}

LatestGameCAP()
{
	templatestPNG := RegExReplace(LatestGame,".txt",".png")
	if (FileExist(ScoreFolder templatestPNG))
	{
	run, %ScoreFolder%%templatestPNG%
	Return
	}
	Else
	{
	MsgBox, Screenshot File `n%ScoreFolder%%templatestPNG% `ncould not be found.
	Return
	}
}

LatestGameSCR()
{
		run, %ScoreLobbyResult%LobbyScore.txt
		Return
}

LatestGameReload(){
GetLatestFile()
}

LatestMapModeTime()
{
	;Run, explorer.exe "%path%"
	;Explorer := %A_WinDir%"\explorer.exe" /n,/e,
	Run %ScoreLobbyData%
}

LatestGameDEL()
{
	;MsgBox, Do you really want to delete the Game Data for 
	;delete latest Stats
	if (FileExist(ScoreFolder LatestGame))
	{
	latesTXT := ScoreFolder LatestGame
	FileDelete, %latesTXT%
	}
	Else
	{
	MsgBox, Score File Cannot be found
	return
	}
	
	;Delete Result
    File = %ScoreLobbyResult%LobbyScore.txt ; file path here
	;MsgBox, % File
	FileRead, text, %File%
	FileDelete, %File%
	FileAppend, % SubStr(text, 1, RegExMatch(text, "\R.*\R?$")-1), %File%
	
	;Delete Screencap
	templatestPNG := RegExReplace(LatestGame,".txt",".png")
	if (FileExist(ScoreFolder templatestPNG))
	{
	Screencaplatest := ScoreFolder templatestPNG
	FileDelete, %Screencaplatest%
	}
	Else
	{
	MsgBox, Screencap File cannot be found
	return
	}
	
	MsgBox, Latest Game has been Deleted!
	
	;recalc overview
	CalcOverviewStats(CDLPlayerID,"Search","_")
	CalcOverviewStats(CDLPlayerID,"Hardpoint","_")
	CalcOverviewStats(CDLPlayerID,"Control","_")
	GetLatestFile()
	return

}

GetLatest10(){


FileList := []
Loop, Files, %ScoreFolder%\*.txt
{
    FileName := SubStr(A_LoopFileName, 1, 16)
    RegExMatch(FileName, "(\d+)", Match) ; Extract the numerical value from the file name
    if (Match.Count() > 0)
        FileList.Push({Name: FileName, Value: Match[1]})
}

FileList.Sort("Value", "N Desc") ; Sort the file list based on the numerical value in descending order

LatestFiles := []
Loop, 10 ; Change the number here to retrieve a different number of files
{
    if (FileList.MaxIndex() >= A_Index)
        LatestFiles.Push(FileList[A_Index].Name)
}

; Display the latest files
Loop, % LatestFiles.Length()
{
    File := LatestFiles[A_Index]
    MsgBox, % "File #" A_Index ": " File
}

}


GetLatestFile()
{

MaxValue := ""
MaxFile := ""
MaxFileContent := ""
Row := 0
CurrentFile := ""
MapModeTimevar := ""
file_name_done := ""

	Loop, Files, %ScoreFolder%\*.txt
	{
		CurrentFile := A_LoopFileName
		First14Chars := SubStr(CurrentFile, 1, 14)
		
		if (First14Chars > MaxValue)
		{
			MaxFile := CurrentFile
			MaxFile := ScoreFolder CurrentFile
            FileRead, MaxFileContent, %MaxFile%
		}
		
	}
	
	currLatest := MaxFile
	;set the Map and mode above the stats
	
	; Extract date and time information for input_string1
	date_time_str1 := SubStr(CurrentFile, 1, 14)
	date_str := SubStr(date_time_str1, 7, 2) "/" SubStr(date_time_str1, 5, 2)
	time_str := SubStr(date_time_str1, 9, 2) ":" SubStr(date_time_str1, 11, 2)
	output_date_str := date_str " " time_str
	
	map_mode_str1 := SubStr(CurrentFile, 16, StrLen(CurrentFile))
	map_mode_str2 := RegExReplace(map_mode_str1, "_"," on ")
	output_mapmpode_str := RegExReplace(map_mode_str2, ".txt","")
	
	;file_name1 := SubStr(CurrentFile, InStr(CurrentFile, "_") + 1, StrLen(CurrentFile) - InStr(CurrentFile, "_") - 5)
	StringReplace, file_name_done, file_name1, _, %A_Space%, All
	MapModeTimevar = % output_date_str "    -    " output_mapmpode_str
	
	;set the actual textfield - latest file values atop the laststats
	GuiControl, ,LatestMapModeTime, %MapModeTimevar%
	
	;write current latest game into global variable
	LatestGame := CurrentFile
	LatestGamePure := RegexReplace(LatestGame,".txt","")

	;Look for round match result
	
	Loop, read,  %ScoreLobbyResult%LobbyScore.txt
		{
		IfInString, A_LoopReadLine, %LatestGamePure%
			{
				currLine := A_LoopReadLine
				ScorePart := StrSplit(currLine, ",")
				TeamScore:= ScorePart[2]
				EnemyScore := ScorePart[3]
			}
		}
	
	
	
	Loop, Parse, MaxFileContent, `n, `r
	{
		Row++
		Col := 0
		Loop, Parse, A_LoopField, `,
		{
			Col++
			Value := A_LoopField
			GuiControl,, LatestFile%Row%%Col%, %Value%
		}

	}

	;Change Title Text depending on mode
	; first 3 Titles are always the same
	;call function to get latest file

	if InStr(MaxFile, "Search")
	{
	GuiControl, ,LatestFiledesc1, PlayerID
	GuiControl, ,LatestFiledesc2, Score
	GuiControl, ,LatestFiledesc3, Kills
	GuiControl, ,LatestFiledesc4, Deaths
	GuiControl, ,LatestFiledesc5, Plants
	GuiControl, ,LatestFiledesc6, Defuses
	GuiControl, show, vLatestFiledesc6,
	}
	if InStr(MaxFile, "Hardpoint")
	{
	GuiControl, ,LatestFiledesc1, PlayerID
	GuiControl, ,LatestFiledesc2, Score
	GuiControl, ,LatestFiledesc3, Kills
	GuiControl, ,LatestFiledesc4, Time
	GuiControl, ,LatestFiledesc5, Deaths
	GuiControl, ,LatestFiledesc6, Defends
	GuiControl, show, vLatestFiledesc6,
 	}
	if InStr(MaxFile, "Control")
	{
	GuiControl,,LatestFiledesc1, PlayerID
	GuiControl,,LatestFiledesc2, Score
	GuiControl,,LatestFiledesc3, Kills
	GuiControl,,LatestFiledesc4, Captures
	GuiControl,,LatestFiledesc5, Damage
	GuiControl,,LatestFiledesc6, 
	GuiControl, hide, vLatestFiledesc6,
	GuiControl,,LatestFile16,
	GuiControl,,LatestFile26,
	GuiControl,,LatestFile36,
	GuiControl,,LatestFile46,
	}
	
	;write result to both fields
	GuiControl,,OwnTeamRes, %TeamScore%
	GuiControl,,EnemyTeamRes, %EnemyScore%
	
	
}

;++++++++++++++++++++++++++EZQ Online Status+++++++++++++++++++++++++++++++++++

EZQStatus(){

	script1 := A_WorkingDir "\EzQ.ahk"
	ScriptStatus := IsRunning(script1)
	
	Process, Exist , EzQ.exe
	If (ErrorLevel = 0){
	ScriptStatus = 0
	;If (ScriptStatus = 1) {
	GuiControl,1:,EzQBanner, %VisualFolder%EzQBannerOff.png
	GuiControl,1:show,EzQBanner,
	}
	Else
	{
	ScriptStatus = 1
	GuiControl,1:,EzQBanner, %VisualFolder%EzQBannerOn.png
	GuiControl,1:show,EzQBanner,
	}
	
	return ; End of auto-execute
}



IsRunning(Path) {
    SetTitleMatchMode 2
    DetectHiddenWindows On

	If WinExist(Path) = 0x0 {
	Path := 0
	}
	Else {
	Path := 1
	}

    return Path
}

;++++++++++++++++++++++++++New Player ID Input window++++++++++++++++++++++++++

AddNewPlayer(){
;Player Select Gui

GuiControl,2:, NewActivisionID, ActivisionID
GuiControl,2:, NewActivisionIDNick, Nickname

WinGetPos,TargetX,TargetY,,, MW2 Ranked tracker

TargetX := TargetX + 455
TargetY := TargetY + 210

Gui, 2:+LastFound +Caption
Gui, 2:Show,, MW2 RT - New PlayerID
WinMove, MW2 RT New PlayerID,, %TargetX%, %TargetY%

Return
}

PlayerIDOk(){
	gui 2: submit
	;GuiControlGet, NewActivisionID
	;NewPlayerID = GuiControlGet, NewActivisionID
	GuiControlGet, NewPlayerID, 2:, NewActivisionID
	GuiControlGet, NewPlayerIDNick, 2:, NewActivisionIDNick
	
;Read Data from PLayer DB File and split on linebreak

	If (StrLen(NewPlayerID) > 7 || StrLen(NewPlayerID) < 7)
	{
		MsgBox, ID has to be a 7 digit number
		Gui, 2:+LastFound
		Gui, 2:Show,, MW2 RT New PlayerID
	}
	else if (NewPlayerIDNick = "Nickname")
	{
		MsgBox, Please use a custom Nickname
		Gui, 2:+LastFound
		Gui, 2:Show,, MW2 RT New PlayerID
	}
	else If (NewPlayerID is integer)
	{
		
		GuiControlGet, checked,, NewDefaultActivisionIDNick		
		
		File := %CDLUserDataFolder%PlayerID_DB.txt
		
		LineNumber := 3  ; The line number you want to update
		NewValue := "New line content"  ; The new content for the line

		; Read the contents of the file
		FileRead, Contents, %File%

		; Split the contents into an array of lines
		StringSplit, Lines, Contents, `n

		; Update the specified line
		Lines[LineNumber] := NewValue

		; Join the lines back into a single string
		UpdatedContents := ""
		Loop, % Lines.MaxIndex()
		{
			UpdatedContents .= Lines[A_Index]
			if (A_Index < Lines.MaxIndex())
			UpdatedContents .= "`n"
		}

		; Write the updated contents back to the file
		FileDelete, %File%
		FileAppend, %UpdatedContents%, %File%
		
		
		
	
		
		Loop, read, %CDLUserDataFolder%PlayerID_DB.txt
			{
				IfInString, A_LoopReadLine, %NewPlayerID%
				{
				MsgBox, Activision ID already exists
				Gui, 2: Cancel
				return
				}
			}
		
			;write to File
			ID_Nick := NewPlayerID "," NewPlayerIDNick
			Fileappend, `n%NewPlayerID%`,%NewPlayerIDNick%`,%checked%, %CDLUserDataFolder%PlayerID_DB.txt
			Gui, 2: Cancel
		return
	}
	return
}

	
PlayerIDCancel(){
	Gui, 2: Cancel
	Return
}


;++++++++++++++++++++++++++Calculate Stats++++++++++++++++++++++++++

CalcOverviewStats(PlayerVar, FolderGameType, FolderMapType)
{
	;Set variables to be filled
	SumSNDKills := 0
	SumHPKills := 0
	SumCONTKills := 0
	SumHPDeaths := 0
	SumSNDDeaths :=
	SumSNDScore:= 0
	SumHPScore:= 0
	SumCONTScore:= 0
	SumPlants := 0
	SumDefuses := 0
	SumDefends := 0
	SumHPTime := 0
	SumCaps := 0
	SumDmg := 0
	SumSNDCount := 0
	SumHPCount := 0
	SumCONTCount := 0
	HPtotalMinutes := 0
	WinLossinfo := 0
	entriesfound := 0
	WinStat := 0
	LossStat := 0
			
	;MsgBox, %PlayerVar%, %FolderGameType%, %FolderMapType% 
	Loop, Files, %ScoreFolder%*%FolderGameType%**%FolderMapType%*.txt, R
	{
		filePath := A_LoopFileFullPath
		fileName := A_LoopFileName

		entriesfound += 1
		; Read the data from the text file
						
		FileRead, fileContent, %filePath%
			pureName := RegExReplace(fileName,".txt","")		
			
			StringReplace, fileContent, fileContent, `r, , All
			Loop, Parse, fileContent, `n
			{
			row := A_LoopField
			if (row = "")
			continue
			
			; Split the row into an array of columns using semicolon as the separator
			StringSplit, columns, row, `,

			; Get the value from the columns
			PlayerID := columns1
			CDL_Score:= columns2
			CDL_Kills := columns3
			CDL_COL4:= columns4
			CDL_COL5 := columns5
			CDL_COL6 := columns6
			
	
			
								
			; Check if the value in the first column matches PlayerVar and Type is s Search
			if (PlayerID = PlayerVar && FolderGameType = "Search")
				{
							
				; Add the value from the fourth column to the SumColumn4
				SumSNDScore += CDL_Score
				SumSNDKills += CDL_Kills
				SumSNDDeaths += CDL_COL4
				SumPlants += CDL_COL5
				SumDefuses += CDL_COL6
				SumSNDCount += 1
				
				;WinLossinfo
				Loop, read,  %ScoreLobbyResult%LobbyScore.txt
				{
				IfInString, A_LoopReadLine, %pureName%
					{
						currLine := A_LoopReadLine
						ScorePart := StrSplit(currLine, ",")
						TeamScore:= ScorePart[2]
						EnemyScore := ScorePart[3]
						if (TeamScore > EnemyScore)
							{
								WinStat += 1
							}
						Else
							{
								LossStat += 1
							}
					}
				}
				
				
				}
											
			; Check if the value in the first column matches PlayerVar and Type is s Hardpoint
			if (PlayerID = PlayerVar && FolderGameType = "Hardpoint")
				{
				pureName := RegExReplace(fileName,".txt","")							
				; Add the value from the fourth column to the SumColumn4
				SumHPScore += CDL_Score
				SumHPKills += CDL_Kills
				SumHPDeaths += CDL_COL5
				;SumHPTime += CDL_COL4
				SumDefends += CDL_COL6
				SumHPCount += 1
									
				HPtimeParts := StrSplit(CDL_COL4, ":")
				HPminutes := HPtimeParts[1]
				HPseconds := HPtimeParts[2]
				HPtotalSeconds += (HPminutes * 60) + HPseconds
				
				;WinLossinfo
				Loop, read,  %ScoreLobbyResult%LobbyScore.txt
				{
				IfInString, A_LoopReadLine, %pureName%
					{
						currLine := A_LoopReadLine
						ScorePart := StrSplit(currLine, ",")
						TeamScore:= ScorePart[2]
						EnemyScore := ScorePart[3]
						if (TeamScore > EnemyScore)
							{
								WinStat += 1
							}
						Else
							{
								LossStat += 1
							}
					}
				}
				
				
				
				}
											
			; Check if the value in the first column matches PlayerVar and Type is s Hardpoint
			if (PlayerID = PlayerVar && FolderGameType = "Control")
				{
				; Add the value from the fourth column to the SumColumn4
				SumCONTScore += CDL_Score
				SumCONTKills += CDL_Kills
				SumCaps += CDL_COL4
				SumDmg += CDL_COL5
				SumCONTCount += 1

				;WinLossinfo
				Loop, read,  %ScoreLobbyResult%LobbyScore.txt
				{
				IfInString, A_LoopReadLine, %pureName%
					{
						currLine := A_LoopReadLine
						ScorePart := StrSplit(currLine, ",")
						TeamScore:= ScorePart[2]
						EnemyScore := ScorePart[3]
						if (TeamScore > EnemyScore)
							{
								WinStat += 1
							}
						Else
							{
								LossStat += 1
							}
					}
				}
				
				}
			}
	}
	
	;write and caluclate values to Gui fields
	;Set values if Search
	if (FolderGameType = "Search")
	{
	SNDKD := SumSNDKills / SumSNDDeaths
	SNDKD := Format("{:0.2f}", SNDKD)
	GuiControl,, KDValueSearch, %SNDKD%
	
	SNDavgScore := SumSNDScore / SumSNDCount
	SNDavgScore := Format("{:0.0f}", SNDavgScore)
	GuiControl,, AvgSCOREValueSearch, %SNDavgScore%
	
	SNDavgKlls := SumSNDKills / SumSNDCount
	SNDavgKlls := Format("{:0.1f}", SNDavgKlls)
	GuiControl,, AvgKILLSValueSearch, %SNDavgKlls%
	
	SNDavgDeaths := SumSNDDeaths / SumSNDCount
	SNDavgDeaths := Format("{:0.1f}", SNDavgDeaths)
	GuiControl,, AvgDEATHSValueSearch, %SNDavgDeaths%
	
	WinLossRatio := WinStat "/" LossStat
	WinLossPerc1 += WinStat + LossStat
	WinLossPerc2 += Format("{:d}",WinStat / WinLossPerc1 * 100)
	GuiControl,, SNDWinLoss, % WinLossPerc2
	
	GuiControl,, SNDMatchesFound, %SumSNDCount%
	
	return
	}

	;Set value if HP
	if (FolderGameType = "Hardpoint")
	{
	HPKD := SumHPKills / SumHPDeaths
	HPKD := Format("{:0.2f}", HPKD)
	GuiControl,, KDValueHardpoint, %HPKD%
	
	HPavgScore := SumHPScore / SumHPCount
	HPavgScore := Format("{:0.0f}", HPavgScore)
	GuiControl,, AvgSCOREValueHardpoint, %HPavgScore%
	
	HPavgKlls := SumHPKills / SumHPCount
	HPavgKlls := Format("{:0.1f}", HPavgKlls)
	GuiControl,, AvgKILLSValueHardpoint, %HPavgKlls%
	
	HPavgTime := HPtotalSeconds // SumHPCount
	;HPavgTime := HPavgTime / 60
	;HPavgTime := Round(HPavgTime, 2)

	GuiControl,, AvgTimeValueHardpoint, %HPavgTime% sec
	
	WinLossRatio := WinStat "/" LossStat
	WinLossPerc1 += WinStat + LossStat
	WinLossPerc2 += Format("{:d}",WinStat / WinLossPerc1 * 100)
	GuiControl,, HPWinLoss, % WinLossPerc2
	
	GuiControl,, HPMatchesFound, %SumHPCount%
	
	return
	}

	;Set value if Control
	if (FolderGameType = "Control")
	{
	CONTavgKILLS := SumCONTKills / SumCONTCount
	CONTavgKILLS := Format("{:0.0f}", CONTavgKILLS)
	GuiControl,, AvgKILLSValueControl, %CONTavgKILLS%	
	
	CONTavgScore := SumCONTScore / SumCONTCount
	CONTavgScore := Format("{:0.0f}", CONTavgScore)
	GuiControl,, AvgSCOREValueControl, %CONTavgScore%
	
	HPavgDamage := SumDmg / SumCONTCount
	HPavgDamage := Format("{:0.0f}", HPavgDamage)
	GuiControl,, AvgDMGValueControl, %HPavgDamage%
	
	HPavgCaptures := SumCaps / SumCONTCount
	HPavgCaptures := Format("{:0.1f}", HPavgCaptures)
	GuiControl,, AvgCAPTURESValueControl, %HPavgCaptures%
	
	WinLossRatio := WinStat "/" LossStat
	WinLossPerc1 += WinStat + LossStat
	WinLossPerc2 += Format("{:d}",WinStat / WinLossPerc1 * 100)
	GuiControl,, CONTWinLoss, % WinLossPerc2
	
	GuiControl,, CONTMatchesFound, %SumCONTCount%
	
	return	
	}
return	
}

;++++++++++++++++++++++++++Calc Aspect Ratio++++++++++++++++++++++++++

AspectCalc(aDefAspect = "")
{
	CoordVal_Array := []
	CoordVal_Array := StrSplit(aDefAspect, A_Space) ; Omits periods.
	
    x1 := Format("{:d}", CoordVal_Array[1] * AspectRatio)
    y1 := Format("{:d}", CoordVal_Array[2] * AspectRatio)
    x2 := Format("{:d}", CoordVal_Array[3] * AspectRatio)
    y2 := Format("{:d}", CoordVal_Array[4] * AspectRatio)
    NewRectVal := x1 " " y1 " " x2 " " y2
	
    return NewRectVal
	
}


;++++++++++++++++++++++++++Change Selected Player++++++++++++++++++++++++++

PlayerSelect:
{
	Gui, Submit, NoHide,

	;get currently selected Player and display instead of default user
	GuiControlGet, selectedValue, , PlayerSelect
	SelFromDrop := selectedValue
	GuiControl,, DefaultPlayer, %SelFromDrop%
	;hide submit button after selecting a mode as there is not map selected yet
	GuiControl,hide, SubmitStats
	GuiControl,hide, SubmitStatsNo
	
	;empty and set mode on top right textbox
	GuiControl,, ModeStats, --
	GuiControl,, MapStats, --
	
	;Update Mode buttons to default
	GuiControl,+cBlack +Redraw, MODEBUTTON1, SEARCH
	GuiControl,+cBlack +Redraw, MODEBUTTON2, HARDPOINT
	GuiControl,+cBlack +Redraw, MODEBUTTON3, CONTROL
	
	;Show banner and hide the button
	GuiControl,show, ModeSelect
	GuiControl,+cBlack +Redraw, MAPBUTTON1,
	GuiControl,hide, MAPBUTTON1
	GuiControl,+cBlack +Redraw, MAPBUTTON2,
	GuiControl,hide, MAPBUTTON2 
	GuiControl,+cBlack +Redraw, MAPBUTTON3,
	GuiControl,hide, MAPBUTTON3 
	GuiControl,+cBlack +Redraw, MAPBUTTON4,
	GuiControl,hide, MAPBUTTON4
	GuiControl,+cBlack +Redraw, MAPBUTTON5,
	GuiControl,hide, MAPBUTTON5
	
	GuiControl,show, MainPic 
	GuiControl,hide, SNDPic 
	GuiControl,hide, HPPic
	GuiControl,hide, CONTPic
	GuiControl,Hide, Map5_Callout_divider
	
	
	CurrentUserImputString := InStr(SelFromDrop, " - ")
	CurrentUserID := SubStr(SelFromDrop, 1, CurrentUserImputString - 1)
	
	CalcOverviewStats(CurrentUserID,"Search","_")
	CalcOverviewStats(CurrentUserID,"Hardpoint","_")
	CalcOverviewStats(CurrentUserID,"Control","_")
	
	;change color of Map info in stats to blue
	GuiControl, +c0x5438FA, MainSNDMapText
	GuiControl,, MainSNDMapText,All
	GuiControl, +c0x5438FA, MainHPMapText
	GuiControl,, MainHPMapText,All
	GuiControl, +c0x5438FA, MainCONTROLMapText
	GuiControl,, MainCONTROLMapText,All
	
	GuiControl,Hide, CDLMapBTN
	GuiControl,Hide, Map1_2_divider
	GuiControl,Hide, Map2_3_divider
	GuiControl,Hide, Map3_4_divider
	GuiControl,Hide, Map4_5_divider
	
	GuiControl,, ModeSelect, Select a Mode
	
	return
}

;++++++++++++++++++++++++++StatSaverButtonPress++++++++++++++++++++++++++

SubmitAction:
{
	Gui, Submit, Hide,
	
	MsgBox, 4,, Would you like to Capture %CDLModus% on %CDLMAPs%?
	IfMsgBox Yes
	{
	SplashTextOn,400,70, MW2 Ranked Tracker, Scoreboard has to be visible on Primary Monitor in `n`n3 seconds
	Sleep 1000
	SplashTextOn,400,70, MW2 Ranked Tracker, Scoreboard has to be visible on Primary Monitor in `n`n2 seconds
	Sleep 1000
	SplashTextOn,400,70, MW2 Ranked Tracker, Scoreboard has to be visible on Primary Monitor in `n`n1 seconds
	Sleep 1000
	SplashTextOff
	;change Submit button when pressed run logic and change button back
	
	;here goes the logic
	if CDLModus = Search
		{
		SnDOCR(CDLMap)
		}
	if CDLModus = Hardpoint
		{
		HPOCR(CDLMap)
		}
	if CDLModus = Control
		{
		ContOCR(CDLMap)
		}
		
	;empty and set mode on top right textbox
	GuiControl,, ModeStats, --
	GuiControl,, MapStats, --
	
	;Update Mode buttons to default
	GuiControl,+cBlack +Redraw, MODEBUTTON1, SEARCH
	GuiControl,+cBlack +Redraw, MODEBUTTON2, HARDPOINT
	GuiControl,+cBlack +Redraw, MODEBUTTON3, CONTROL
	
	;Show banner and hide the button
	GuiControl,show, ModeSelect
	GuiControl,+cBlack +Redraw, MAPBUTTON1,
	GuiControl,hide, MAPBUTTON1
	GuiControl,+cBlack +Redraw, MAPBUTTON2,
	GuiControl,hide, MAPBUTTON2 
	GuiControl,+cBlack +Redraw, MAPBUTTON3,
	GuiControl,hide, MAPBUTTON3 
	GuiControl,+cBlack +Redraw, MAPBUTTON4,
	GuiControl,hide, MAPBUTTON4
	GuiControl,+cBlack +Redraw, MAPBUTTON5,
	GuiControl,hide, MAPBUTTON5
	
	GuiControl,show, MainPic 
	GuiControl,hide, SNDPic 
	GuiControl,hide, HPPic
	GuiControl,hide, CONTPic
	
	GuiControl, +c0x5438FA, MainCONTROLMapText
	GuiControl,, MainCONTROLMapText,All	
	
	GuiControl,, ModeSelect, %CDLModus% on %CDLMap% - has been saved! 
	GuiControl,show, ModeSelect
	
	GuiControl,hide, SubmitStats
	GuiControl,hide, SubmitStatsNo
	GuiControl,Hide, CDLMapBTN
	GuiControl,Hide, Map1_2_divider
	GuiControl,Hide, Map2_3_divider
	GuiControl,Hide, Map3_4_divider
	GuiControl,Hide, Map4_5_divider
	GuiControl,Hide, Map5_Callout_divider
	
	;change color of Map info in stats to blue
	GuiControl, +c0x5438FA, MainSNDMapText
	GuiControl,, MainSNDMapText,All
	GuiControl, +c0x5438FA, MainHPMapText
	GuiControl,, MainHPMapText,All
	GuiControl, +c0x5438FA, MainCONTROLMapText
	GuiControl,, MainCONTROLMapText,All
	
	CalcOverviewStats(CurrentUserID,CDLModus,"_")
	GetLatestFile()
	GuiControl,Show, SubmitStatsSucess
	GuiControl,hide, SubmitStats
	GuiControl,hide, SubmitStatsNo
	SetTimer, SuccessBTNDisap,3000
	
	return
	}
	else
	{
	Gui, show,
	return
	}
	return
}

SuccessBTNDisap:
{
	GuiControl,hide, SubmitStatsSucess
	return
}

;++++++++++++++++++++++++++MODES Button Action++++++++++++++++++++++++++

SND:
{
	Gui, Submit, NoHide,
	CDLModus := "Search"
	CDLModeType := "SEARCH"
	;Gui, font,s15, Bahnschrift Condensed
	
	;hide submit button after selecting a mode as there is not map selected yet
	GuiControl,hide, SubmitStats
	GuiControl,hide, SubmitStatsNo
	
	;empty and set mode on top right textbox
	GuiControl,, ModeStats, 
	GuiControl,, MapStats, 
	GuiControl,, ModeStats, %CDLModus%
	
	;Update buttons
	GuiControl,+c0x5438FA +Redraw, MODEBUTTON1, %CDLModeType%
	GuiControl,+cBlack +Redraw, MODEBUTTON2, HARDPOINT
	GuiControl,+cBlack +Redraw, MODEBUTTON3, CONTROL
	
	GuiControl,hide, MainPic
	GuiControl,show, SNDPic 
	GuiControl,hide, HPPic
	GuiControl,hide, CONTPic
	
	;hide the banner
	GuiControl,hide, ModeSelect	
	
	GuiControl,+cBlack +Redraw, MAPBUTTON1,
	GuiControl,, MAPBUTTON1, Hotel
	GuiControl,show, MAPBUTTON1
	GuiControl,+cBlack +Redraw, MAPBUTTON2,
	GuiControl,, MAPBUTTON2, Embassy
	GuiControl,show, MAPBUTTON2
	GuiControl,+cBlack +Redraw, MAPBUTTON3,
	GuiControl,, MAPBUTTON3, Mercado
	GuiControl,show, MAPBUTTON3
	GuiControl,+cBlack +Redraw, MAPBUTTON4,
	GuiControl,, MAPBUTTON4, Fortress
	GuiControl,show, MAPBUTTON4
	GuiControl,+cBlack +Redraw, MAPBUTTON5,
	GuiControl,, MAPBUTTON5, Asilo
	GuiControl,show, MAPBUTTON5
	
	GuiControl,Hide, CDLMapBTN
	GuiControl,show, Map1_2_divider
	GuiControl,show, Map2_3_divider
	GuiControl,show, Map3_4_divider
	GuiControl,show, Map4_5_divider
	GuiControl,show, Map5_Callout_divider
	
;	GuiControl, +c0x5438FA, MainSNDMapText
;	GuiControl,, MainSNDMapText,All
	
	return
}

HP:
{
	Gui, Submit, NoHide,
	CDLModus := "Hardpoint"
	CDLModeType := "HARDPOINT"
	;Gui, font,s15, Bahnschrift Condensed
	
	;hide submit button after selecting a mode as there is not map selected yet
	GuiControl,hide, SubmitStats
	GuiControl,hide, SubmitStatsNo
	
	;empty and set mode on top right textbox
	GuiControl,, ModeStats, 
	GuiControl,, MapStats, 
	GuiControl,, ModeStats, %CDLModus%
	
	;update buttons	
	GuiControl,+cBlack +Redraw, MODEBUTTON1, SEARCH
	GuiControl,+c0x5438FA +Redraw, MODEBUTTON2, %CDLModeType%
	GuiControl,+cBlack +Redraw, MODEBUTTON3, CONTROL
	
	GuiControl,hide, MainPic
	GuiControl,hide, SNDPic 
	GuiControl,show, HPPic
	GuiControl,hide, CONTPic
	
	;hide the banner
	GuiControl,hide, ModeSelect	
	GuiControl,+cBlack +Redraw, MAPBUTTON1,
	GuiControl,, MAPBUTTON1, Hotel
	GuiControl,show, MAPBUTTON1
	GuiControl,+cBlack +Redraw, MAPBUTTON2,
	GuiControl,, MAPBUTTON2, Embassy
	GuiControl,show, MAPBUTTON2
	GuiControl,+cBlack +Redraw, MAPBUTTON3,
	GuiControl,, MAPBUTTON3, Mercado
	GuiControl,show, MAPBUTTON3
	GuiControl,+cBlack +Redraw, MAPBUTTON4,
	GuiControl,, MAPBUTTON4, Fortress
	GuiControl,show, MAPBUTTON4
	GuiControl,+cBlack +Redraw, MAPBUTTON5,
	GuiControl,, MAPBUTTON5, Hydro
	GuiControl,show, MAPBUTTON5
	
	GuiControl,Hide, CDLMapBTN
	GuiControl,show, Map1_2_divider
	GuiControl,show, Map2_3_divider
	GuiControl,show, Map3_4_divider
	GuiControl,show, Map4_5_divider
	GuiControl,show, Map5_Callout_divider
	
	
;	GuiControl, +c0x5438FA, MainHPMapText
;	GuiControl,, MainHPMapText,All

	return
}

CONT:
{
	Gui, Submit, NoHide,
	CDLModus := "Control"
	CDLModeType := "CONTROL"
	;Gui, font,s15, Bahnschrift Condensed
	
	;hide submit button after selecting a mode as there is not map selected yet
	GuiControl,hide, SubmitStats
	GuiControl,hide, SubmitStatsNo
	
	;empty and set mode on top right textbox
	GuiControl,, ModeStats, 
	GuiControl,, MapStats, 
	GuiControl,, ModeStats, %CDLModus%
	
	;update buttons
	GuiControl,+cBlack +Redraw, MODEBUTTON1, SEARCH
	GuiControl,+cBlack +Redraw, MODEBUTTON2, HARDPOINT
	GuiControl,+c0x5438FA +Redraw, MODEBUTTON3, %CDLModeType%
	
	GuiControl,hide, MainPic
	GuiControl,hide, SNDPic 
	GuiControl,hide, HPPic
	GuiControl,show, CONTPic
	
	;hide the banner
	GuiControl,hide, ModeSelect
	GuiControl,+cBlack +Redraw, MAPBUTTON1,
	GuiControl,, MAPBUTTON1, Hotel
	GuiControl,show, MAPBUTTON1
	GuiControl,+cBlack +Redraw, MAPBUTTON2,
	GuiControl,, MAPBUTTON2, Asilo
	GuiControl,show, MAPBUTTON2
	GuiControl,+cBlack +Redraw, MAPBUTTON3,
	GuiControl,, MAPBUTTON3, Expo
	GuiControl,show, MAPBUTTON3
	GuiControl,+cBlack +Redraw, MAPBUTTON4,
	GuiControl,, MAPBUTTON4,
	GuiControl,Hide, MAPBUTTON4
	GuiControl,+cBlack +Redraw, MAPBUTTON5,
	GuiControl,, MAPBUTTON5,
	GuiControl,Hide, MAPBUTTON5
	
	GuiControl,Hide, CDLMapBTN
	GuiControl,show, Map1_2_divider
	GuiControl,show, Map2_3_divider
	GuiControl,hide, Map3_4_divider
	GuiControl,hide, Map4_5_divider
	GuiControl,show, Map5_Callout_divider

;	GuiControl, +c0x5438FA, MainCONTROLMapText
;	GuiControl,, MainCONTROLMapText,All

	return
}


;++++++++++++++++++++++++++Maps Buttons Action++++++++++++++++++++++++++

CDLMAP1:
{

	Gui, Submit, NoHide,
	GuiControlGet, CDLmap,, % A_GuiControl
	CDLmap := Trim(CDLmap, OmitChars:= "-")
	;Gui, font,s15, Bahnschrift Condensed
	CDLMAPs := CDLmap 
	
	;enable submit button after selecting a map
	If (AspectRatio = "1.0") {
	GuiControl,show, SubmitStatsNo
	}
	Else {
	GuiControl,show, SubmitStats
	}
	
	;set map on top right textbox
	GuiControl,, MapStats, %CDLmap%
		
	if CDLModus = Search
		{
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON1, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Embassy
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Mercado
		GuiControl,+cBlack +Redraw, MAPBUTTON4, Fortress
		GuiControl,+cBlack +Redraw, MAPBUTTON5, Asilo
		GuiControl, +cgreen, MainSNDMapText
		GuiControl,, MainSNDMapText,%CDLmap%
		}
	if CDLModus = Hardpoint
		{
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON1, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Embassy
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Mercado
		GuiControl,+cBlack +Redraw, MAPBUTTON4, Fortress
		GuiControl,+cBlack +Redraw, MAPBUTTON5, Hydro
		GuiControl, +cgreen, MainHPMapText
		GuiControl,, MainHPMapText,%CDLmap%

		}
	if CDLModus = Control
		{
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON1, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Asilo
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Expo
		GuiControl,+cBlack +Redraw, MainCONTROLMapText,%CDLmap%
		GuiControl, +cgreen, MainCONTROLMapText
		GuiControl,, MainCONTROLMapText,%CDLmap%
		}
	 
	
	;Call funtion with current user and selected map
	GuiControlGet, CurrentUserImputString,, DefaultPlayer
	GuiControlGet, CurrentModeImputString,, ModeStats
	GuiControlGet, CurrentMapImputString,, MapStats
		CurrentUserImputStringLen := InStr(CurrentUserImputString, " - ")
	CurrentUserID := SubStr(CurrentUserImputString, 1, CurrentUserImputStringLen - 1)
	CalcOverviewStats(CurrentUserID,CurrentModeImputString,CurrentMapImputString)
	
	;Show Mapbutton
	GuiControl,show, CDLMapBTN
	
	return
}

CDLMAP2:
{
	Gui, Submit, NoHide,
	GuiControlGet, CDLmap,, % A_GuiControl
	CDLmap := Trim(CDLmap, OmitChars:= "-")
	;Gui, font,s15, Bahnschrift Condensed
	CDLMAPs := CDLmap
	
	;enable submit button after selecting a map
	If (AspectRatio = "1.0") {
	GuiControl,show, SubmitStatsNo
	}
	Else {
	GuiControl,show, SubmitStats
	}
	
	
	;set map on top right textbox
	GuiControl,, MapStats, %CDLmap%
	
	if CDLModus = Search
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON2, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Mercado
		GuiControl,+cBlack +Redraw, MAPBUTTON4, Fortress
		GuiControl,+cBlack +Redraw, MAPBUTTON5, Asilo
		GuiControl, +cgreen, MainSNDMapText
		GuiControl,, MainSNDMapText,%CDLmap%
		}
	if CDLModus = Hardpoint
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON2, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Mercado
		GuiControl,+cBlack +Redraw, MAPBUTTON4, Fortress
		GuiControl,+cBlack +Redraw, MAPBUTTON5, Hydro
		GuiControl, +cgreen, MainHPMapText
		GuiControl,, MainHPMapText,%CDLmap%
		}
	if CDLModus = Control
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON2, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Expo
		GuiControl,+cBlack +Redraw, MainCONTROLMapText,%CDLmap%		
		GuiControl, +cgreen, MainCONTROLMapText
		GuiControl,, MainCONTROLMapText,%CDLmap%
		}
		
	;Call funtion with current user and selected map
	GuiControlGet, CurrentUserImputString,, DefaultPlayer
	GuiControlGet, CurrentModeImputString,, ModeStats
	GuiControlGet, CurrentMapImputString,, MapStats
		CurrentUserImputStringLen := InStr(CurrentUserImputString, " - ")
	CurrentUserID := SubStr(CurrentUserImputString, 1, CurrentUserImputStringLen - 1)
	CalcOverviewStats(CurrentUserID,CurrentModeImputString,CurrentMapImputString)
 
	;Show Mapbutton
	GuiControl,show, CDLMapBTN
 
	return
}

CDLMAP3:
{
	Gui, Submit, NoHide,
	GuiControlGet, CDLmap,, % A_GuiControl
	CDLmap := Trim(CDLmap, OmitChars:= "-")
	;Gui, font,s15, Bahnschrift Condensed
	CDLMAPs := CDLmap
	
	;enable submit button after selecting a map
	If (AspectRatio = "1.0") {
	GuiControl,show, SubmitStatsNo
	}
	Else {
	GuiControl,show, SubmitStats
	}
	
	
	;set map on top right textbox
	GuiControl,, MapStats, %CDLmap%
	
	if CDLModus = Search
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Embassy
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON3, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON4, Fortress
		GuiControl,+cBlack +Redraw, MAPBUTTON5, Asilo
		GuiControl, +cgreen, MainSNDMapText
		GuiControl,, MainSNDMapText,%CDLmap%
		}
	if CDLModus = Hardpoint
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Embassy
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON3, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON4, Fortress
		GuiControl,+cBlack +Redraw, MAPBUTTON5, Hydro
		GuiControl, +cgreen, MainHPMapText
		GuiControl,, MainHPMapText,%CDLmap%
		}
	if CDLModus = Control
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Asilo
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON3, %CDLmap%
		GuiControl, +cgreen, MainCONTROLMapText
		GuiControl,, MainCONTROLMapText,%CDLmap%
		}
	
	;Call funtion with current user and selected map
	GuiControlGet, CurrentUserImputString,, DefaultPlayer
	GuiControlGet, CurrentModeImputString,, ModeStats
	GuiControlGet, CurrentMapImputString,, MapStats
		CurrentUserImputStringLen := InStr(CurrentUserImputString, " - ")
	CurrentUserID := SubStr(CurrentUserImputString, 1, CurrentUserImputStringLen - 1)
	CalcOverviewStats(CurrentUserID,CurrentModeImputString,CurrentMapImputString)

	;Show Mapbutton
	GuiControl,show, CDLMapBTN

	return
}

CDLMAP4:
{
	Gui, Submit, NoHide,
	GuiControlGet, CDLmap,, % A_GuiControl
	CDLmap := Trim(CDLmap, OmitChars:= "-")
	;Gui, font,s15, Bahnschrift Condensed
	CDLMAPs := CDLmap
	
	;enable submit button after selecting a map
	If (AspectRatio = "1.0") {
	GuiControl,show, SubmitStatsNo
	}
	Else {
	GuiControl,show, SubmitStats
	}
	
	
	;set map on top right textbox
	GuiControl,, MapStats, %CDLmap%
	
	
	if CDLModus = Search
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Embassy
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Mercado
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON4, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON5, Asilo
		GuiControl, +cgreen, MainSNDMapText
		GuiControl,, MainSNDMapText,%CDLmap%
		}
	if CDLModus = Hardpoint
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Embassy
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Mercado
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON4, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON5, Hydro
		GuiControl, +cgreen, MainHPMapText
		GuiControl,, MainHPMapText,%CDLmap%
		}
	if CDLModus = Control
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Asilo
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Expo
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON4, %CDLmap%
		GuiControl,+cBlack +Redraw, MAPBUTTON5,
		GuiControl, +cgreen, MainCONTROLMapText
		GuiControl,, MainCONTROLMapText,%CDLmap%
		}
		
	;Call funtion with current user and selected map
	GuiControlGet, CurrentUserImputString,, DefaultPlayer
	GuiControlGet, CurrentModeImputString,, ModeStats
	GuiControlGet, CurrentMapImputString,, MapStats
		CurrentUserImputStringLen := InStr(CurrentUserImputString, " - ")
	CurrentUserID := SubStr(CurrentUserImputString, 1, CurrentUserImputStringLen - 1)
	CalcOverviewStats(CurrentUserID,CurrentModeImputString,CurrentMapImputString)
 
	;Show Mapbutton
	GuiControl,show, CDLMapBTN

	return
}

CDLMAP5:
{
	Gui, Submit, NoHide,
	GuiControlGet, CDLmap,, % A_GuiControl
	CDLmap := Trim(CDLmap, OmitChars:= "-")
	;Gui, font,s15, Bahnschrift Condensed
	CDLMAPs := CDLmap
	
	If (AspectRatio = "1.0") {
	GuiControl,show, SubmitStatsNo
	}
	Else {
	GuiControl,show, SubmitStats
	}
	
	
	;set map on top right textbox
	GuiControl,, MapStats, %CDLmap%
	
	if CDLModus = Search
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Embassy
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Mercado
		GuiControl,+cBlack +Redraw, MAPBUTTON4, Fortress
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON5, %CDLmap%
		GuiControl, +cgreen, MainSNDMapText
		GuiControl,, MainSNDMapText,%CDLmap%
		}
	if CDLModus = Hardpoint
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Embassy
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Mercado
		GuiControl,+cBlack +Redraw, MAPBUTTON4, Fortress
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON5, %CDLmap%
		GuiControl, +cgreen, MainHPMapText
		GuiControl,, MainHPMapText,%CDLmap%
		}
	if CDLModus = Control
		{
		GuiControl,+cBlack +Redraw, MAPBUTTON1, Hotel
		GuiControl,+cBlack +Redraw, MAPBUTTON2, Asilo
		GuiControl,+cBlack +Redraw, MAPBUTTON3, Expo
		GuiControl,+cBlack +Redraw, MAPBUTTON4, 
		GuiControl,+c0x5438FA +Redraw, MAPBUTTON5, %CDLmap%
		GuiControl, +cgreen, MainCONTROLMapText
		GuiControl,, MainCONTROLMapText,%CDLmap%
		
		}
		
	;Call funtion with current user and selected map
	GuiControlGet, CurrentUserImputString,, DefaultPlayer
	GuiControlGet, CurrentModeImputString,, ModeStats
	GuiControlGet, CurrentMapImputString,, MapStats
		CurrentUserImputStringLen := InStr(CurrentUserImputString, " - ")
	CurrentUserID := SubStr(CurrentUserImputString, 1, CurrentUserImputStringLen - 1)
	CalcOverviewStats(CurrentUserID,CurrentModeImputString,CurrentMapImputString)

	;Show Mapbutton
	GuiControl,show, CDLMapBTN

	return
}


;Show the Callout Button on Map Selection
CDLMapBTN()
{
	
	currentMap := CDLCalloutsFolder CDLMAPs ".jpg"
	run, %currentMap%
	
}

;++++++++++++++++++++++++++OCR to File++++++++++++++++++++++++++

SnDOCR(CDLMap)
{
		Gui, Submit, Hide,
		BlockInput, Off
		sleep, 300
		FolderFileName:= ""
		OCRFolderFileName := ""
		ResultFolderFile := ""
		varTeamScore := ""
		varTeamIDScore := ""
		
		;Row and Column coordinate for each playerstat into variable and call funtion to recalculate for different resolutions
		SND_R1C1 := "345 410 661 440"
		SND_R1C2 := "745 410 900 440"
		SND_R1C3 := "920 410 1055 440"
		SND_R1C4 := "1060 410 1160 440"
		SND_R1C5 := "1190 410 1300 440"
		SND_R1C6 := "1325 410 1415 440"

		SND_R2C1 := "345 480 661 515"
		SND_R2C2 := "745 480 900 515"
		SND_R2C3 := "920 480 1055 515"
		SND_R2C4 := "1060 480 1160 515"
		SND_R2C5 := "1190 480 1300 515"
		SND_R2C6 := "1325 480 1415 515"

		SND_R3C1 := "345 560 661 590"
		SND_R3C2 := "745 560 900 590"
		SND_R3C3 := "920 560 1055 590"
		SND_R3C4 := "1060 560 1160 590"
		SND_R3C5 := "1190 560 1300 590"
		SND_R3C6 := "1325 560 1415 590"

		SND_R4C1 := "345 625 661 666"
		SND_R4C2 := "745 625 900 666"
		SND_R4C3 := "920 625 1055 666"
		SND_R4C4 := "1060 625 1160 666"
		SND_R4C5 := "1190 625 1300 666"
		SND_R4C6 := "1325 625 1415 666"
		
		TEAM_SCORE := "1200 190 1350 300"
		ENEMY_SCORE := "1200 720 1350 835"
		
		
		;Set Screencap and Textfile title
		CDLMode := A_Now  "_Search_" CDLmap
		CDLMode := Trim(CDLMode, OmitChars:= " ")
		
		;determin if test mode is enabled and set variable		
		GuiControlGet, checked,, TestMode
		If checked = 1 
			{
			FolderFileName := ScoreTestFolder CDLMode
			OCRFolderFileName := OCRTestFolder CDLMode
			ResultFolderFile := ScoreLobbyTestResult
			}
		Else
			{
			FolderFileName := ScoreFolder CDLMode
			OCRFolderFileName := OCRFolder CDLMode
			ResultFolderFile := ScoreLobbyResult
			}
		
		;Take screenshot of primary screen
		SaveScreenSlected := "0, 0," screenWidth ", " screenHeight ""
		CaptureScreen(SaveScreenSlected, 0, FolderFileName ".png")
		CDLFolderFileName := FolderFileName ".png"
		
		
		
		;Gui for OCR Capping with fullscreen Screenshotdisplay
		;Gui, 3:Add, Picture, x0 y0 w%screenWidth% h-1 vPic1, %CDLFolderFileName%
		;Gui, 3:Show, x0 y0 maximize
		
		SplashImage %CDLFolderFileName%, B
		
		;Capture the Final Team Scores
			;own score
			TEAM_SCORE_RES := AspectCalc(TEAM_SCORE)
			;snap := Gdip_BitmapFromScreen("345|410|661|440")
						
			;Gdip_SetBitmapToClipboard(snap)
			;RunWait, %ProgFolder%%OCRProg% -f %snap%  --clipboard
			;Gdip_DisposeImage(snap)
			
			RunWait, %ProgFolder%%OCRProg% --screen-rect `"%TEAM_SCORE_RES%`" --clipboard

			StringReplace, Clipboard, Clipboard,  `r`n,, All
			var1001 := RegExReplace(clipboard, " ", "")

			;remove spaces and Call the replace function
			StringReplace , var1001, var1001, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var1001, ".","-") || StrLen(var1001) > 3 || StrLen(var1001) < 1 || var1001 = "<Error>") {
				var81001 := "N/A"
				}
				Else
				{
				var81001 := ReplaceCharWithNum(var1001)
				}
			
			;Enemy Score
			ENEMY_SCORE_RES := AspectCalc(ENEMY_SCORE)
			sleep, 100
			RunWait, %ProgFolder%%OCRProg% --screen-rect `"%ENEMY_SCORE_RES%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All
			var1002 := RegExReplace(clipboard, " ", "")

			;remove spaces and Call the replace function
			StringReplace , var1002, var1002, %A_Space%,,All
				
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var1002, ".","-") || StrLen(var1002) > 3 || StrLen(var1002) < 1 || var1002 = "<Error>") {
				var81002 := "N/A"
				}
				Else
				{
				var81002 := ReplaceCharWithNum(var1002)
				}
					
			varTeamScore = %var81001%,%var81002%
			StringReplace , varTeamScore, varTeamScore, %A_Space%,,All
			varTeamIDScore := CDLMode "," varTeamScore
			varTeamIDScore := CDLMode "," varTeamScore
			;Write Score to File
			Fileappend, `n%varTeamIDScore%, %ResultFolderFile%LobbyScore.txt
		
		;create file
		;Fileappend,PlayerID,Score,Kills,Deaths,Plants,Defuses, %FolderFileName%.txt
		
		;Capture 1st SND Scoreboard line and write each value to file and return into variable
		
		;Start Capture and return OCR value
		SND_RES_R1C1 := AspectCalc(SND_R1C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R1C1%`"  --clipboard

		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var1 := RegExReplace(clipboard, " ", "")
		StartingPos := InStr(var1, "#")
		var1 := SubStr(var1, StartingPos + 1)
			;remove spaces and Call the replace function
			StringReplace , var1, var1, %A_Space%,,All
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var1, ".","-") || StrLen(var1) > 7 || StrLen(var1) < 7 || var1 = "<Error>") {
				var81 := "N/A"
				}
				Else
				{
				var81 := ReplaceCharWithNum(var1)
				}

		;Start Capture and return OCR value
		SND_RES_R1C2 := AspectCalc(SND_R1C2)	
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R1C2%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var2 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var2, var2, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var2, ".","-") || StrLen(var2) > 5 || StrLen(var2) < 2 || var2 = "<Error>") {
				var82 := "N/A"
				}
				Else
				{
				var82 := ReplaceCharWithNum(var2)
				}
		
		;Start Capture and return OCR value
		SND_RES_R1C3 := AspectCalc(SND_R1C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R1C3%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var3 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var3, var3, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var3, ".","-") || StrLen(var3) > 2 || StrLen(var3) < 1 || var3 = "<Error>") {
				var83 := "N/A"
				}
				Else
				{
				var83 := ReplaceCharWithNum(var3)
				}
				
		;Start Capture and return OCR value
		SND_RES_R1C4 := AspectCalc(SND_R1C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R1C4%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var4 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var4, var4, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var4, ".","-") || StrLen(var4) > 2 || StrLen(var4) < 1 || var4 = "<Error>") {
				var84 := "N/A"
				}
				Else
				{
				var84 := ReplaceCharWithNum(var4)
				}
		
		;Start Capture and return OCR value
		SND_RES_R1C5 := AspectCalc(SND_R1C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R1C5%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var5 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var5, var5, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var5, ".","-") || StrLen(var5) > 1 || var5 = "<Error>") {
				var85 := "N/A"
				}
				Else
				{
				var85 := ReplaceCharWithNum(var5)
				}
		
		;Start Capture and return OCR value
		SND_RES_R1C6 := AspectCalc(SND_R1C6)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R1C6%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var401 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var401, var401, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var401, ".","-") || StrLen(var401) > 1 || var401 = "<Error>") {
				var8401 := "N/A"
				}
				Else
				{
				var8401 := ReplaceCharWithNum(var401)
				}
		
		var6 = %var81%,%var82%,%var83%,%var84%,%var85%,%var8401%
		StringReplace , var6, var6, %A_Space%,,All
		Fileappend, %var6% , %FolderFileName%.txt
		
		;Capture 2nd SND Scoreboard line and write each value to file
		;Start Capture and return OCR value
		SND_RES_R2C1 := AspectCalc(SND_R2C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R2C1%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All
		var66 := RegExReplace(clipboard, " ", "")

		StartingPos := InStr(var66, "#")
		var66 := SubStr(var66, StartingPos + 1)
			;remove spaces and Call the replace function
			StringReplace , var66, var66, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var66, ".","-") || StrLen(var66) > 7 || StrLen(var66) < 7 || var66 = "<Error>") {
				var866 := "N/A"
				}
				Else
				{
				var866 := ReplaceCharWithNum(var66)
				}
		
		;Start Capture and return OCR value
		SND_RES_R2C2 := AspectCalc(SND_R2C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R2C2%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var7 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var7, var7, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var7, ".","-") || StrLen(var7) > 5 || StrLen(var7) < 2 || var7 = "<Error>") {
				var87 := "N/A"
				}
				Else
				{
				var87 := ReplaceCharWithNum(var7)
				}

		;Start Capture and return OCR value
		SND_RES_R2C3 := AspectCalc(SND_R2C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R2C3%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var8 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var8, var8, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var8, ".","-") || StrLen(var8) > 2 || StrLen(var8) < 1 || var8 = "<Error>") {
				var88 := "N/A"
				}	
				Else
				{
				var88 := ReplaceCharWithNum(var8)
				}

		;Start Capture and return OCR value
		SND_RES_R2C4 := AspectCalc(SND_R2C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R2C4%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var9 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var9, var9, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var9, ".","-") || StrLen(var9) > 2 || StrLen(var9) < 1 || var9 = "<Error>") {
				var89 := "N/A"
				}
				Else
				{
				var89 := ReplaceCharWithNum(var9)
				}
		
		;Start Capture and return OCR value
		SND_RES_R2C5 := AspectCalc(SND_R2C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R2C5%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var10 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var10, var10, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var10, ".","-") || StrLen(var10) > 1 || var10 = "<Error>") {
				var810 := "N/A"
				}
				Else
				{
				var810 := ReplaceCharWithNum(var10)
				}

		;Start Capture and return OCR value
		SND_RES_R2C6 := AspectCalc(SND_R2C6)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R2C6%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		var402 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var402, var402, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var402, ".","-") || StrLen(var402) > 1 || var402 = "<Error>") {
				var8402 := "N/A"
				}
				Else
				{
				var8402 := ReplaceCharWithNum(var402)
				}

		var11 = `n%var866%,%var87%,%var88%,%var89%,%var810%,%var8402%
		StringReplace , var11, var11, %A_Space%,,All
		Fileappend, %var11% , %FolderFileName%.txt

		;Capture 3rd SND Scoreboard line and write each value to file
		;Start Capture and return OCR value
		SND_RES_R3C1 := AspectCalc(SND_R3C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R3C1%`" --clipboard
		StringReplace, Clipboard, Clipboard,  `r`n,, All
			var111 := RegExReplace(clipboard, " ", "")
			StartingPos := InStr(var111, "#")
			var111 := SubStr(var111, StartingPos + 1)
			;remove spaces and Call the replace function
			StringReplace , var111, var111, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var111, ".","-") || StrLen(var111) > 7 || StrLen(var111) < 7 || var111 = "<Error>") {
				var8111 := "N/A"
				}
				Else
				{
				var8111 := ReplaceCharWithNum(var111)
				}
		
		;Start Capture and return OCR value
		SND_RES_R3C2 := AspectCalc(SND_R3C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R3C2%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var12 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var12, var12, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var12, ".","-") || StrLen(var12) > 5 || StrLen(var12) < 2 || var12 = "<Error>") {
				var812 := "N/A"
				}	
				Else
				{
				var812 := ReplaceCharWithNum(var12)
				}
		
		;Start Capture and return OCR value
		SND_RES_R3C3 := AspectCalc(SND_R3C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R3C3%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var13 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var13, var13, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var13, ".","-") || StrLen(var13) > 2 || StrLen(var13) < 1 || var13 = "<Error>") {
				var813 := "N/A"
				}
				Else
				{
				var813 := ReplaceCharWithNum(var13)
				}
				
		;Start Capture and return OCR value
		SND_RES_R3C4 := AspectCalc(SND_R3C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R3C4%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var14 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var14, var14, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var14, ".","-") || StrLen(var14) > 2 || StrLen(var14) < 1 || var14 = "<Error>") {
				var814 := "N/A"
				}
				Else
				{
				var814 := ReplaceCharWithNum(var14)
				}
		
		;Start Capture and return OCR value
		SND_RES_R3C5 := AspectCalc(SND_R3C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R3C5%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var15 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var15, var15, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var15, ".","-") || StrLen(var15) > 1 || var15 = "<Error>") {
				var815 := "N/A"
				}
				Else
				{
				var815 := ReplaceCharWithNum(var15)
				}

		;Start Capture and return OCR value
		SND_RES_R3C6 := AspectCalc(SND_R3C6)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R3C6%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var403 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var403, var403, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var403, ".","-") || StrLen(var403) > 1 || var403 = "<Error>") {
				var8403 := "N/A"
				}
				Else
				{
				var8403 := ReplaceCharWithNum(var403)
				}
		
		var16 = `n%var8111%,%var812%,%var813%,%var814%,%var815%,%var8403%
		StringReplace , var16, var16, %A_Space%,,All
		Fileappend, %var16% , %FolderFileName%.txt
		
		;Capture 4th SND Scoreboard line and write each value to file
		;Start Capture and return OCR value
		SND_RES_R4C1 := AspectCalc(SND_R4C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R4C1%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All
			var116 := RegExReplace(clipboard, " ", "")
			StartingPos := InStr(var116, "#")
			var116 := SubStr(var116, StartingPos + 1)
			;remove spaces and Call the replace function
			StringReplace , var116, var116, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var116, ".","-") || StrLen(var116) > 7 || StrLen(var116) < 7 || var116 = "<Error>") {
				var8116 := "N/A"
				}
				Else
				{
				var8116 := ReplaceCharWithNum(var116)
				}
		
		;Start Capture and return OCR value
		SND_RES_R4C2 := AspectCalc(SND_R4C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R4C2%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var17 := RegExReplace(clipboard, " ", "")
			StringReplace , var17, var17, %A_Space%,,All
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var17, ".","-") || StrLen(var17) > 5 || StrLen(var17) < 2 || var17 = "<Error>") {
				var817 := "N/A"
				}
			Else
				{
				var817 := ReplaceCharWithNum(var17)
				}
		
		;Start Capture and return OCR value
		SND_RES_R4C3 := AspectCalc(SND_R4C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R4C3%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var18 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var18, var18, %A_Space%,,All

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var18, ".","-") || StrLen(var18) > 2 || StrLen(var18) < 1 || var18 = "<Error>")  {
				var818 := "N/A"
				}
				Else
				{
				var818 := ReplaceCharWithNum(var18)
				}
			
		;Start Capture and return OCR value
		SND_RES_R4C4 := AspectCalc(SND_R4C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R4C4%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var19 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var19, var19, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var19, ".","-") || StrLen(var19) > 2 || StrLen(var19) < 1 || var19 = "<Error>") {
				var819 := "N/A"
				}
				Else
				{
				var819 := ReplaceCharWithNum(var19)
				}
		
		;Start Capture and return OCR value
		SND_RES_R4C5 := AspectCalc(SND_R4C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R4C5%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var20 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var20, var20, %A_Space%,,All
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var20, ".","-") || StrLen(var20) > 1 || var20 = "<Error>") {
				var820 := "N/A"
				}
				Else
				{
				var820 := ReplaceCharWithNum(var20)
				}
			
		;Start Capture and return OCR value
		SND_RES_R4C6 := AspectCalc(SND_R4C6)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%SND_RES_R4C6%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var404 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var404, var404, %A_Space%,,All
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var404, ".","-") || StrLen(var404) > 1 || var404 = "<Error>") {
				var8404 := "N/A"
				}
				Else
				{
				var8404 := ReplaceCharWithNum(var404)
				}
			
			
		var21 = `n%var8116%,%var817%,%var818%,%var819%,%var820%,%var8404%
		StringReplace , var21, var21, %A_Space%,,All
		Fileappend, %var21% , %FolderFileName%.txt
		
		
		;Close Gui
		;Gui, 3:destroy
		
		SplashImage, Off
		
		SoundPlay, %SoundFolder%success.mp3
		Sleep 250
		BlockInput, Off
		Gui, Show
		return
}


HPOCR(CDLMap)
{		
		Gui, Submit, Hide,
		BlockInput, On
		sleep, 300
		FolderFileName:= ""
		OCRFolderFileName := ""
		ResultFolderFile := ""
		varTeamScore := ""
		varTeamIDScore := ""
		
		HP_R1C1 := "345 410 661 440"
		HP_R1C2 := "745 410 900 440"
		HP_R1C3 := "920 410 1055 440"
		HP_R1C4 := "1060 410 1160 440"
		HP_R1C5 := "1190 410 1300 440"
		HP_R1C6 := "1325 410 1415 440"

		HP_R2C1 := "345 480 661 515"
		HP_R2C2 := "745 480 900 515"
		HP_R2C3 := "920 480 1055 515"
		HP_R2C4 := "1060 480 1160 515"
		HP_R2C5 := "1190 480 1300 515"
		HP_R2C6 := "1325 480 1415 515"

		HP_R3C1 := "345 560 661 590"
		HP_R3C2 := "745 560 900 590"
		HP_R3C3 := "920 560 1055 590"
		HP_R3C4 := "1060 560 1160 590"
		HP_R3C5 := "1190 560 1300 590"
		HP_R3C6 := "1325 560 1415 590"

		HP_R4C1 := "345 625 661 666"
		HP_R4C2 := "745 625 900 666"
		HP_R4C3 := "920 625 1055 666"
		HP_R4C4 := "1060 625 1160 666"
		HP_R4C5 := "1190 625 1300 666"
		HP_R4C6 := "1325 625 1415 666"
		
		TEAM_SCORE := "1200 190 1350 300"
		ENEMY_SCORE := "1200 720 1350 835"
		
		;Set Screencap and Textfile title
		CDLMode := A_Now "_Hardpoint_" CDLmap
		CDLMode := Trim(CDLMode, OmitChars:= " ")
		
		;determin if test mode is enabled and set variable		
		GuiControlGet, checked,, TestMode
		If checked = 1 
			{
			FolderFileName := ScoreTestFolder CDLMode
			OCRFolderFileName := OCRTestFolder CDLMode
			ResultFolderFile := ScoreLobbyTestResult
			}
		Else
			{
			FolderFileName := ScoreFolder CDLMode
			OCRFolderFileName := OCRFolder CDLMode
			ResultFolderFile := ScoreLobbyResult
			}
		
		SaveScreenSlected := "0, 0," screenWidth ", " screenHeight ""
		CaptureScreen(SaveScreenSlected, 0, FolderFileName ".png")
		CDLFolderFileName := FolderFileName ".png"
		
		;Gui for OCR Capping with fullscreen Screenshotdisplay
		;Gui, 3:Add, Picture, x0 y0 w%screenWidth% h-1 vPic1, %CDLFolderFileName%
		;Gui, 3:Show, x0 y0 maximize
		
		SplashImage %CDLFolderFileName%, B
		
		;Fileappend,PlayerID,Score,Kills,Hilltime,Deaths,Defends, %FolderFileName%.txt
		

		;Capture the Final Team Scores
			;own score
			TEAM_SCORE_RES := AspectCalc(TEAM_SCORE)
			RunWait, %ProgFolder%%OCRProg% --screen-rect `"%TEAM_SCORE_RES%`"  --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All
			var1001 := RegExReplace(clipboard, " ", "")
			
			;remove spaces and Call the replace function
			StringReplace , var1001, var1001, %A_Space%,,All

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var1001, ".","-") || StrLen(var1001) > 3 || StrLen(var1001) < 1 || var1001 = "<Error>") {
				var81001 := "N/A"
				}
				Else
				{
				var81001 := ReplaceCharWithNum(var1001)
				}
			
			;Enemy Score
			ENEMY_SCORE_RES := AspectCalc(ENEMY_SCORE)
			sleep, 100
			RunWait, %ProgFolder%%OCRProg% --screen-rect `"%ENEMY_SCORE_RES%`"  --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All
			var1002 := RegExReplace(clipboard, " ", "")
	
			;remove spaces and Call the replace function
			StringReplace , var1002, var1002, %A_Space%,,All
				
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var1002, ".","-") || StrLen(var1002) > 3 || StrLen(var1002) < 1 || var1002 = "<Error>") {
				var81002 := "N/A"
				}
				Else
				{
				var81002 := ReplaceCharWithNum(var1002)
				}

			varTeamScore = %var81001%,%var81002%
			StringReplace , varTeamScore, varTeamScore, %A_Space%,,All
			
			varTeamIDScore := CDLMode "," varTeamScore
			;Write Score to File
			Fileappend, `n%varTeamIDScore%, %ResultFolderFile%LobbyScore.txt	

		
;Capture 1st HARDPOINT Scoreboard line and write each value to file
		;Start Capture and return OCR value
		HP_RES_R1C1 := AspectCalc(HP_R1C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R1C1%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var1 := RegExReplace(clipboard, " ", "")
			StartingPos := InStr(var1, "#")
			var1 := SubStr(var1, StartingPos + 1)
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var1, ".","-") || StrLen(var1) > 7 || StrLen(var1) < 7 || var1 = "<Error>") {
				var81 := "N/A"
				}
				Else
				{
				var81 := ReplaceCharWithNum(var1)
				}

		
		;Start Capture and return OCR value
		HP_RES_R1C2 := AspectCalc(HP_R1C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R1C2%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var2 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var2, ".","-") || StrLen(var2) > 5 || StrLen(var2) < 2 || var2 = "<Error>") {
				var82 := "N/A"
				}
				Else
				{
				var82 := ReplaceCharWithNum(var2)
				}
		
		;Start Capture and return OCR value
		HP_RES_R1C3 := AspectCalc(HP_R1C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R1C3%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var3 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var3, ".","-") || StrLen(var3) > 2 || StrLen(var3) < 1 || var3 = "<Error>") {
				var83 := "N/A"
				}
				Else
				{
				var83 := ReplaceCharWithNum(var3)
				}
		
		;Start Capture and return OCR value
		HP_RES_R1C4 := AspectCalc(HP_R1C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R1C4%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var4 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var4, ".","-") || StrLen(var4) > 4 || StrLen(var4) < 4 || var4 = "<Error>") {
				var84 := "N/A"
				}	
				
				;Check if it is a time
				If (RegExMatch(var4, "^\d{1}:\d{2}$"))
				{
				var84 := var4
				}
				Else
				{
				var84 := ReplaceCharWithNum(var4)
				}
		
		;Start Capture and return OCR value
		HP_RES_R1C5 := AspectCalc(HP_R1C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R1C5%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var5 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var5, ".","-") || StrLen(var5) > 2 || StrLen(var5) < 1 || var5 = "<Error>") {
				var85 := "N/A"
				}
				Else
				{
				var85 := ReplaceCharWithNum(var5)
				}
			
		;Start Capture and return OCR value
		HP_RES_R1C6 := AspectCalc(HP_R1C6)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R1C6%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var501 := RegExReplace(clipboard, " ", "")
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var501, ".","-") || StrLen(var501) > 2 || var501 = "<Error>") {
				var8501 := "N/A"
				}
				Else
				{
				var8501 := ReplaceCharWithNum(var501)
				}
		
		var6 = %var81%,%var82%,%var83%,%var84%,%var85%,%var8501%
		StringReplace , var6, var6, %A_Space%,,All
		Fileappend, %var6%, %FolderFileName%.txt
		
		
;Capture 2nd HARDPOINT Scoreboard line and write each value to file
		;Start Capture and return OCR value
		HP_RES_R2C1 := AspectCalc(HP_R2C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R2C1%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var8 := RegExReplace(clipboard, " ", "")
			StartingPos := InStr(var8, "#")
			var8 := SubStr(var8, StartingPos + 1)
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var8, ".","-") || StrLen(var8) > 7 || StrLen(var8) < 7 || var8 = "<Error>") {
				var88 := "N/A"
				}
				Else
				{
				var88 := ReplaceCharWithNum(var8)
				}
		
		;Start Capture and return OCR value
		HP_RES_R2C2 := AspectCalc(HP_R2C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R2C2%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var9 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var9, ".","-") || StrLen(var9) > 5 || StrLen(var9) < 2 || var9 = "<Error>") {
				var89 := "N/A"
				}
				Else
				{
				var89 := ReplaceCharWithNum(var9)
				}
		
		;Start Capture and return OCR value
		HP_RES_R2C3 := AspectCalc(HP_R2C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R2C3%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var10 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var10, ".","-") || StrLen(var10) > 2 || StrLen(var10) < 1 || var10 = "<Error>") {
				var810 := "N/A"
				}
				Else
				{
				var810 := ReplaceCharWithNum(var10)
				}
		
		;Start Capture and return OCR value
		HP_RES_R2C4 := AspectCalc(HP_R2C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R2C4%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var11 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var11, ".","-") || StrLen(var11) > 4 || StrLen(var11) < 4 || var11 = "<Error>") {
				var811 := "N/A"
				}	
				;Check if it is a time
				If (RegExMatch(var11, "^\d{1}:\d{2}$"))
				{
				var811 := var11
				}
				Else
				{
				var811 := ReplaceCharWithNum(var11)
				}
		
		;Start Capture and return OCR value
		HP_RES_R2C5 := AspectCalc(HP_R2C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R2C5%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var12 := RegExReplace(clipboard, " ", "")
						
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var12, ".","-") || StrLen(var12) > 2 || StrLen(var12) < 1 || var12 = "<Error>") {
				var812 := "N/A"
				}
				Else
				{
				var812 := ReplaceCharWithNum(var12)
				}
			
		;Start Capture and return OCR value
		HP_RES_R2C6 := AspectCalc(HP_R2C6)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R2C6%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var502 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var502, ".","-") || StrLen(var502) > 2 || var502 = "<Error>") {
				var8502 := "N/A"
				}
				Else
				{
				var8502 := ReplaceCharWithNum(var502)
				}
		
		var13 = `n%var88%,%var89%,%var810%,%var811%,%var812%,%var8502%
		StringReplace , var13, var13, %A_Space%,,All
		Fileappend, %var13%, %FolderFileName%.txt

		
;Capture 3rd HARDPOINT Scoreboard line and write each value to file
		;Start Capture and return OCR value
		HP_RES_R3C1 := AspectCalc(HP_R3C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R3C1%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var15 := RegExReplace(clipboard, " ", "")
			
			StartingPos := InStr(var15, "#")
			var15 := SubStr(var15, StartingPos + 1)

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var15, ".","-") || StrLen(var15) > 7 || StrLen(var15) < 7 || var15 = "<Error>") {
				var815 := "N/A"
				}
				Else
				{
				var815 := ReplaceCharWithNum(var15)
				}	
		
		;Start Capture and return OCR value
		HP_RES_R3C2 := AspectCalc(HP_R3C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R3C2%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var16 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var16, ".","-") || StrLen(var16) > 5 || StrLen(var16) < 2 || var16 = "<Error>") {
				var816 := "N/A"
				}
				Else
				{
				var816 := ReplaceCharWithNum(var16)
				}
		
		;Start Capture and return OCR value
		HP_RES_R3C3 := AspectCalc(HP_R3C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R3C3%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var17 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var17, ".","-") || StrLen(var17) > 2 || StrLen(var17) < 1 || var17 = "<Error>") {
				var817 := "N/A"
				}
				Else
				{
				var817 := ReplaceCharWithNum(var17)
				}	
		
		;Start Capture and return OCR value
		HP_RES_R3C4 := AspectCalc(HP_R3C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R3C4%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var18 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var18, ".","-") || StrLen(var18) > 4 || StrLen(var18) < 4 || var18 = "<Error>") {
				var818 := "N/A"
				}
				;Check if it is a time
				If (RegExMatch(var18, "^\d{1}:\d{2}$"))
				{
				var818 := var18
				}				
				Else
				{
				var818 := ReplaceCharWithNum(var18)
				}
		
		;Start Capture and return OCR value
		HP_RES_R3C5 := AspectCalc(HP_R3C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R3C5%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var19 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var19, ".","-") || StrLen(var19) > 2 || StrLen(var19) < 1 || var19 = "<Error>") {
				var819 := "N/A"
				}
				Else
				{
				var819 := ReplaceCharWithNum(var19)
				}
			
		;Start Capture and return OCR value
		HP_RES_R3C6 := AspectCalc(HP_R3C6)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R3C6%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var503 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var503, ".","-") || StrLen(var503) > 2 || var503 = "<Error>") {
				var8503 := "N/A"
				}
				Else
				{
				var8503 := ReplaceCharWithNum(var503)
				}
		
		var20 = `n%var815%,%var816%,%var817%,%var818%,%var819%,%var8503%
		StringReplace , var20, var20, %A_Space%,,All
		Fileappend, %var20%, %FolderFileName%.txt
		
		
;Capture 4th HARDPOINT Scoreboard line and write each value to file
		;Start Capture and return OCR value
		HP_RES_R4C1 := AspectCalc(HP_R4C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R4C1%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var22 := RegExReplace(clipboard, " ", "")
			StartingPos := InStr(var22, "#")
			var22 := SubStr(var22, StartingPos + 1)

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var22, ".","-") || StrLen(var22) > 7 || StrLen(var22) < 7 || var22 = "<Error>") {
				var822 := "N/A"
				}
				Else
				{
				var822 := ReplaceCharWithNum(var22)
				}
		
		;Start Capture and return OCR value
		HP_RES_R4C2 := AspectCalc(HP_R4C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R4C2%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var23 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var23, ".","-") || StrLen(var23) > 5 || StrLen(var23) < 2 || var23 = "<Error>") {
				var823 := "N/A"
				}
				Else
				{
				var823 := ReplaceCharWithNum(var23)
				}
			
		;Start Capture and return OCR value
		HP_RES_R4C3 := AspectCalc(HP_R4C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R4C3%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var24 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var24, ".","-") || StrLen(var24) > 2 || StrLen(var24) < 1 || var24 = "<Error>") {
				var824 := "N/A"
				}
				Else
				{
				var824 := ReplaceCharWithNum(var24)
				}	
			
		;Start Capture and return OCR value
		HP_RES_R4C4 := AspectCalc(HP_R4C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R4C4%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var25 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var25, ".","-") || StrLen(var25) > 4 || StrLen(var25) < 4 || var25 = "<Error>") {
				var825 := "N/A"
				}
				;Check if it is a time
				If (RegExMatch(var25, "^\d{1}:\d{2}$"))
				{
				var825 := var25
				}
				Else
				{
				var825 := ReplaceCharWithNum(var25)
				}

		;Start Capture and return OCR value
		HP_RES_R4C5 := AspectCalc(HP_R4C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R4C5%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var26 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var26, ".","-") || StrLen(var26) > 2 || StrLen(var26) < 1 || var26 = "<Error>") {
				var826 := "N/A"
				}
				Else
				{
				var826 := ReplaceCharWithNum(var26)
				}
			
		;Start Capture and return OCR value
		HP_RES_R4C6 := AspectCalc(HP_R4C6)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%HP_RES_R4C6%`" --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var504 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var504, ".","-") || StrLen(var504) > 2 || var504 = "<Error>") {
				var8504 := "N/A"
				}
				Else
				{
				var8504 := ReplaceCharWithNum(var504)
				}
		
		var28 = `n%var822%,%var823%,%var824%,%var825%,%var826%,%var8504%
		StringReplace , var28, var28, %A_Space%,,All
		Fileappend, %var28%, %FolderFileName%.txt
		
		;Close Gui
		;Gui, 3:destroy
		SplashImage, Off
		
		SoundPlay, %SoundFolder%success.mp3
		BlockInput, Off
		Gui, Show
		return

}

ContOCR(CDLMap)
{		
		Gui, Submit, Hide,
		BlockInput, On
		sleep, 300
		FolderFileName:= ""
		OCRFolderFileName := ""
		ResultFolderFile := ""
		varTeamScore := ""
		varTeamIDScore := ""
		
		CONT_R1C1 := "345 410 661 440"
		CONT_R1C2 := "745 410 900 440"
		CONT_R1C3 := "920 410 1055 440"
		CONT_R1C4 := "1090 410 1245 440"
		CONT_R1C5 := "1250 410 1475 440"

		CONT_R2C1 := "345 480 661 515"
		CONT_R2C2 := "745 480 900 515"
		CONT_R2C3 := "920 480 1055 515"
		CONT_R2C4 := "1090 480 1245 515"
		CONT_R2C5 := "1250 480 1475 515"

		CONT_R3C1 := "345 560 661 590"
		CONT_R3C2 := "745 560 900 590"
		CONT_R3C3 := "920 560 1055 590"
		CONT_R3C4 := "1090 560 1245 590"
		CONT_R3C5 := "1250 560 1475 590"

		CONT_R4C1 := "345 625 661 666"
		CONT_R4C2 := "745 625 900 666"
		CONT_R4C3 := "920 625 1055 666"
		CONT_R4C4 := "1090 625 1245 666"
		CONT_R4C5 := "1250 625 1475 666"
		
		TEAM_SCORE := "1200 190 1350 300"
		ENEMY_SCORE := "1200 720 1350 835"
		
		;Set Screencap and Textfile title
		CDLMode := A_Now "_Control_" CDLmap
		CDLMode := Trim(CDLMode, OmitChars:= " ")
		
		;determin if test mode is enabled and set variable		
		GuiControlGet, checked,, TestMode
		If checked = 1 
			{
			FolderFileName := ScoreTestFolder CDLMode
			OCRFolderFileName := OCRTestFolder CDLMode
			ResultFolderFile := ScoreLobbyTestResult
			}
		Else
			{
			FolderFileName := ScoreFolder CDLMode
			OCRFolderFileName := OCRFolder CDLMode
			ResultFolderFile := ScoreLobbyResult
			}
		
		;Take screenshot of primary screen
		SaveScreenSlected := "0, 0," screenWidth ", " screenHeight ""
		CaptureScreen(SaveScreenSlected, 0, FolderFileName ".png")
		CDLFolderFileName := FolderFileName ".png"
		
		;Gui for OCR Capping with fullscreen Screenshotdisplay
		;Gui, 3:Add, Picture, x0 y0 w%screenWidth% h-1 vPic1, %CDLFolderFileName%
		;Gui, 3:Show, x0 y0 maximize
		
		SplashImage %CDLFolderFileName%, B

		
		;Fileappend,PlayerID,Score,Kills,Captures,Damage, %FolderFileName%.txt
		
	
			;Capture the Final Team Scores
			;own score
			TEAM_SCORE_RES := AspectCalc(TEAM_SCORE)
			RunWait, %ProgFolder%%OCRProg% --screen-rect `"%TEAM_SCORE_RES%`"  --clipboard
			StringReplace, Clipboard, Clipboard,  `r`n,, All

			;Testinputdata := Clipboard
			
			var1001 := RegExReplace(clipboard, " ", "")

			;remove spaces and Call the replace function
			StringReplace , var1001, var1001, %A_Space%,,All

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var1001, ".","-") || StrLen(var1001) > 3 || StrLen(var1001) < 1 || var1001 = "<Error>") {
				var81001 := "N/A"
				}
				Else
				{
				var81001 := ReplaceCharWithNum(var1001)
				}
			
			;Enemy Score
			ENEMY_SCORE_RES := AspectCalc(ENEMY_SCORE)
			sleep, 100
			RunWait, %ProgFolder%%OCRProg% --screen-rect `"%ENEMY_SCORE_RES%`"  --clipboard
			
			StringReplace, Clipboard, Clipboard,  `r`n,, All
			
			var1002 := RegExReplace(clipboard, " ", "")

			;remove spaces and Call the replace function
			StringReplace , var1002, var1002, %A_Space%,,All
				
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var1002, ".","-") || StrLen(var1002) > 3 || StrLen(var1002) < 1 || var1002 = "<Error>") {
				var81002 := "N/A"
				}
				Else
				{
				var81002 := ReplaceCharWithNum(var1002)
				}
					
			varTeamScore = %var81001%,%var81002%
			StringReplace , varTeamScore, varTeamScore, %A_Space%,,All
			varTeamIDScore := CDLMode "," varTeamScore
			;Write Score to File
			Fileappend, `n%varTeamIDScore%, %ResultFolderFile%LobbyScore.txt		

		
		;Capture 1st CONTROL Scoreboard line and write each value to file
		;Start Capture and return OCR value
		CONT_RES_R1C1 := AspectCalc(CONT_R1C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R1C1%`" --clipboard
		
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		
		var1 := RegExReplace(clipboard, " ", "")
		StartingPos := InStr(var1, "#")
		var1 := SubStr(var1, StartingPos + 1)
			;remove spaces and Call the replace function
			;StringReplace , var1, var1, %A_Space%,,All

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var1, ".","-") || StrLen(var1) > 7 || StrLen(var1) < 7 || var1 = "<Error>") {
				var81 := "N/A"
				}
				Else
				{
				var81 := ReplaceCharWithNum(var1)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R1C2 := AspectCalc(CONT_R1C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R1C2%`" --clipboard

		
		StringReplace, Clipboard, Clipboard,  `r`n,, All 

		var2 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			;StringReplace , var2, var2, %A_Space%,,All

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var2, ".","-") || StrLen(var2) > 5 || StrLen(var2) < 2 || var2 = "<Error>") {
				var82 := "N/A"
				}
				Else
				{
				var82 := ReplaceCharWithNum(var2)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R1C3 := AspectCalc(CONT_R1C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R1C3%`" --clipboard
			
		StringReplace, Clipboard, Clipboard,  `r`n,, All 

		var3 := RegExReplace(clipboard, " ", "")
			;remove spaces and Call the replace function
			StringReplace , var3, var3, %A_Space%,,All

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var3, ".","-") || StrLen(var3) > 2 || StrLen(var3) < 1 || var3 = "<Error>") {
				var83 := "N/A"
				}
				Else
				{
				var83 := ReplaceCharWithNum(var3)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R1C4 := AspectCalc(CONT_R1C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R1C4%`" --clipboard
		
		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		
		var4 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var4, ".","-") || StrLen(var4) > 2 || StrLen(var4) < 1 || var4 = "<Error>") {
				var84 := "N/A"
				}
				Else
				{
				var84 := ReplaceCharWithNum(var4)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R1C5 := AspectCalc(CONT_R1C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R1C5%`" --clipboard

		StringReplace, Clipboard, Clipboard,  `r`n,, All 

		var5 := RegExReplace(clipboard, " ", "")
		
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var5, ".","-") || StrLen(var5) > 5 || StrLen(var5) < 2 || var5 = "<Error>") {
				var85 := "N/A"
				}	
				Else
				{
				var85 := ReplaceCharWithNum(var5)
				}
		
		var6 = %var81%,%var82%,%var83%,%var84%,%var85% 
		StringReplace , var6, var6, %A_Space%,,All
		Fileappend, %var6% , %FolderFileName%.txt
		
		;Capture 2nd CONTROL Scoreboard line and write each value to file
		;Start Capture and return OCR value
		CONT_RES_R2C1 := AspectCalc(CONT_R2C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R2C1%`" --clipboard
		
		StringReplace, Clipboard, Clipboard,  `r`n,, All
		
		var66 := RegExReplace(clipboard, " ", "")
		StartingPos := InStr(var66, "#")
		var66 := SubStr(var66, StartingPos + 1)

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var66, ".","-") || StrLen(var66) > 7 || StrLen(var66) < 7 || var66 = "<Error>") {
				var866 := "N/A"
				}
				Else
				{
				var866 := ReplaceCharWithNum(var66)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R2C2 := AspectCalc(CONT_R2C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R2C2%`" --clipboard

		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		
		var7 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var7, ".","-") || StrLen(var7) > 5 || StrLen(var7) < 2 || var7 = "<Error>") {
				var87 := "N/A"
				}
				Else
				{
				var87 := ReplaceCharWithNum(var7)
				}

		;Start Capture and return OCR value
		CONT_RES_R2C3 := AspectCalc(CONT_R2C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R2C3%`" --clipboard

		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		
		var8 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var8, ".","-") || StrLen(var8) > 2 || StrLen(var8) < 1 || var8 = "<Error>") {
				var88 := "N/A"
				}
				Else
				{
				var88 := ReplaceCharWithNum(var8)
				}

		;Start Capture and return OCR value
		CONT_RES_R2C4 := AspectCalc(CONT_R2C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R2C4%`" --clipboard

		StringReplace, Clipboard, Clipboard,  `r`n,, All 

		var9 := RegExReplace(clipboard, " ", "")
		
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var9, ".","-") || StrLen(var9) > 2 || StrLen(var9) < 1 || var9 = "<Error>") {
				var89 := "N/A"
				}
				Else
				{
				var89 := ReplaceCharWithNum(var9)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R2C5 := AspectCalc(CONT_R2C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R2C5%`" --clipboard

		StringReplace, Clipboard, Clipboard,  `r`n,, All 
		
		var10 := RegExReplace(clipboard, " ", "")
		
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var10, ".","-") || StrLen(var10) > 5 || StrLen(var10) < 2 || var10 = "<Error>") {
				var810 := "N/A"
				}	
				Else
				{
				var810 := ReplaceCharWithNum(var10)
				}	

		var11 = `n%var866%,%var87%,%var88%,%var89%,%var810%
		StringReplace , var11, var11, %A_Space%,,All
		Fileappend, %var11% , %FolderFileName%.txt

		;Capture 3rd CONTROL Scoreboard line and write each value to file
		;Start Capture and return OCR value
		CONT_RES_R3C1 := AspectCalc(CONT_R3C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R3C1%`" --clipboard
	
		StringReplace, Clipboard, Clipboard,  `r`n,, All
		
			var111 := RegExReplace(clipboard, " ", "")
			StartingPos := InStr(var111, "#")
			var111 := SubStr(var111, StartingPos + 1)

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var111, ".","-") || StrLen(var111) > 7 || StrLen(var111) < 7 || var111 = "<Error>") {
				var8111 := "N/A"
				}
				Else
				{
				var8111 := ReplaceCharWithNum(var111)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R3C2 := AspectCalc(CONT_R3C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R3C2%`" --clipboard
		
			StringReplace, Clipboard, Clipboard,  `r`n,, All
			var12 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var12, ".","-") || StrLen(var12) > 5 || StrLen(var12) < 2 || var12 = "<Error>") {
				var812 := "N/A"
				}
				Else
				{
				var812 := ReplaceCharWithNum(var12)
				}	
		
		;Start Capture and return OCR value
		CONT_RES_R3C3 := AspectCalc(CONT_R3C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R3C3%`" --clipboard

			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var13 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var13, ".","-") || StrLen(var13) > 2 || StrLen(var13) < 1 || var13 = "<Error>") {
				var813 := "N/A"
				}
				Else
				{
				var813 := ReplaceCharWithNum(var13)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R3C4 := AspectCalc(CONT_R3C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R3C4%`" --clipboard

			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			
			var14 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var14, ".","-") || StrLen(var14) > 2 || StrLen(var14) < 1 || var14 = "<Error>") {
				var814 := "N/A"
				}
				Else
				{
				var814 := ReplaceCharWithNum(var14)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R3C5 := AspectCalc(CONT_R3C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R3C5%`" --clipboard

			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			
			var15 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var15, ".","-") || StrLen(var15) > 5 || StrLen(var15) < 2 || var15 = "<Error>") {
				var815 := "N/A"
				}	
				Else
				{
				var815 := ReplaceCharWithNum(var15)
				}	
		
		var16 = `n%var8111%,%var812%,%var813%,%var814%,%var815%
		StringReplace , var16, var16, %A_Space%,,All
		Fileappend, %var16% , %FolderFileName%.txt
		
		;Capture 4th CONTROL Scoreboard line and write each value to file
		;Start Capture and return OCR value
		CONT_RES_R4C1 := AspectCalc(CONT_R4C1)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R4C1%`" --clipboard
		

			StringReplace, Clipboard, Clipboard,  `r`n,, All
			var166 := RegExReplace(clipboard, " ", "")
			StartingPos := InStr(var166, "#")
			var166 := SubStr(var166, StartingPos + 1)

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created or wrong input received
			if (InStr(var166, ".","-") || StrLen(var166) > 7 || StrLen(var166) < 7 || var166 = "<Error>") {
				var8166 := "N/A"
				}
				Else
				{
				var8166 := ReplaceCharWithNum(var166)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R4C2 := AspectCalc(CONT_R4C2)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R4C2%`" --clipboard

			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var17 := RegExReplace(clipboard, " ", "")
			
			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var17, ".","-") || StrLen(var17) > 5 || StrLen(var17) < 2 || var17 = "<Error>") {
				var817 := "N/A"
				}
				Else
				{
				var817 := ReplaceCharWithNum(var17)
				}		
		
		;Start Capture and return OCR value
		CONT_RES_R4C3 := AspectCalc(CONT_R4C3)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R4C3%`" --clipboard


			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			var18 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var18, ".","-") || StrLen(var18) > 2 || StrLen(var18) < 1 || var18 = "<Error>") {
				var818 := "N/A"
				}
				Else
				{
				var818 := ReplaceCharWithNum(var18)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R4C4 := AspectCalc(CONT_R4C4)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R4C4%`" --clipboard
		
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			
			var19 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var19, ".","-") || StrLen(var19) > 2 || StrLen(var19) < 1 || var19 = "<Error>") {
				var819 := "N/A"
				}
				Else
				{
				var819 := ReplaceCharWithNum(var19)
				}
		
		;Start Capture and return OCR value
		CONT_RES_R4C5 := AspectCalc(CONT_R4C5)
		sleep, 100
		RunWait, %ProgFolder%%OCRProg% --screen-rect `"%CONT_RES_R4C5%`" --clipboard
		
			StringReplace, Clipboard, Clipboard,  `r`n,, All 
			
			var20 := RegExReplace(clipboard, " ", "")

			;Check for possible value issues i.e. row is empty because somebody left before nedscore created
			if (InStr(var20, ".","-") || StrLen(var20) > 5 || StrLen(var20) < 2 || var20 = "<Error>") {
				var820 := "N/A"
				}	
				Else
				{
				var820 := ReplaceCharWithNum(var20)
				}	
		
		var21 = `n%var8166%,%var817%,%var818%,%var819%,%var820%
		StringReplace , var21, var21, %A_Space%,,All
		Fileappend, %var21% , %FolderFileName%.txt
		
		;Close Gui
		;Gui, 3:destroy
		
		SplashImage, Off
		
		SoundPlay, %SoundFolder%success.mp3
		Sleep 250


		BlockInput, Off
		Gui, Show
		return

}

ReplaceCharWithNum(currentvar)
{
		;Testinputdata := %Testinputdata%`,%currentvar%

		currentvar := RegExReplace(currentvar, "l","1")
		currentvar := RegExReplace(currentvar, "I","1")
		currentvar := RegExReplace(currentvar, "Z","2")
		currentvar := RegExReplace(currentvar, "G","6")
		currentvar := RegExReplace(currentvar, "B","8")
		currentvar := RegExReplace(currentvar, "S","5")
		currentvar := RegExReplace(currentvar, "A","4")
		currentvar := RegExReplace(currentvar, "U","0")
		currentvar := RegExReplace(currentvar, "O","0")
		currentvar := RegExReplace(currentvar, "M","14")
		currentvar := RegExReplace(currentvar, "H","11")		
		
		If (!RegExMatch(currentvar, "^\d+(\.\d+)?$"))
		{
			;MsgBox, The variable is not a number -%currentvar%-
			currentvar := "N/A"
			;return
		}
		
		if (!IsNumeric(currentvar))
		{
			;MsgBox, The variable is not a number 2 -"%currentvar%"-
			currentvar := "N/A"
			;return
		}
		;MsgBox, out -%currentvar%- 
		return currentvar
}


IsNumeric(str)
{
    return RegExMatch(str, "^\d+(\.\d+)?$")
}


CaptureScreen(aRect = 0, bCursor = False, sFile = "", nQuality = "")
{
	If !aRect
	{
		SysGet, nL, 76  ; virtual screen left & top
		SysGet, nT, 77
		SysGet, nW, 78	; virtual screen width and height
		SysGet, nH, 79
	}
	Else If aRect = 1
		WinGetPos, nL, nT, nW, nH, A
	Else If aRect = 2
	{
		WinGet, hWnd, ID, A
		VarSetCapacity(rt, 16, 0)
		DllCall("GetClientRect" , "ptr", hWnd, "ptr", &rt)
		DllCall("ClientToScreen", "ptr", hWnd, "ptr", &rt)
		nL := NumGet(rt, 0, "int")
		nT := NumGet(rt, 4, "int")
		nW := NumGet(rt, 8)
		nH := NumGet(rt,12)
	}
	Else If aRect = 3
	{
		VarSetCapacity(mi, 40, 0)
		DllCall("GetCursorPos", "int64P", pt), NumPut(40,mi,0,"uint")
		DllCall("GetMonitorInfo", "ptr", DllCall("MonitorFromPoint", "int64", pt, "Uint", 2, "ptr"), "ptr", &mi)
		nL := NumGet(mi, 4, "int")
		nT := NumGet(mi, 8, "int")
		nW := NumGet(mi,12, "int") - nL
		nH := NumGet(mi,16, "int") - nT
	}
	Else
	{
		StringSplit, rt, aRect, `,, %A_Space%%A_Tab%
		nL := rt1	; convert the Left,top, right, bottom into left, top, width, height
		nT := rt2
		nW := rt3 - rt1
		nH := rt4 - rt2
		znW := rt5
		znH := rt6
	}

	mDC := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
	hBM := CreateDIBSection888(mDC, nW, nH)
	oBM := DllCall("SelectObject", "ptr", mDC, "ptr", hBM, "ptr")
	hDC := DllCall("GetDC", "ptr", 0, "ptr")
	DllCall("BitBlt", "ptr", mDC, "int", 0, "int", 0, "int", nW, "int", nH, "ptr", hDC, "int", nL, "int", nT, "Uint", 0x40CC0020)
	DllCall("ReleaseDC", "ptr", 0, "ptr", hDC)
	If bCursor
		CaptureCursor(mDC, nL, nT)
	DllCall("SelectObject", "ptr", mDC, "ptr", oBM)
	DllCall("DeleteDC", "ptr", mDC)
	If znW && znH
		hBM := Zoomer(hBM, nW, nH, znW, znH)
	If sFile = 0
		SetClipboardData(hBM)
	Else Convert(hBM, sFile, nQuality), DllCall("DeleteObject", "ptr", hBM)
}

CaptureCursor(hDC, nL, nT)
{
	VarSetCapacity(mi, 32, 0), Numput(16+A_PtrSize, mi, 0, "uint")
	DllCall("GetCursorInfo", "ptr", &mi)
	bShow   := NumGet(mi, 4, "uint")
	hCursor := NumGet(mi, 8)
	xCursor := NumGet(mi,8+A_PtrSize, "int")
	yCursor := NumGet(mi,12+A_PtrSize, "int")

	DllCall("GetIconInfo", "ptr", hCursor, "ptr", &mi)
	xHotspot := NumGet(mi, 4, "uint")
	yHotspot := NumGet(mi, 8, "uint")
	hBMMask  := NumGet(mi,8+A_PtrSize)
	hBMColor := NumGet(mi,16+A_PtrSize)

	If bShow
		DllCall("DrawIcon", "ptr", hDC, "int", xCursor - xHotspot - nL, "int", yCursor - yHotspot - nT, "ptr", hCursor)
	If hBMMask
		DllCall("DeleteObject", "ptr", hBMMask)
	If hBMColor
		DllCall("DeleteObject", "ptr", hBMColor)
}

Zoomer(hBM, nW, nH, znW, znH)
{
	mDC1 := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
	mDC2 := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
	zhBM := CreateDIBSection888(mDC2, znW, znH)
	oBM1 := DllCall("SelectObject", "ptr", mDC1, "ptr",  hBM, "ptr")
	oBM2 := DllCall("SelectObject", "ptr", mDC2, "ptr", zhBM, "ptr")
	DllCall("SetStretchBltMode", "ptr", mDC2, "int", 4)
	DllCall("StretchBlt", "ptr", mDC2, "int", 0, "int", 0, "int", znW, "int", znH, "ptr", mDC1, "int", 0, "int", 0, "int", nW, "int", nH, "Uint", 0x00CC0020)
	DllCall("SelectObject", "ptr", mDC1, "ptr", oBM1)
	DllCall("SelectObject", "ptr", mDC2, "ptr", oBM2)
	DllCall("DeleteDC", "ptr", mDC1)
	DllCall("DeleteDC", "ptr", mDC2)
	DllCall("DeleteObject", "ptr", hBM)
	Return zhBM
}

Convert(sFileFr = "", sFileTo = "", nQuality = "")
{
	If (sFileTo = "")
		sFileTo := A_ScriptDir . "\screen.bmp"
	SplitPath, sFileTo, , sDirTo, sExtTo, sNameTo
	
	If Not hGdiPlus := DllCall("LoadLibrary", "str", "gdiplus.dll", "ptr")
		Return	sFileFr+0 ? SaveHBITMAPToFile(sFileFr, sDirTo (sDirTo = "" ? "" : "\") sNameTo ".bmp") : ""
	VarSetCapacity(si, 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", "UintP", pToken, "ptr", &si, "ptr", 0)

	If !sFileFr
	{
		DllCall("OpenClipboard", "ptr", 0)
		If	(DllCall("IsClipboardFormatAvailable", "Uint", 2) && (hBM:=DllCall("GetClipboardData", "Uint", 2, "ptr")))
			DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hBM, "ptr", 0, "ptr*", pImage)
		DllCall("CloseClipboard")
	}
	Else If	sFileFr Is Integer
		DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", sFileFr, "ptr", 0, "ptr*", pImage)
	Else	DllCall("gdiplus\GdipLoadImageFromFile", "wstr", sFileFr, "ptr*", pImage)
	DllCall("gdiplus\GdipGetImageEncodersSize", "UintP", nCount, "UintP", nSize)
	VarSetCapacity(ci,nSize,0)
	DllCall("gdiplus\GdipGetImageEncoders", "Uint", nCount, "Uint", nSize, "ptr", &ci)
	struct_size := 48+7*A_PtrSize, offset := 32 + 3*A_PtrSize, pCodec := &ci - struct_size
	Loop, %	nCount
		If InStr(StrGet(Numget(offset + (pCodec+=struct_size)), "utf-16") , "." . sExtTo)
			break

	If (InStr(".JPG.JPEG.JPE.JFIF", "." . sExtTo) && nQuality<>"" && pImage && pCodec < &ci + nSize)
	{
		DllCall("gdiplus\GdipGetEncoderParameterListSize", "ptr", pImage, "ptr", pCodec, "UintP", nCount)
		VarSetCapacity(pi,nCount,0), struct_size := 24 + A_PtrSize
		DllCall("gdiplus\GdipGetEncoderParameterList", "ptr", pImage, "ptr", pCodec, "Uint", nCount, "ptr", &pi)
		Loop, %	NumGet(pi,0,"uint")
			If (NumGet(pi,struct_size*(A_Index-1)+16+A_PtrSize,"uint")=1 && NumGet(pi,struct_size*(A_Index-1)+20+A_PtrSize,"uint")=6)
			{
				pParam := &pi+struct_size*(A_Index-1)
				NumPut(nQuality,NumGet(NumPut(4,NumPut(1,pParam+0,"uint")+16+A_PtrSize,"uint")),"uint")
				Break
			}
	}

	If pImage
		pCodec < &ci + nSize	? DllCall("gdiplus\GdipSaveImageToFile", "ptr", pImage, "wstr", sFileTo, "ptr", pCodec, "ptr", pParam) : DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "ptr", pImage, "ptr*", hBitmap, "Uint", 0) . SetClipboardData(hBitmap), DllCall("gdiplus\GdipDisposeImage", "ptr", pImage)

	DllCall("gdiplus\GdiplusShutdown" , "Uint", pToken)
	DllCall("FreeLibrary", "ptr", hGdiPlus)
}


CreateDIBSection888(hDC, nW, nH, bpp = 32, ByRef pBits = "")
{
	VarSetCapacity(bi, 40, 0)
	NumPut(40, bi, "uint")
	NumPut(nW, bi, 4, "int")
	NumPut(nH, bi, 8, "int")
	NumPut(bpp, NumPut(1, bi, 12, "UShort"), 0, "Ushort")
	Return DllCall("gdi32\CreateDIBSection", "ptr", hDC, "ptr", &bi, "Uint", 0, "UintP", pBits, "ptr", 0, "Uint", 0, "ptr")
}

SaveHBITMAPToFile(hBitmap, sFile)
{
	VarSetCapacity(oi,104,0)
	DllCall("GetObject", "ptr", hBitmap, "int", 64+5*A_PtrSize, "ptr", &oi)
	fObj := FileOpen(sFile, "w")
	fObj.WriteShort(0x4D42)
	fObj.WriteInt(54+NumGet(oi,36+2*A_PtrSize,"uint"))
	fObj.WriteInt64(54<<32)
	fObj.RawWrite(&oi + 16 + 2*A_PtrSize, 40)
	fObj.RawWrite(NumGet(oi, 16+A_PtrSize), NumGet(oi,36+2*A_PtrSize,"uint"))
	fObj.Close()
}

SetClipboardData(hBitmap)
{
	VarSetCapacity(oi,104,0)
	DllCall("GetObject", "ptr", hBitmap, "int", 64+5*A_PtrSize, "ptr", &oi)
	sz := NumGet(oi,36+2*A_PtrSize,"uint")
	hDIB :=	DllCall("GlobalAlloc", "Uint", 2, "Uptr", 40+sz, "ptr")
	pDIB := DllCall("GlobalLock", "ptr", hDIB, "ptr")
	DllCall("RtlMoveMemory", "ptr", pDIB, "ptr", &oi + 16 + 2*A_PtrSize, "Uptr", 40)
	DllCall("RtlMoveMemory", "ptr", pDIB+40, "ptr", NumGet(oi, 16+A_PtrSize), "Uptr", sz)
	DllCall("GlobalUnlock", "ptr", hDIB)
	DllCall("DeleteObject", "ptr", hBitmap)
	DllCall("OpenClipboard", "ptr", 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "Uint", 8, "ptr", hDIB)
	DllCall("CloseClipboard")
}

;++++++++++++++++++++++Center of current Screen++++++++++++++++++

GetCurrentMonitorIndex(){
	CoordMode, Mouse, Screen
	MouseGetPos, mx, my
	SysGet, monitorsCount, 80

	Loop %monitorsCount%{
		SysGet, monitor, Monitor, %A_Index%
		if (monitorLeft <= mx && mx <= monitorRight && monitorTop <= my && my <= monitorBottom){
			Return A_Index
			}
		}
		Return 1
}

CoordXCenterScreen(WidthOfGUI,ScreenNumber)
{
SysGet, Mon1, Monitor, %ScreenNumber%
	return (( Mon1Right-Mon1Left - WidthOfGUI ) / 2) + Mon1Left
}

CoordYCenterScreen(HeightofGUI,ScreenNumber)
{
SysGet, Mon1, Monitor, %ScreenNumber%
	return (Mon1Bottom - 30 - HeightofGUI ) / 2
}

GetClientSize(hwnd, ByRef w, ByRef h)
{
    VarSetCapacity(rc, 16)
    DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
    w := NumGet(rc, 8, "int")
    h := NumGet(rc, 12, "int")
}

;++++++++++++++++++++++EzQ+++++++++++++++++++++ 

EzQBanner(){
WinGetPos,TargetX,TargetY,,, MW2 Ranked tracker

TargetX := TargetX - 190
TargetY := TargetY + 120

;Set current Status
EZQStatus()

if (ScriptStatus = 0){
GuiControl,9:,StartQueX, Start EzQ
;GuiControl,9:,StartQue, show
}
if (ScriptStatus = 1){
GuiControl,9:,StartQueX, Stop EzQ
;GuiControl,9:,StartQue, show
}

Gui, 9:+LastFound
Gui, 9:Show, Center, EzQ Map Selection
WinMove, EzQ Map Selection,, %TargetX%, %TargetY%


;Read saved Selection status
FileReadLine, CurrentSelection, %CapDataPath%MapSelect.txt, 1

IF Instr(CurrentSelection, "Alboran,1"){
Map1Status = 1
GuiControl,9:,Map1, %MapSelection%Alboran_grey.png
}
Else {
Map1Status = 0
}

IF Instr(CurrentSelection, "Expo,1"){
Map2Status = 1
GuiControl,9:,Map2, %MapSelection%Expo_grey.png
}
Else {
Map2Status = 0
}

IF Instr(CurrentSelection, "Kunstenaar,1"){
Map3Status = 1
GuiControl,9:,Map3, %MapSelection%Kunstenaar_grey.png
}
Else {
Map3Status = 0
}

IF Instr(CurrentSelection, "SantaSena,1"){
Map4Status = 1
GuiControl,9:,Map4, %MapSelection%SantaSena_grey.png
}
Else {
Map4Status = 0
}

IF Instr(CurrentSelection, "Vondel,1"){
Map5Status = 1
GuiControl,9:,Map5, %MapSelection%Vondel_grey.png
}
Else {
Map5Status = 0
}

IF Instr(CurrentSelection, "Asilo,1"){
Map6Status = 1
GuiControl,9:,Map6, %MapSelection%Asilo_grey.png
}
Else {
Map6Status = 0
}

IF Instr(CurrentSelection, "Farm,1"){
Map7Status = 1
GuiControl,9:,Map7, %MapSelection%Farm_grey.png
}
Else {
Map7Status = 0
}

IF Instr(CurrentSelection, "Lighthouse,1"){
Map8Status = 1
GuiControl,9:,Map8, %MapSelection%Lighthouse_grey.png
}
Else {
Map8Status = 0
}

IF Instr(CurrentSelection, "Shipment,1"){
Map9Status = 1
GuiControl,9:,Map9, %MapSelection%Shipment_grey.png
}
Else {
Map9Status = 0
}

IF Instr(CurrentSelection, "Penthouse,1"){
Map10Status = 1
GuiControl,9:,Map10, %MapSelection%Penthouse_grey.png
}
Else {
Map10Status = 0
}

IF Instr(CurrentSelection, "BlackGold,1"){
Map11Status = 1
GuiControl,9:,Map11, %MapSelection%BlackGold_grey.png
}
Else {
Map11Status = 0
}

IF Instr(CurrentSelection, "Fortress,1"){
Map12Status = 1
GuiControl,9:,Map12, %MapSelection%Fortress_grey.png
}
Else {
Map12Status = 0
}

IF Instr(CurrentSelection, "Mercado,1"){
Map13Status = 1
GuiControl,9:,Map13, %MapSelection%Mercado_grey.png
}
Else {
Map13Status = 0
}

IF Instr(CurrentSelection, "Shoothouse,1"){
Map14Status = 1
GuiControl,9:,Map14, %MapSelection%Shoothouse_grey.png
}
Else {
Map14Status = 0
}

IF Instr(CurrentSelection, "Dome,1"){
Map16Status = 1
GuiControl,9:,Map16, %MapSelection%Dome_grey.png
}
Else {
Map16Status = 0
}

IF Instr(CurrentSelection, "Hotel,1"){
Map17Status = 1
GuiControl,9:,Map17, %MapSelection%Hotel_grey.png
}
Else {
Map17Status = 0
}

IF Instr(CurrentSelection, "Museum,1"){
Map18Status = 1
GuiControl,9:,Map18, %MapSelection%Museum_grey.png
}
Else {
Map18Status = 0
}

IF Instr(CurrentSelection, "Showdown,1"){
Map19Status = 1
GuiControl,9:,Map19, %MapSelection%Showdown_grey.png
}
Else {
Map19Status = 0
}

IF Instr(CurrentSelection, "Embassy,1"){
Map21Status = 1
GuiControl,9:,Map21, %MapSelection%Embassy_grey.png
}
Else {
Map21Status = 0
}

IF Instr(CurrentSelection, "Hydro,1"){
Map22Status = 1
GuiControl,9:,Map22, %MapSelection%Hydro_grey.png
}
Else {
Map22Status = 0
}

IF Instr(CurrentSelection, "Raceway,1"){
Map23Status = 1
GuiControl,9:,Map23, %MapSelection%Raceway_grey.png
}
Else {
Map23Status = 0 
}

IF Instr(CurrentSelection, "Taraq,1"){
Map24Status = 1
GuiControl,9:,Map24, %MapSelection%Taraq_grey.png
}
Else {
Map24Status = 0
}

}


Map1(){
;MsgBox, %Map1Status%
If (Map1Status = 0) {
GuiControl,9:,Map1, %MapSelection%Alboran_grey.png
Map1Status := 1
return
}
If (Map1Status = 1) {
GuiControl,9:,Map1, %MapSelection%Alboran.png
Map1Status := 0
return
}

}
Map2(){
GuiControl,9:,Map2, %MapSelection%Expo_grey.png

If (Map2Status = 0) {
GuiControl,,Map2, %MapSelection%Expo_grey.png
Map2Status := 1
return
}
If (Map2Status = 1) {
GuiControl,9:,Map2, %MapSelection%Expo.png
Map2Status := 0
return
}

}
Map3(){
If (Map3Status = 0) {
GuiControl,9:,Map3, %MapSelection%Kunstenaar_grey.png
Map3Status := 1
return
}
If (Map3Status = 1) {
GuiControl,9:,Map3, %MapSelection%Kunstenaar.png
Map3Status := 0
return
}

}
Map4(){
If (Map4Status = 0) {
GuiControl,9:,Map4, %MapSelection%SantaSena_grey.png
Map4Status := 1
return
}
If (Map4Status = 1) {
GuiControl,9:,Map4, %MapSelection%SantaSena.png
Map4Status := 0
return
}

}
Map5(){
If (Map5Status = 0) {
GuiControl,9:,Map5, %MapSelection%Vondel_grey.png
Map5Status := 1
return
}
If (Map5Status = 1) {
GuiControl,9:,Map5, %MapSelection%Vondel.png
Map5Status := 0
return
}

}
Map6(){
If (Map6Status = 0) {
GuiControl,9:,Map6, %MapSelection%Asilo_grey.png
Map6Status := 1
return
}
If (Map6Status = 1) {
GuiControl,9:,Map6, %MapSelection%Asilo.png
Map6Status := 0
return
}
}
Map7(){
If (Map7Status = 0) {
GuiControl,9:,Map7, %MapSelection%Farm_grey.png
Map7Status := 1
return
}
If (Map7Status = 1) {
GuiControl,9:,Map7, %MapSelection%Farm.png
Map7Status := 0
return
}
}
Map8(){
If (Map8Status = 0) {
GuiControl,9:,Map8, %MapSelection%Lighthouse_grey.png
Map8Status := 1
return
}
If (Map8Status = 1) {
GuiControl,9:,Map8, %MapSelection%Lighthouse.png
Map8Status := 0
return
}
}
Map9(){
If (Map9Status = 0) {
GuiControl,9:,Map9, %MapSelection%Shipment_grey.png
Map9Status := 1
return
}
If (Map9Status = 1) {
GuiControl,9:,Map9, %MapSelection%Shipment.png
Map9Status := 0
return
}
}
Map10(){
If (Map10Status = 0) {
GuiControl,9:,Map10, %MapSelection%Penthouse_grey.png
Map10Status := 1
return
}
If (Map10Status = 1) {
GuiControl,9:,Map10, %MapSelection%Penthouse.png
Map10Status := 0
return
}
}
Map11(){
If (Map11Status = 0) {
GuiControl,9:,Map11, %MapSelection%BlackGold_grey.png
Map11Status := 1
return
}
If (Map11Status = 1) {
GuiControl,9:,Map11, %MapSelection%BlackGold.png
Map11Status := 0
return
}
}
Map12(){

If (Map12Status = 0) {
GuiControl,9:,Map12, %MapSelection%Fortress_grey.png
Map12Status := 1
return
}
If (Map12Status = 1) {
GuiControl,9:,Map12, %MapSelection%Fortress.png
Map12Status := 0
return
}
}
Map13(){
If (Map13Status = 0) {
GuiControl,9:,Map13, %MapSelection%Mercado_grey.png
Map13Status := 1
return
}
If (Map13Status = 1) {
GuiControl,9:,Map13, %MapSelection%Mercado.png
Map13Status := 0
return
}
}
Map14(){
If (Map14Status = 0) {
GuiControl,9:,Map14, %MapSelection%Shoothouse_grey.png
Map14Status := 1
return
}
If (Map14Status = 1) {
GuiControl,9:,Map14, %MapSelection%Shoothouse.png
Map14Status := 0
return
}
}
;Map15(){
;}
Map16(){
If (Map16Status = 0) {
GuiControl,9:,Map16, %MapSelection%Dome_grey.png
Map16Status := 1
return
}
If (Map16Status = 1) {
GuiControl,9:,Map16, %MapSelection%Dome.png
Map16Status := 0
return
}
}
Map17(){
If (Map17Status = 0) {
GuiControl,9:,Map17, %MapSelection%Hotel_grey.png
Map17Status := 1
return
}
If (Map17Status = 1) {
GuiControl,9:,Map17, %MapSelection%Hotel.png
Map17Status := 0
return
}
}
Map18(){
If (Map18Status = 0) {
GuiControl,9:,Map18, %MapSelection%Museum_grey.png
Map18Status := 1
return
}
If (Map18Status = 1) {
GuiControl,9:,Map18, %MapSelection%Museum.png
Map18Status := 0
return
}
}
Map19(){
If (Map19Status = 0) {
GuiControl,9:,Map19, %MapSelection%Showdown_grey.png
Map19Status := 1
return
}
If (Map19Status = 1) {
GuiControl,9:,Map19, %MapSelection%Showdown.png
Map19Status := 0
return
}
}
;Map20(){
;}
Map21(){
If (Map21Status = 0) {
GuiControl,9:,Map21, %MapSelection%Embassy_grey.png
Map21Status := 1
return
}
If (Map21Status = 1) {
GuiControl,9:,Map21, %MapSelection%Embassy.png
Map21Status := 0
return
}
}
Map22(){
If (Map22Status = 0) {
GuiControl,9:,Map22, %MapSelection%Hydro_grey.png
Map22Status := 1
return
}
If (Map22Status = 1) {
GuiControl,9:,Map22, %MapSelection%Hydro.png
Map22Status := 0
return
}
}
Map23(){
If (Map23Status = 0) {
GuiControl,9:,Map23, %MapSelection%Raceway_grey.png
Map23Status := 1
return
}
If (Map23Status = 1) {
GuiControl,9:,Map23, %MapSelection%Raceway.png
Map23Status := 0
return
}
}
Map24(){
If (Map24Status = 0) {
GuiControl,9:,Map24, %MapSelection%Taraq_grey.png
Map24Status := 1
return
}
If (Map24Status = 1) {
GuiControl,9:,Map24, %MapSelection%Taraq.png
Map24Status := 0
return
}
}
;Map25(){
;}


OKSelect(){

;create new String for MapSelect file
NewMapSelect = Alboran,%Map1Status%,Expo,%Map2Status%,Kunstenaar,%Map3Status%,SantaSena,%Map4Status%,Vondel,%Map5Status%,Asilo,%Map6Status%,Farm,%Map7Status%,Lighthouse,%Map8Status%,Shipment,%Map9Status%,Penthouse,%Map10Status%,BlackGold,%Map11Status%,Fortress,%Map12Status%,Mercado,%Map13Status%,Shoothouse,%Map14Status%,Dome,%Map16Status%,Hotel,%Map17Status%,Museum,%Map18Status%,Showdown,%Map19Status%,Embassy,%Map21Status%,Hydro,%Map22Status%,Raceway,%Map23Status%,Taraq,%Map24Status%

filedelete, %CapDataPath%MapSelect.txt
fileappend, %NewMapSelect%, %CapDataPath%MapSelect.txt
gui ,9:hide
exit
}

StartQue(){
;Get current Status
EZQStatus()

if (ScriptStatus = 0){
;start EzQ Script
;run, EzQ.ahk
run, EzQ.exe
}
if (ScriptStatus = 1){
Process,Close,EzQ.exe
}
EZQStatus()

gui ,9:hide
exit
}


; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
;
;#####################################################################################
;#####################################################################################
; STATUS ENUMERATION
; Return values for functions specified to have status enumerated return type
;#####################################################################################
;
; Ok =						= 0
; GenericError				= 1
; InvalidParameter			= 2
; OutOfMemory				= 3
; ObjectBusy				= 4
; InsufficientBuffer		= 5
; NotImplemented			= 6
; Win32Error				= 7
; WrongState				= 8
; Aborted					= 9
; FileNotFound				= 10
; ValueOverflow				= 11
; AccessDenied				= 12
; UnknownImageFormat		= 13
; FontFamilyNotFound		= 14
; FontStyleNotFound			= 15
; NotTrueTypeFont			= 16
; UnsupportedGdiplusVersion	= 17
; GdiplusNotInitialized		= 18
; PropertyNotFound			= 19
; PropertyNotSupported		= 20
; ProfileNotFound			= 21
;
;#####################################################################################
;#####################################################################################
; FUNCTIONS
;#####################################################################################
;
; UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255)
; BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster="")
; StretchBlt(dDC, dx, dy, dw, dh, sDC, sx, sy, sw, sh, Raster="")
; SetImage(hwnd, hBitmap)
; Gdip_BitmapFromScreen(Screen=0, Raster="")
; CreateRectF(ByRef RectF, x, y, w, h)
; CreateSizeF(ByRef SizeF, w, h)
; CreateDIBSection
;
;#####################################################################################

; Function:     			UpdateLayeredWindow
; Description:  			Updates a layered window with the handle to the DC of a gdi bitmap
; 
; hwnd        				Handle of the layered window to update
; hdc           			Handle to the DC of the GDI bitmap to update the window with
; Layeredx      			x position to place the window
; Layeredy      			y position to place the window
; Layeredw      			Width of the window
; Layeredh      			Height of the window
; Alpha         			Default = 255 : The transparency (0-255) to set the window transparency
;
; return      				If the function succeeds, the return value is nonzero
;
; notes						If x or y omitted, then layered window will use its current coordinates
;							If w or h omitted then current width and height will be used

UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255)
{
	if ((x != "") && (y != ""))
		VarSetCapacity(pt, 8), NumPut(x, pt, 0), NumPut(y, pt, 4)

	if (w = "") ||(h = "")
		WinGetPos,,, w, h, ahk_id %hwnd%
   
	return DllCall("UpdateLayeredWindow", "uint", hwnd, "uint", 0, "uint", ((x = "") && (y = "")) ? 0 : &pt
	, "int64*", w|h<<32, "uint", hdc, "int64*", 0, "uint", 0, "uint*", Alpha<<16|1<<24, "uint", 2)
}

;#####################################################################################

; Function				BitBlt
; Description			The BitBlt function performs a bit-block transfer of the color data corresponding to a rectangle 
;						of pixels from the specified source device context into a destination device context.
;
; dDC					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of the area to copy
; dh					height of the area to copy
; sDC					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used, which copies the source directly to the destination rectangle
;
; BLACKNESS				= 0x00000042
; NOTSRCERASE			= 0x001100A6
; NOTSRCCOPY			= 0x00330008
; SRCERASE				= 0x00440328
; DSTINVERT				= 0x00550009
; PATINVERT				= 0x005A0049
; SRCINVERT				= 0x00660046
; SRCAND				= 0x008800C6
; MERGEPAINT			= 0x00BB0226
; MERGECOPY				= 0x00C000CA
; SRCCOPY				= 0x00CC0020
; SRCPAINT				= 0x00EE0086
; PATCOPY				= 0x00F00021
; PATPAINT				= 0x00FB0A09
; WHITENESS				= 0x00FF0062
; CAPTUREBLT			= 0x40000000
; NOMIRRORBITMAP		= 0x80000000

BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster="")
{
	return DllCall("gdi32\BitBlt", "uint", dDC, "int", dx, "int", dy, "int", dw, "int", dh
	, "uint", sDC, "int", sx, "int", sy, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				StretchBlt
; Description			The StretchBlt function copies a bitmap from a source rectangle into a destination rectangle, 
;						stretching or compressing the bitmap to fit the dimensions of the destination rectangle, if necessary.
;						The system stretches or compresses the bitmap according to the stretching mode currently set in the destination device context.
;
; ddc					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination rectangle
; dh					height of destination rectangle
; sdc					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used. It uses the same raster operations as BitBlt		

StretchBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, sw, sh, Raster="")
{
	return DllCall("gdi32\StretchBlt", "uint", ddc, "int", dx, "int", dy, "int", dw, "int", dh
	, "uint", sdc, "int", sx, "int", sy, "int", sw, "int", sh, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				SetStretchBltMode
; Description			The SetStretchBltMode function sets the bitmap stretching mode in the specified device context
;
; hdc					handle to the DC
; iStretchMode			The stretching mode, describing how the target will be stretched
;
; return				If the function succeeds, the return value is the previous stretching mode. If it fails it will return 0
;
; STRETCH_ANDSCANS 		= 0x01
; STRETCH_ORSCANS 		= 0x02
; STRETCH_DELETESCANS 	= 0x03
; STRETCH_HALFTONE 		= 0x04

SetStretchBltMode(hdc, iStretchMode=4)
{
	return DllCall("gdi32\SetStretchBltMode", "uint", hdc, "int", iStretchMode)
}

;#####################################################################################

; Function				SetImage
; Description			Associates a new image with a static control
;
; hwnd					handle of the control to update
; hBitmap				a gdi bitmap to associate the static control with
;
; return				If the function succeeds, the return value is nonzero

SetImage(hwnd, hBitmap)
{
	SendMessage, 0x172, 0x0, hBitmap,, ahk_id %hwnd%
	E := ErrorLevel
	DeleteObject(E)
	return E
}

;#####################################################################################

; Function				SetSysColorToControl
; Description			Sets a solid colour to a control
;
; hwnd					handle of the control to update
; SysColor				A system colour to set to the control
;
; return				If the function succeeds, the return value is zero
;
; notes					A control must have the 0xE style set to it so it is recognised as a bitmap
;						By default SysColor=15 is used which is COLOR_3DFACE. This is the standard background for a control
;
; COLOR_3DDKSHADOW				= 21
; COLOR_3DFACE					= 15
; COLOR_3DHIGHLIGHT				= 20
; COLOR_3DHILIGHT				= 20
; COLOR_3DLIGHT					= 22
; COLOR_3DSHADOW				= 16
; COLOR_ACTIVEBORDER			= 10
; COLOR_ACTIVECAPTION			= 2
; COLOR_APPWORKSPACE			= 12
; COLOR_BACKGROUND				= 1
; COLOR_BTNFACE					= 15
; COLOR_BTNHIGHLIGHT			= 20
; COLOR_BTNHILIGHT				= 20
; COLOR_BTNSHADOW				= 16
; COLOR_BTNTEXT					= 18
; COLOR_CAPTIONTEXT				= 9
; COLOR_DESKTOP					= 1
; COLOR_GRADIENTACTIVECAPTION	= 27
; COLOR_GRADIENTINACTIVECAPTION	= 28
; COLOR_GRAYTEXT				= 17
; COLOR_HIGHLIGHT				= 13
; COLOR_HIGHLIGHTTEXT			= 14
; COLOR_HOTLIGHT				= 26
; COLOR_INACTIVEBORDER			= 11
; COLOR_INACTIVECAPTION			= 3
; COLOR_INACTIVECAPTIONTEXT		= 19
; COLOR_INFOBK					= 24
; COLOR_INFOTEXT				= 23
; COLOR_MENU					= 4
; COLOR_MENUHILIGHT				= 29
; COLOR_MENUBAR					= 30
; COLOR_MENUTEXT				= 7
; COLOR_SCROLLBAR				= 0
; COLOR_WINDOW					= 5
; COLOR_WINDOWFRAME				= 6
; COLOR_WINDOWTEXT				= 8

SetSysColorToControl(hwnd, SysColor=15)
{
   WinGetPos,,, w, h, ahk_id %hwnd%
   bc := DllCall("GetSysColor", "Int", SysColor)
   pBrushClear := Gdip_BrushCreateSolid(0xff000000 | (bc >> 16 | bc & 0xff00 | (bc & 0xff) << 16))
   pBitmap := Gdip_CreateBitmap(w, h), G := Gdip_GraphicsFromImage(pBitmap)
   Gdip_FillRectangle(G, pBrushClear, 0, 0, w, h)
   hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
   SetImage(hwnd, hBitmap)
   Gdip_DeleteBrush(pBrushClear)
   Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
   return 0
}

;#####################################################################################

; Function				Gdip_BitmapFromScreen
; Description			Gets a gdi+ bitmap from the screen
;
; Screen				0 = All screens
;						Any numerical value = Just that screen
;						x|y|w|h = Take specific coordinates with a width and height
; Raster				raster operation code
;
; return      			If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1:		one or more of x,y,w,h not passed properly
;
; notes					If no raster operation is specified, then SRCCOPY is used to the returned bitmap

Gdip_BitmapFromScreen(Screen=0, Raster="")
{
	if (Screen = 0)
	{
		Sysget, x, 76
		Sysget, y, 77	
		Sysget, w, 78
		Sysget, h, 79
	}
	else if (SubStr(Screen, 1, 5) = "hwnd:")
	{
		Screen := SubStr(Screen, 6)
		if !WinExist( "ahk_id " Screen)
			return -2
		WinGetPos,,, w, h, ahk_id %Screen%
		x := y := 0
		hhdc := GetDCEx(Screen, 3)
	}
	else if (Screen&1 != "")
	{
		Sysget, M, Monitor, %Screen%
		x := MLeft, y := MTop, w := MRight-MLeft, h := MBottom-MTop
	}
	else
	{
		StringSplit, S, Screen, |
		x := S1, y := S2, w := S3, h := S4
	}

	if (x = "") || (y = "") || (w = "") || (h = "")
		return -1

	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)
	ReleaseDC(hhdc)
	
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}

;#####################################################################################

; Function				Gdip_BitmapFromHWND
; Description			Uses PrintWindow to get a handle to the specified window and return a bitmap from it
;
; hwnd					handle to the window to get a bitmap from
;
; return				If the function succeeds, the return value is a pointer to a gdi+ bitmap
;
; notes					Window must not be not minimised in order to get a handle to it's client area

Gdip_BitmapFromHWND(hwnd)
{
	WinGetPos,,, Width, Height, ahk_id %hwnd%
	hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
	PrintWindow(hwnd, hdc)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	return pBitmap
}

;#####################################################################################

; Function    			CreateRectF
; Description			Creates a RectF object, containing a the coordinates and dimensions of a rectangle
;
; RectF       			Name to call the RectF object
; x            			x-coordinate of the upper left corner of the rectangle
; y            			y-coordinate of the upper left corner of the rectangle
; w            			Width of the rectangle
; h            			Height of the rectangle
;
; return      			No return value

CreateRectF(ByRef RectF, x, y, w, h)
{
   VarSetCapacity(RectF, 16)
   NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
}

;#####################################################################################

; Function    			CreateRect
; Description			Creates a Rect object, containing a the coordinates and dimensions of a rectangle
;
; RectF       			Name to call the RectF object
; x            			x-coordinate of the upper left corner of the rectangle
; y            			y-coordinate of the upper left corner of the rectangle
; w            			Width of the rectangle
; h            			Height of the rectangle
;
; return      			No return value

CreateRect(ByRef Rect, x, y, w, h)
{
	VarSetCapacity(Rect, 16)
	NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
}
;#####################################################################################

; Function		    	CreateSizeF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF         		Name to call the SizeF object
; w            			w-value for the SizeF object
; h            			h-value for the SizeF object
;
; return      			No Return value

CreateSizeF(ByRef SizeF, w, h)
{
   VarSetCapacity(SizeF, 8)
   NumPut(w, SizeF, 0, "float"), NumPut(h, SizeF, 4, "float")     
}
;#####################################################################################

; Function		    	CreatePointF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF         		Name to call the SizeF object
; w            			w-value for the SizeF object
; h            			h-value for the SizeF object
;
; return      			No Return value

CreatePointF(ByRef PointF, x, y)
{
   VarSetCapacity(PointF, 8)
   NumPut(x, PointF, 0, "float"), NumPut(y, PointF, 4, "float")     
}
;#####################################################################################

; Function				CreateDIBSection
; Description			The CreateDIBSection function creates a DIB (Device Independent Bitmap) that applications can write to directly
;
; w						width of the bitmap to create
; h						height of the bitmap to create
; hdc					a handle to the device context to use the palette from
; bpp					bits per pixel (32 = ARGB)
; ppvBits				A pointer to a variable that receives a pointer to the location of the DIB bit values
;
; return				returns a DIB. A gdi bitmap
;
; notes					ppvBits will receive the location of the pixels in the DIB

CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0)
{
	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)
	NumPut(w, bi, 4), NumPut(h, bi, 8), NumPut(40, bi, 0), NumPut(1, bi, 12, "ushort"), NumPut(0, bi, 16), NumPut(bpp, bi, 14, "ushort")
	hbm := DllCall("CreateDIBSection", "uint" , hdc2, "uint" , &bi, "uint" , 0, "uint*", ppvBits, "uint" , 0, "uint" , 0)

	if !hdc
		ReleaseDC(hdc2)
	return hbm
}

;#####################################################################################

; Function				PrintWindow
; Description			The PrintWindow function copies a visual window into the specified device context (DC), typically a printer DC
;
; hwnd					A handle to the window that will be copied
; hdc					A handle to the device context
; Flags					Drawing options
;
; return				If the function succeeds, it returns a nonzero value
;
; PW_CLIENTONLY			= 1

PrintWindow(hwnd, hdc, Flags=0)
{
	return DllCall("PrintWindow", "uint", hwnd, "uint", hdc, "uint", Flags)
}

;#####################################################################################

; Function				DestroyIcon
; Description			Destroys an icon and frees any memory the icon occupied
;
; hIcon					Handle to the icon to be destroyed. The icon must not be in use
;
; return				If the function succeeds, the return value is nonzero

DestroyIcon(hIcon)
{
   return DllCall("DestroyIcon", "uint", hIcon)
}

;#####################################################################################

PaintDesktop(hdc)
{
	return DllCall("PaintDesktop", "uint", hdc)
}

;#####################################################################################

CreateCompatibleBitmap(hdc, w, h)
{
	return DllCall("gdi32\CreateCompatibleBitmap", "uint", hdc, "int", w, "int", h)
}

;#####################################################################################

; Function				CreateCompatibleDC
; Description			This function creates a memory device context (DC) compatible with the specified device
;
; hdc					Handle to an existing device context					
;
; return				returns the handle to a device context or 0 on failure
;
; notes					If this handle is 0 (by default), the function creates a memory device context compatible with the application's current screen

CreateCompatibleDC(hdc=0)
{
   return DllCall("CreateCompatibleDC", "uint", hdc)
}

;#####################################################################################

; Function				SelectObject
; Description			The SelectObject function selects an object into the specified device context (DC). The new object replaces the previous object of the same type
;
; hdc					Handle to a DC
; hgdiobj				A handle to the object to be selected into the DC
;
; return				If the selected object is not a region and the function succeeds, the return value is a handle to the object being replaced
;
; notes					The specified object must have been created by using one of the following functions
;						Bitmap - CreateBitmap, CreateBitmapIndirect, CreateCompatibleBitmap, CreateDIBitmap, CreateDIBSection (A single bitmap cannot be selected into more than one DC at the same time)
;						Brush - CreateBrushIndirect, CreateDIBPatternBrush, CreateDIBPatternBrushPt, CreateHatchBrush, CreatePatternBrush, CreateSolidBrush
;						Font - CreateFont, CreateFontIndirect
;						Pen - CreatePen, CreatePenIndirect
;						Region - CombineRgn, CreateEllipticRgn, CreateEllipticRgnIndirect, CreatePolygonRgn, CreateRectRgn, CreateRectRgnIndirect
;
; notes					If the selected object is a region and the function succeeds, the return value is one of the following value
;
; SIMPLEREGION			= 2 Region consists of a single rectangle
; COMPLEXREGION			= 3 Region consists of more than one rectangle
; NULLREGION			= 1 Region is empty

SelectObject(hdc, hgdiobj)
{
   return DllCall("SelectObject", "uint", hdc, "uint", hgdiobj)
}

;#####################################################################################

; Function				DeleteObject
; Description			This function deletes a logical pen, brush, font, bitmap, region, or palette, freeing all system resources associated with the object
;						After the object is deleted, the specified handle is no longer valid
;
; hObject				Handle to a logical pen, brush, font, bitmap, region, or palette to delete
;
; return				Nonzero indicates success. Zero indicates that the specified handle is not valid or that the handle is currently selected into a device context

DeleteObject(hObject)
{
   return DllCall("DeleteObject", "uint", hObject)
}

;#####################################################################################

; Function				GetDC
; Description			This function retrieves a handle to a display device context (DC) for the client area of the specified window.
;						The display device context can be used in subsequent graphics display interface (GDI) functions to draw in the client area of the window. 
;
; hwnd					Handle to the window whose device context is to be retrieved. If this value is NULL, GetDC retrieves the device context for the entire screen					
;
; return				The handle the device context for the specified window's client area indicates success. NULL indicates failure

GetDC(hwnd=0)
{
	return DllCall("GetDC", "uint", hwnd)
}

;#####################################################################################

; DCX_CACHE = 0x2
; DCX_CLIPCHILDREN = 0x8
; DCX_CLIPSIBLINGS = 0x10
; DCX_EXCLUDERGN = 0x40
; DCX_EXCLUDEUPDATE = 0x100
; DCX_INTERSECTRGN = 0x80
; DCX_INTERSECTUPDATE = 0x200
; DCX_LOCKWINDOWUPDATE = 0x400
; DCX_NORECOMPUTE = 0x100000
; DCX_NORESETATTRS = 0x4
; DCX_PARENTCLIP = 0x20
; DCX_VALIDATE = 0x200000
; DCX_WINDOW = 0x1

GetDCEx(hwnd, flags=0, hrgnClip=0)
{
    return DllCall("GetDCEx", "uint", hwnd, "uint", hrgnClip, "int", flags)
}

;#####################################################################################

; Function				ReleaseDC
; Description			This function releases a device context (DC), freeing it for use by other applications. The effect of ReleaseDC depends on the type of device context
;
; hdc					Handle to the device context to be released
; hwnd					Handle to the window whose device context is to be released
;
; return				1 = released
;						0 = not released
;
; notes					The application must call the ReleaseDC function for each call to the GetWindowDC function and for each call to the GetDC function that retrieves a common device context
;						An application cannot use the ReleaseDC function to release a device context that was created by calling the CreateDC function; instead, it must use the DeleteDC function. 

ReleaseDC(hdc, hwnd=0)
{
   return DllCall("ReleaseDC", "uint", hwnd, "uint", hdc)
}

;#####################################################################################

; Function				DeleteDC
; Description			The DeleteDC function deletes the specified device context (DC)
;
; hdc					A handle to the device context
;
; return				If the function succeeds, the return value is nonzero
;
; notes					An application must not delete a DC whose handle was obtained by calling the GetDC function. Instead, it must call the ReleaseDC function to free the DC

DeleteDC(hdc)
{
   return DllCall("DeleteDC", "uint", hdc)
}
;#####################################################################################

; Function				Gdip_LibraryVersion
; Description			Get the current library version
;
; return				the library version
;
; notes					This is useful for non compiled programs to ensure that a person doesn't run an old version when testing your scripts

Gdip_LibraryVersion()
{
	return 1.45
}

;#####################################################################################

; Function:    			Gdip_BitmapFromBRA
; Description: 			Gets a pointer to a gdi+ bitmap from a BRA file
;
; BRAFromMemIn			The variable for a BRA file read to memory
; File					The name of the file, or its number that you would like (This depends on alternate parameter)
; Alternate				Changes whether the File parameter is the file name or its number
;
; return      			If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1 = The BRA variable is empty
;						-2 = The BRA has an incorrect header
;						-3 = The BRA has information missing
;						-4 = Could not find file inside the BRA

Gdip_BitmapFromBRA(ByRef BRAFromMemIn, File, Alternate=0)
{
	if !BRAFromMemIn
		return -1
	Loop, Parse, BRAFromMemIn, `n
	{
		if (A_Index = 1)
		{
			StringSplit, Header, A_LoopField, |
			if (Header0 != 4 || Header2 != "BRA!")
				return -2
		}
		else if (A_Index = 2)
		{
			StringSplit, Info, A_LoopField, |
			if (Info0 != 3)
				return -3
		}
		else
			break
	}
	if !Alternate
		StringReplace, File, File, \, \\, All
	RegExMatch(BRAFromMemIn, "mi`n)^" (Alternate ? File "\|.+?\|(\d+)\|(\d+)" : "\d+\|" File "\|(\d+)\|(\d+)") "$", FileInfo)
	if !FileInfo
		return -4

	hData := DllCall("GlobalAlloc", "uint", 2, "uint", FileInfo2)
	pData := DllCall("GlobalLock", "uint", hData)
	DllCall("RtlMoveMemory", "uint", pData, "uint", &BRAFromMemIn+Info2+FileInfo1, "uint", FileInfo2)
	DllCall("GlobalUnlock", "uint", hData)
	DllCall("ole32\CreateStreamOnHGlobal", "uint", hData, "int", 1, "uint*", pStream)
	DllCall("gdiplus\GdipCreateBitmapFromStream", "uint", pStream, "uint*", pBitmap)
	DllCall(NumGet(NumGet(1*pStream)+8), "uint", pStream)
	return pBitmap
}

;#####################################################################################

; Function				Gdip_DrawRectangle
; Description			This function uses a pen to draw the outline of a rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
{
   return DllCall("gdiplus\GdipDrawRectangle", "uint", pGraphics, "uint", pPen, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_DrawRoundedRectangle
; Description			This function uses a pen to draw the outline of a rounded rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r)
{
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
	Gdip_ResetClip(pGraphics)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_ResetClip(pGraphics)
	return E
}

;#####################################################################################

; Function				Gdip_DrawEllipse
; Description			This function uses a pen to draw the outline of an ellipse into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle the ellipse will be drawn into
; y						y-coordinate of the top left of the rectangle the ellipse will be drawn into
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h)
{
   return DllCall("gdiplus\GdipDrawEllipse", "uint", pGraphics, "uint", pPen, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_DrawBezier
; Description			This function uses a pen to draw the outline of a bezier (a weighted curve) into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the bezier
; y1					y-coordinate of the start of the bezier
; x2					x-coordinate of the first arc of the bezier
; y2					y-coordinate of the first arc of the bezier
; x3					x-coordinate of the second arc of the bezier
; y3					y-coordinate of the second arc of the bezier
; x4					x-coordinate of the end of the bezier
; y4					y-coordinate of the end of the bezier
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawBezier(pGraphics, pPen, x1, y1, x2, y2, x3, y3, x4, y4)
{
   return DllCall("gdiplus\GdipDrawBezier", "uint", pgraphics, "uint", pPen
   , "float", x1, "float", y1, "float", x2, "float", y2
   , "float", x3, "float", y3, "float", x4, "float", y4)
}

;#####################################################################################

; Function				Gdip_DrawArc
; Description			This function uses a pen to draw the outline of an arc into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the arc
; y						y-coordinate of the start of the arc
; w						width of the arc
; h						height of the arc
; StartAngle			specifies the angle between the x-axis and the starting point of the arc
; SweepAngle			specifies the angle between the starting and ending points of the arc
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
   return DllCall("gdiplus\GdipDrawArc", "uint", pGraphics, "uint", pPen, "float", x
   , "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_DrawPie
; Description			This function uses a pen to draw the outline of a pie into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the pie
; y						y-coordinate of the start of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
   return DllCall("gdiplus\GdipDrawPie", "uint", pGraphics, "uint", pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_DrawLine
; Description			This function uses a pen to draw a line into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the line
; y1					y-coordinate of the start of the line
; x2					x-coordinate of the end of the line
; y2					y-coordinate of the end of the line
;
; return				status enumeration. 0 = success		

Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2)
{
   return DllCall("gdiplus\GdipDrawLine", "uint", pGraphics, "uint", pPen
   , "float", x1, "float", y1, "float", x2, "float", y2)
}

;#####################################################################################

; Function				Gdip_DrawLines
; Description			This function uses a pen to draw a series of joined lines into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success				

Gdip_DrawLines(pGraphics, pPen, Points)
{
   StringSplit, Points, Points, |
   VarSetCapacity(PointF, 8*Points0)   
   Loop, %Points0%
   {
      StringSplit, Coord, Points%A_Index%, `,
      NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
   }
   return DllCall("gdiplus\GdipDrawLines", "uint", pGraphics, "uint", pPen, "uint", &PointF, "int", Points0)
}

;#####################################################################################

; Function				Gdip_FillRectangle
; Description			This function uses a brush to fill a rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success

Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
{
   return DllCall("gdiplus\GdipFillRectangle", "uint", pGraphics, "int", pBrush
   , "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_FillRoundedRectangle
; Description			This function uses a brush to fill a rounded rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success

Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r)
{
	Region := Gdip_GetClipRegion(pGraphics)
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_DeleteRegion(Region)
	return E
}

;#####################################################################################

; Function				Gdip_FillPolygon
; Description			This function uses a brush to fill a polygon in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success
;
; notes					Alternate will fill the polygon as a whole, wheras winding will fill each new "segment"
; Alternate 			= 0
; Winding 				= 1

Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode=0)
{
   StringSplit, Points, Points, |
   VarSetCapacity(PointF, 8*Points0)   
   Loop, %Points0%
   {
      StringSplit, Coord, Points%A_Index%, `,
      NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
   }   
   return DllCall("gdiplus\GdipFillPolygon", "uint", pGraphics, "uint", pBrush, "uint", &PointF, "int", Points0, "int", FillMode)
}

;#####################################################################################

; Function				Gdip_FillPie
; Description			This function uses a brush to fill a pie in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the pie
; y						y-coordinate of the top left of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success

Gdip_FillPie(pGraphics, pBrush, x, y, w, h, StartAngle, SweepAngle)
{
   return DllCall("gdiplus\GdipFillPie", "uint", pGraphics, "uint", pBrush
   , "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_FillEllipse
; Description			This function uses a brush to fill an ellipse in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the ellipse
; y						y-coordinate of the top left of the ellipse
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success

Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h)
{
	return DllCall("gdiplus\GdipFillEllipse", "uint", pGraphics, "uint", pBrush, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_FillRegion
; Description			This function uses a brush to fill a region in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Region
;
; return				status enumeration. 0 = success
;
; notes					You can create a region Gdip_CreateRegion() and then add to this

Gdip_FillRegion(pGraphics, pBrush, Region)
{
	return DllCall("gdiplus\GdipFillRegion", "uint", pGraphics, "uint", pBrush, "uint", Region)
}

;#####################################################################################

; Function				Gdip_FillPath
; Description			This function uses a brush to fill a path in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Path
;
; return				status enumeration. 0 = success

Gdip_FillPath(pGraphics, pBrush, Path)
{
	return DllCall("gdiplus\GdipFillPath", "uint", pGraphics, "uint", pBrush, "uint", Path)
}

;#####################################################################################

; Function				Gdip_DrawImagePointsRect
; Description			This function draws a bitmap into the Graphics of another bitmap and skews it
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; Points				Points passed as x1,y1|x2,y2|x3,y3 (3 points: top left, top right, bottom left) describing the drawing of the bitmap
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter

Gdip_DrawImagePointsRect(pGraphics, pBitmap, Points, sx="", sy="", sw="", sh="", Matrix=1)
{
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}

	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
		
	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		sx := 0, sy := 0
		sw := Gdip_GetImageWidth(pBitmap)
		sh := Gdip_GetImageHeight(pBitmap)
	}

	E := DllCall("gdiplus\GdipDrawImagePointsRect", "uint", pGraphics, "uint", pBitmap
	, "uint", &PointF, "int", Points0, "float", sx, "float", sy, "float", sw, "float", sh
	, "int", 2, "uint", ImageAttr, "uint", 0, "uint", 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}

;#####################################################################################

; Function				Gdip_DrawImage
; Description			This function draws a bitmap into the Graphics of another bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination image
; dh					height of destination image
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source image
; sh					height of source image
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Gdip_DrawImage performs faster
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter. For example:
;						MatrixBright=
;						(
;						1.5		|0		|0		|0		|0
;						0		|1.5	|0		|0		|0
;						0		|0		|1.5	|0		|0
;						0		|0		|0		|1		|0
;						0.05	|0.05	|0.05	|0		|1
;						)
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|0|0|0|0|1

Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1)
{
	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		if (dx = "" && dy = "" && dw = "" && dh = "")
		{
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}
		else
		{
			sx := sy := 0
			sw := Gdip_GetImageWidth(pBitmap)
			sh := Gdip_GetImageHeight(pBitmap)
		}
	}

	E := DllCall("gdiplus\GdipDrawImageRectRect", "uint", pGraphics, "uint", pBitmap
	, "float", dx, "float", dy, "float", dw, "float", dh
	, "float", sx, "float", sy, "float", sw, "float", sh
	, "int", 2, "uint", ImageAttr, "uint", 0, "uint", 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}

;#####################################################################################

; Function				Gdip_SetImageAttributesColorMatrix
; Description			This function creates an image matrix ready for drawing
;
; Matrix				a matrix used to alter image attributes when drawing
;						passed with any delimeter
;
; return				returns an image matrix on sucess or 0 if it fails
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|0|0|0|0|1

Gdip_SetImageAttributesColorMatrix(Matrix)
{
	VarSetCapacity(ColourMatrix, 100, 0)
	Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", "", 1), "[^\d-\.]+", "|")
	StringSplit, Matrix, Matrix, |
	Loop, 25
	{
		Matrix := (Matrix%A_Index% != "") ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
		NumPut(Matrix, ColourMatrix, (A_Index-1)*4, "float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes", "uint*", ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", "uint", ImageAttr, "int", 1, "int", 1, "uint", &ColourMatrix, "int", 0, "int", 0)
	return ImageAttr
}

;#####################################################################################

; Function				Gdip_GraphicsFromImage
; Description			This function gets the graphics for a bitmap used for drawing functions
;
; pBitmap				Pointer to a bitmap to get the pointer to its graphics
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					a bitmap can be drawn into the graphics of another bitmap

Gdip_GraphicsFromImage(pBitmap)
{
    DllCall("gdiplus\GdipGetImageGraphicsContext", "uint", pBitmap, "uint*", pGraphics)
    return pGraphics
}

;#####################################################################################

; Function				Gdip_GraphicsFromHDC
; Description			This function gets the graphics from the handle to a device context
;
; hdc					This is the handle to the device context
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					You can draw a bitmap into the graphics of another bitmap

Gdip_GraphicsFromHDC(hdc)
{
    DllCall("gdiplus\GdipCreateFromHDC", "uint", hdc, "uint*", pGraphics)
    return pGraphics
}

;#####################################################################################

; Function				Gdip_GetDC
; Description			This function gets the device context of the passed Graphics
;
; hdc					This is the handle to the device context
;
; return				returns the device context for the graphics of a bitmap

Gdip_GetDC(pGraphics)
{
	DllCall("gdiplus\GdipGetDC", "uint", pGraphics, "uint*", hdc)
	return hdc
}

;#####################################################################################

; Function				Gdip_ReleaseDC
; Description			This function releases a device context from use for further use
;
; pGraphics				Pointer to the graphics of a bitmap
; hdc					This is the handle to the device context
;
; return				status enumeration. 0 = success

Gdip_ReleaseDC(pGraphics, hdc)
{
	return DllCall("gdiplus\GdipReleaseDC", "uint", pGraphics, "uint", hdc)
}

;#####################################################################################

; Function				Gdip_GraphicsClear
; Description			Clears the graphics of a bitmap ready for further drawing
;
; pGraphics				Pointer to the graphics of a bitmap
; ARGB					The colour to clear the graphics to
;
; return				status enumeration. 0 = success
;
; notes					By default this will make the background invisible
;						Using clipping regions you can clear a particular area on the graphics rather than clearing the entire graphics

Gdip_GraphicsClear(pGraphics, ARGB=0x00ffffff)
{
    return DllCall("gdiplus\GdipGraphicsClear", "uint", pGraphics, "int", ARGB)
}

;#####################################################################################

; Function				Gdip_BlurBitmap
; Description			Gives a pointer to a blurred bitmap from a pointer to a bitmap
;
; pBitmap				Pointer to a bitmap to be blurred
; Blur					The Amount to blur a bitmap by from 1 (least blur) to 100 (most blur)
;
; return				If the function succeeds, the return value is a pointer to the new blurred bitmap
;						-1 = The blur parameter is outside the range 1-100
;
; notes					This function will not dispose of the original bitmap

Gdip_BlurBitmap(pBitmap, Blur)
{
	if (Blur > 100) || (Blur < 1)
		return -1	
	
	sWidth := Gdip_GetImageWidth(pBitmap), sHeight := Gdip_GetImageHeight(pBitmap)
	dWidth := sWidth//Blur, dHeight := sHeight//Blur

	pBitmap1 := Gdip_CreateBitmap(dWidth, dHeight)
	G1 := Gdip_GraphicsFromImage(pBitmap1)
	Gdip_SetInterpolationMode(G1, 7)
	Gdip_DrawImage(G1, pBitmap, 0, 0, dWidth, dHeight, 0, 0, sWidth, sHeight)

	Gdip_DeleteGraphics(G1)

	pBitmap2 := Gdip_CreateBitmap(sWidth, sHeight)
	G2 := Gdip_GraphicsFromImage(pBitmap2)
	Gdip_SetInterpolationMode(G2, 7)
	Gdip_DrawImage(G2, pBitmap1, 0, 0, sWidth, sHeight, 0, 0, dWidth, dHeight)

	Gdip_DeleteGraphics(G2)
	Gdip_DisposeImage(pBitmap1)
	return pBitmap2
}

;#####################################################################################

; Function:     		Gdip_SaveBitmapToFile
; Description:  		Saves a bitmap to a file in any supported format onto disk
;   
; pBitmap				Pointer to a bitmap
; sOutput      			The name of the file that the bitmap will be saved to. Supported extensions are: .BMP,.DIB,.RLE,.JPG,.JPEG,.JPE,.JFIF,.GIF,.TIF,.TIFF,.PNG
; Quality      			If saving as jpg (.JPG,.JPEG,.JPE,.JFIF) then quality can be 1-100 with default at maximum quality
;
; return      			If the function succeeds, the return value is zero, otherwise:
;						-1 = Extension supplied is not a supported file format
;						-2 = Could not get a list of encoders on system
;						-3 = Could not find matching encoder for specified file format
;						-4 = Could not get WideChar name of output file
;						-5 = Could not save file to disk
;
; notes					This function will use the extension supplied from the sOutput parameter to determine the output format

Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality=75)
{
	SplitPath, sOutput,,, Extension
	if Extension not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
		return -1
	Extension := "." Extension

	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, "uint", &ci)
	if !(nCount && nSize)
		return -2
   
	Loop, %nCount%
	{
		Location := NumGet(ci, 76*(A_Index-1)+44)
		if !A_IsUnicode
		{
			nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			VarSetCapacity(sString, nSize)
			DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
			if !InStr(sString, "*" Extension)
				continue
		}
		else
		{
			nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			sString := ""
			Loop, %nSize%
				sString .= Chr(NumGet(Location+0, 2*(A_Index-1), "char"))
			if !InStr(sString, "*" Extension)
				continue
		}
		pCodec := &ci+76*(A_Index-1)
		break
	}
	if !pCodec
		return -3

	if (Quality != 75)
	{
		Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
		if Extension in .JPG,.JPEG,.JPE,.JFIF
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize", "uint", pBitmap, "uint", pCodec, "uint*", nSize)
			VarSetCapacity(EncoderParameters, nSize, 0)
			DllCall("gdiplus\GdipGetEncoderParameterList", "uint", pBitmap, "uint", pCodec, "uint", nSize, "uint", &EncoderParameters)
			Loop, % NumGet(EncoderParameters)      ;%
			{
				if (NumGet(EncoderParameters, (28*(A_Index-1))+20) = 1) && (NumGet(EncoderParameters, (28*(A_Index-1))+24) = 6)
				{
				   p := (28*(A_Index-1))+&EncoderParameters
				   NumPut(Quality, NumGet(NumPut(4, NumPut(1, p+0)+20)))
				   break
				}
			}      
	  }
	}

	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, "uint", &sOutput, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wOutput, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, "uint", &sOutput, "int", -1, "uint", &wOutput, "int", nSize)
		VarSetCapacity(wOutput, -1)
		if !VarSetCapacity(wOutput)
			return -4
		E := DllCall("gdiplus\GdipSaveImageToFile", "uint", pBitmap, "uint", &wOutput, "uint", pCodec, "uint", p ? p : 0)
	}
	else
		E := DllCall("gdiplus\GdipSaveImageToFile", "uint", pBitmap, "uint", &sOutput, "uint", pCodec, "uint", p ? p : 0)
	return E ? -5 : 0
}

;#####################################################################################

; Function				Gdip_GetPixel
; Description			Gets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				Returns the ARGB value of the pixel

Gdip_GetPixel(pBitmap, x, y)
{
	DllCall("gdiplus\GdipBitmapGetPixel", "uint", pBitmap, "int", x, "int", y, "uint*", ARGB)
	return ARGB
}

;#####################################################################################

; Function				Gdip_SetPixel
; Description			Sets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				status enumeration. 0 = success

Gdip_SetPixel(pBitmap, x, y, ARGB)
{
   return DllCall("gdiplus\GdipBitmapSetPixel", "uint", pBitmap, "int", x, "int", y, "int", ARGB)
}

;#####################################################################################

; Function				Gdip_GetImageWidth
; Description			Gives the width of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the width in pixels of the supplied bitmap

Gdip_GetImageWidth(pBitmap)
{
   DllCall("gdiplus\GdipGetImageWidth", "uint", pBitmap, "uint*", Width)
   return Width
}

;#####################################################################################

; Function				Gdip_GetImageHeight
; Description			Gives the height of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the height in pixels of the supplied bitmap

Gdip_GetImageHeight(pBitmap)
{
   DllCall("gdiplus\GdipGetImageHeight", "uint", pBitmap, "uint*", Height)
   return Height
}

;#####################################################################################

; Function				Gdip_GetDimensions
; Description			Gives the width and height of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetImageDimensions(pBitmap, ByRef Width, ByRef Height)
{
	DllCall("gdiplus\GdipGetImageWidth", "uint", pBitmap, "uint*", Width)
	DllCall("gdiplus\GdipGetImageHeight", "uint", pBitmap, "uint*", Height)
}

;#####################################################################################

Gdip_GetDimensions(pBitmap, ByRef Width, ByRef Height)
{
	Gdip_GetImageDimensions(pBitmap, Width, Height)
}

;#####################################################################################

Gdip_GetImagePixelFormat(pBitmap)
{
	DllCall("gdiplus\GdipGetImagePixelFormat", "uint", pBitmap, "uint*", Format)
	return Format
}

;#####################################################################################

; Function				Gdip_GetDpiX
; Description			Gives the horizontal dots per inch of the graphics of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetDpiX(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiX", "uint", pGraphics, "float*", dpix)
	return Round(dpix)
}

;#####################################################################################

Gdip_GetDpiY(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiY", "uint", pGraphics, "float*", dpiy)
	return Round(dpiy)
}

;#####################################################################################

Gdip_GetImageHorizontalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageHorizontalResolution", "uint", pBitmap, "float*", dpix)
	return Round(dpix)
}

;#####################################################################################

Gdip_GetImageVerticalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageVerticalResolution", "uint", pBitmap, "float*", dpiy)
	return Round(dpiy)
}

;#####################################################################################

Gdip_BitmapSetResolution(pBitmap, dpix, dpiy)
{
	return DllCall("gdiplus\GdipBitmapSetResolution", "uint", pBitmap, "float", dpix, "float", dpiy)
}

;#####################################################################################

Gdip_CreateBitmapFromFile(sFile, IconNumber=1, IconSize="")
{
	SplitPath, sFile,,, ext
	if ext in exe,dll
	{
		Sizes := IconSize ? IconSize : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
		VarSetCapacity(buf, 40)
		Loop, Parse, Sizes, |
		{
			DllCall("PrivateExtractIcons", "str", sFile, "int", IconNumber-1, "int", A_LoopField, "int", A_LoopField, "uint*", hIcon, "uint*", 0, "uint", 1, "uint", 0)
			if !hIcon
				continue

			if !DllCall("GetIconInfo", "uint", hIcon, "uint", &buf)
			{
				DestroyIcon(hIcon)
				continue
			}
			hbmColor := NumGet(buf, 16)
			hbmMask  := NumGet(buf, 12)

			if !(hbmColor && DllCall("GetObject", "uint", hbmColor, "int", 24, "uint", &buf))
			{
				DestroyIcon(hIcon)
				continue
			}
			break
		}
		if !hIcon
			return -1

		Width := NumGet(buf, 4, "int"),  Height := NumGet(buf, 8, "int")
		hbm := CreateDIBSection(Width, -Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)

		if !DllCall("DrawIconEx", "uint", hdc, "int", 0, "int", 0, "uint", hIcon, "uint", Width, "uint", Height, "uint", 0, "uint", 0, "uint", 3)
		{
			DestroyIcon(hIcon)
			return -2
		}

		VarSetCapacity(dib, 84)
		DllCall("GetObject", "uint", hbm, "int", 84, "uint", &dib)
		Stride := NumGet(dib, 12), Bits := NumGet(dib, 20)

		DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", Stride, "int", 0x26200A, "uint", Bits, "uint*", pBitmapOld)
		pBitmap := Gdip_CreateBitmap(Width, Height), G := Gdip_GraphicsFromImage(pBitmap)
		Gdip_DrawImage(G, pBitmapOld, 0, 0, Width, Height, 0, 0, Width, Height)
		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
		Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
	}
	else
	{
		if !A_IsUnicode
		{
			VarSetCapacity(wFile, 1023)
			DllCall("kernel32\MultiByteToWideChar", "uint", 0, "uint", 0, "uint", &sFile, "int", -1, "uint", &wFile, "int", 512)
			DllCall("gdiplus\GdipCreateBitmapFromFile", "uint", &wFile, "uint*", pBitmap)
		}
		else
			DllCall("gdiplus\GdipCreateBitmapFromFile", "uint", &sFile, "uint*", pBitmap)
	}
	return pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette=0)
{
	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "uint", hBitmap, "uint", Palette, "uint*", pBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff)
{
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "uint", pBitmap, "uint*", hbm, "int", Background)
	return hbm
}

;#####################################################################################

Gdip_CreateBitmapFromHICON(hIcon)
{
	DllCall("gdiplus\GdipCreateBitmapFromHICON", "uint", hIcon, "uint*", pBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_CreateHICONFromBitmap(pBitmap)
{
	DllCall("gdiplus\GdipCreateHICONFromBitmap", "uint", pBitmap, "uint*", hIcon)
	return hIcon
}

;#####################################################################################

Gdip_CreateBitmap(Width, Height, Format=0x26200A)
{
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, "uint", 0, "uint*", pBitmap)
    Return pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromClipboard()
{
	if !DllCall("OpenClipboard", "uint", 0)
		return -1
	if !DllCall("IsClipboardFormatAvailable", "uint", 8)
		return -2
	if !hBitmap := DllCall("GetClipboardData", "uint", 2)
		return -3
	if !pBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
		return -4
	if !DllCall("CloseClipboard")
		return -5
	DeleteObject(hBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_SetBitmapToClipboard(pBitmap)
{
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	DllCall("GetObject", "uint", hBitmap, "int", VarSetCapacity(oi, 84, 0), "uint", &oi)
	hdib := DllCall("GlobalAlloc", "uint", 2, "uint", 40+NumGet(oi, 44))
	pdib := DllCall("GlobalLock", "uint", hdib)
	DllCall("RtlMoveMemory", "uint", pdib, "uint", &oi+24, "uint", 40)
	DllCall("RtlMoveMemory", "Uint", pdib+40, "Uint", NumGet(oi, 20), "uint", NumGet(oi, 44))
	DllCall("GlobalUnlock", "uint", hdib)
	DllCall("DeleteObject", "uint", hBitmap)
	DllCall("OpenClipboard", "uint", 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "uint", 8, "uint", hdib)
	DllCall("CloseClipboard")
}

;#####################################################################################

Gdip_CloneBitmapArea(pBitmap, x, y, w, h, Format=0x26200A)
{
	DllCall("gdiplus\GdipCloneBitmapArea", "float", x, "float", y, "float", w, "float", h
	, "int", Format, "uint", pBitmap, "uint*", pBitmapDest)
	return pBitmapDest
}

;#####################################################################################
; Create resources
;#####################################################################################

Gdip_CreatePen(ARGB, w)
{
   DllCall("gdiplus\GdipCreatePen1", "int", ARGB, "float", w, "int", 2, "uint*", pPen)
   return pPen
}

;#####################################################################################

Gdip_CreatePenFromBrush(pBrush, w)
{
	DllCall("gdiplus\GdipCreatePen2", "uint", pBrush, "float", w, "int", 2, "uint*", pPen)
	return pPen
}

;#####################################################################################

Gdip_BrushCreateSolid(ARGB=0xff000000)
{
	DllCall("gdiplus\GdipCreateSolidFill", "int", ARGB, "uint*", pBrush)
	return pBrush
}

;#####################################################################################

; HatchStyleHorizontal = 0
; HatchStyleVertical = 1
; HatchStyleForwardDiagonal = 2
; HatchStyleBackwardDiagonal = 3
; HatchStyleCross = 4
; HatchStyleDiagonalCross = 5
; HatchStyle05Percent = 6
; HatchStyle10Percent = 7
; HatchStyle20Percent = 8
; HatchStyle25Percent = 9
; HatchStyle30Percent = 10
; HatchStyle40Percent = 11
; HatchStyle50Percent = 12
; HatchStyle60Percent = 13
; HatchStyle70Percent = 14
; HatchStyle75Percent = 15
; HatchStyle80Percent = 16
; HatchStyle90Percent = 17
; HatchStyleLightDownwardDiagonal = 18
; HatchStyleLightUpwardDiagonal = 19
; HatchStyleDarkDownwardDiagonal = 20
; HatchStyleDarkUpwardDiagonal = 21
; HatchStyleWideDownwardDiagonal = 22
; HatchStyleWideUpwardDiagonal = 23
; HatchStyleLightVertical = 24
; HatchStyleLightHorizontal = 25
; HatchStyleNarrowVertical = 26
; HatchStyleNarrowHorizontal = 27
; HatchStyleDarkVertical = 28
; HatchStyleDarkHorizontal = 29
; HatchStyleDashedDownwardDiagonal = 30
; HatchStyleDashedUpwardDiagonal = 31
; HatchStyleDashedHorizontal = 32
; HatchStyleDashedVertical = 33
; HatchStyleSmallConfetti = 34
; HatchStyleLargeConfetti = 35
; HatchStyleZigZag = 36
; HatchStyleWave = 37
; HatchStyleDiagonalBrick = 38
; HatchStyleHorizontalBrick = 39
; HatchStyleWeave = 40
; HatchStylePlaid = 41
; HatchStyleDivot = 42
; HatchStyleDottedGrid = 43
; HatchStyleDottedDiamond = 44
; HatchStyleShingle = 45
; HatchStyleTrellis = 46
; HatchStyleSphere = 47
; HatchStyleSmallGrid = 48
; HatchStyleSmallCheckerBoard = 49
; HatchStyleLargeCheckerBoard = 50
; HatchStyleOutlinedDiamond = 51
; HatchStyleSolidDiamond = 52
; HatchStyleTotal = 53
Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle=0)
{
	DllCall("gdiplus\GdipCreateHatchBrush", "int", HatchStyle, "int", ARGBfront, "int", ARGBback, "uint*", pBrush)
	return pBrush
}

;#####################################################################################

Gdip_CreateTextureBrush(pBitmap, WrapMode=1, x=0, y=0, w="", h="")
{
	if !(w && h)
		DllCall("gdiplus\GdipCreateTexture", "uint", pBitmap, "int", WrapMode, "uint*", pBrush)
	else
		DllCall("gdiplus\GdipCreateTexture2", "uint", pBitmap, "int", WrapMode, "float", x, "float", y, "float", w, "float", h, "uint*", pBrush)
	return pBrush
}

;#####################################################################################

; WrapModeTile = 0
; WrapModeTileFlipX = 1
; WrapModeTileFlipY = 2
; WrapModeTileFlipXY = 3
; WrapModeClamp = 4
Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode=1)
{
	CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
	DllCall("gdiplus\GdipCreateLineBrush", "uint", &PointF1, "uint", &PointF2, "int", ARGB1, "int", ARGB2, "int", WrapMode, "uint*", LGpBrush)
	return LGpBrush
}

;#####################################################################################

; LinearGradientModeHorizontal = 0
; LinearGradientModeVertical = 1
; LinearGradientModeForwardDiagonal = 2
; LinearGradientModeBackwardDiagonal = 3
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode=1, WrapMode=1)
{
	CreateRectF(RectF, x, y, w, h)
	DllCall("gdiplus\GdipCreateLineBrushFromRect", "uint", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, "uint*", LGpBrush)
	return LGpBrush
}

;#####################################################################################

Gdip_CloneBrush(pBrush)
{
	DllCall("gdiplus\GdipCloneBrush", "uint", pBrush, "uint*", pBrushClone)
	return pBrushClone
}

;#####################################################################################
; Delete resources
;#####################################################################################

Gdip_DeletePen(pPen)
{
   return DllCall("gdiplus\GdipDeletePen", "uint", pPen)
}

;#####################################################################################

Gdip_DeleteBrush(pBrush)
{
   return DllCall("gdiplus\GdipDeleteBrush", "uint", pBrush)
}

;#####################################################################################

Gdip_DisposeImage(pBitmap)
{
   return DllCall("gdiplus\GdipDisposeImage", "uint", pBitmap)
}

;#####################################################################################

Gdip_DeleteGraphics(pGraphics)
{
   return DllCall("gdiplus\GdipDeleteGraphics", "uint", pGraphics)
}

;#####################################################################################

Gdip_DisposeImageAttributes(ImageAttr)
{
	return DllCall("gdiplus\GdipDisposeImageAttributes", "uint", ImageAttr)
}

;#####################################################################################

Gdip_DeleteFont(hFont)
{
   return DllCall("gdiplus\GdipDeleteFont", "uint", hFont)
}

;#####################################################################################

Gdip_DeleteStringFormat(hFormat)
{
   return DllCall("gdiplus\GdipDeleteStringFormat", "uint", hFormat)
}

;#####################################################################################

Gdip_DeleteFontFamily(hFamily)
{
   return DllCall("gdiplus\GdipDeleteFontFamily", "uint", hFamily)
}

;#####################################################################################

Gdip_DeleteMatrix(Matrix)
{
   return DllCall("gdiplus\GdipDeleteMatrix", "uint", Matrix)
}

;#####################################################################################
; Text functions
;#####################################################################################

Gdip_TextToGraphics(pGraphics, Text, Options, Font="Arial", Width="", Height="", Measure=0)
{
	IWidth := Width, IHeight:= Height
	
	RegExMatch(Options, "i)X([\-\d\.]+)(p*)", xpos)
	RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", ypos)
	RegExMatch(Options, "i)W([\-\d\.]+)(p*)", Width)
	RegExMatch(Options, "i)H([\-\d\.]+)(p*)", Height)
	RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", Colour)
	RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", vPos)
	RegExMatch(Options, "i)NoWrap", NoWrap)
	RegExMatch(Options, "i)R(\d)", Rendering)
	RegExMatch(Options, "i)S(\d+)(p*)", Size)

	if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour2))
		PassBrush := 1, pBrush := Colour2
	
	if !(IWidth && IHeight) && (xpos2 || ypos2 || Width2 || Height2 || Size2)
		return -1

	Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
	Loop, Parse, Styles, |
	{
		if RegExMatch(Options, "\b" A_loopField)
		Style |= (A_LoopField != "StrikeOut") ? (A_Index-1) : 8
	}
  
	Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
	Loop, Parse, Alignments, |
	{
		if RegExMatch(Options, "\b" A_loopField)
			Align |= A_Index//2.1      ; 0|0|1|1|2|2
	}

	xpos := (xpos1 != "") ? xpos2 ? IWidth*(xpos1/100) : xpos1 : 0
	ypos := (ypos1 != "") ? ypos2 ? IHeight*(ypos1/100) : ypos1 : 0
	Width := Width1 ? Width2 ? IWidth*(Width1/100) : Width1 : IWidth
	Height := Height1 ? Height2 ? IHeight*(Height1/100) : Height1 : IHeight
	if !PassBrush
		Colour := "0x" (Colour2 ? Colour2 : "ff000000")
	Rendering := ((Rendering1 >= 0) && (Rendering1 <= 5)) ? Rendering1 : 4
	Size := (Size1 > 0) ? Size2 ? IHeight*(Size1/100) : Size1 : 12

	hFamily := Gdip_FontFamilyCreate(Font)
	hFont := Gdip_FontCreate(hFamily, Size, Style)
	FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
	hFormat := Gdip_StringFormatCreate(FormatStyle)
	pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
	if !(hFamily && hFont && hFormat && pBrush && pGraphics)
		return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0
   
	CreateRectF(RC, xpos, ypos, Width, Height)
	Gdip_SetStringFormatAlign(hFormat, Align)
	Gdip_SetTextRenderingHint(pGraphics, Rendering)
	ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)

	if vPos
	{
		StringSplit, ReturnRC, ReturnRC, |
		
		if (vPos = "vCentre") || (vPos = "vCenter")
			ypos += (Height-ReturnRC4)//2
		else if (vPos = "Top") || (vPos = "Up")
			ypos := 0
		else if (vPos = "Bottom") || (vPos = "Down")
			ypos := Height-ReturnRC4
		
		CreateRectF(RC, xpos, ypos, Width, ReturnRC4)
		ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
	}

	if !Measure
		E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)

	if !PassBrush
		Gdip_DeleteBrush(pBrush)
	Gdip_DeleteStringFormat(hFormat)   
	Gdip_DeleteFont(hFont)
	Gdip_DeleteFontFamily(hFamily)
	return E ? E : ReturnRC
}

;#####################################################################################

Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF)
{
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, "uint", &sString, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, "uint", &sString, "int", -1, "uint", &wString, "int", nSize)
		return DllCall("gdiplus\GdipDrawString", "uint", pGraphics
		, "uint", &wString, "int", -1, "uint", hFont, "uint", &RectF, "uint", hFormat, "uint", pBrush)
	}
	else
	{
		return DllCall("gdiplus\GdipDrawString", "uint", pGraphics
		, "uint", &sString, "int", -1, "uint", hFont, "uint", &RectF, "uint", hFormat, "uint", pBrush)
	}	
}

;#####################################################################################

Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF)
{
	VarSetCapacity(RC, 16)
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, "uint", &sString, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wString, nSize*2)   
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, "uint", &sString, "int", -1, "uint", &wString, "int", nSize)
		DllCall("gdiplus\GdipMeasureString", "uint", pGraphics
		, "uint", &wString, "int", -1, "uint", hFont, "uint", &RectF, "uint", hFormat, "uint", &RC, "uint*", Chars, "uint*", Lines)
	}
	else
	{
		DllCall("gdiplus\GdipMeasureString", "uint", pGraphics
		, "uint", &sString, "int", -1, "uint", hFont, "uint", &RectF, "uint", hFormat, "uint", &RC, "uint*", Chars, "uint*", Lines)
	}
	return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
}

; Near = 0
; Center = 1
; Far = 2
Gdip_SetStringFormatAlign(hFormat, Align)
{
   return DllCall("gdiplus\GdipSetStringFormatAlign", "uint", hFormat, "int", Align)
}

; StringFormatFlagsDirectionRightToLeft    = 0x00000001
; StringFormatFlagsDirectionVertical       = 0x00000002
; StringFormatFlagsNoFitBlackBox           = 0x00000004
; StringFormatFlagsDisplayFormatControl    = 0x00000020
; StringFormatFlagsNoFontFallback          = 0x00000400
; StringFormatFlagsMeasureTrailingSpaces   = 0x00000800
; StringFormatFlagsNoWrap                  = 0x00001000
; StringFormatFlagsLineLimit               = 0x00002000
; StringFormatFlagsNoClip                  = 0x00004000 
Gdip_StringFormatCreate(Format=0, Lang=0)
{
   DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, "uint*", hFormat)
   return hFormat
}

; Regular = 0
; Bold = 1
; Italic = 2
; BoldItalic = 3
; Underline = 4
; Strikeout = 8
Gdip_FontCreate(hFamily, Size, Style=0)
{
   DllCall("gdiplus\GdipCreateFont", "uint", hFamily, "float", Size, "int", Style, "int", 0, "uint*", hFont)
   return hFont
}

Gdip_FontFamilyCreate(Font)
{
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, "uint", &Font, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wFont, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, "uint", &Font, "int", -1, "uint", &wFont, "int", nSize)
		DllCall("gdiplus\GdipCreateFontFamilyFromName", "uint", &wFont, "uint", 0, "uint*", hFamily)
	}
	else
		DllCall("gdiplus\GdipCreateFontFamilyFromName", "uint", &Font, "uint", 0, "uint*", hFamily)
	return hFamily
}

;#####################################################################################
; Matrix functions
;#####################################################################################

Gdip_CreateAffineMatrix(m11, m12, m21, m22, x, y)
{
   DllCall("gdiplus\GdipCreateMatrix2", "float", m11, "float", m12, "float", m21, "float", m22, "float", x, "float", y, "uint*", Matrix)
   return Matrix
}

Gdip_CreateMatrix()
{
   DllCall("gdiplus\GdipCreateMatrix", "uint*", Matrix)
   return Matrix
}

;#####################################################################################
; GraphicsPath functions
;#####################################################################################

; Alternate = 0
; Winding = 1
Gdip_CreatePath(BrushMode=0)
{
	DllCall("gdiplus\GdipCreatePath", "int", BrushMode, "uint*", Path)
	return Path
}

Gdip_AddPathEllipse(Path, x, y, w, h)
{
	return DllCall("gdiplus\GdipAddPathEllipse", "uint", Path, "float", x, "float", y, "float", w, "float", h)
}

Gdip_AddPathPolygon(Path, Points)
{
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}   

	return DllCall("gdiplus\GdipAddPathPolygon", "uint", Path, "uint", &PointF, "int", Points0)
}

Gdip_DeletePath(Path)
{
	return DllCall("gdiplus\GdipDeletePath", "uint", Path)
}

;#####################################################################################
; Quality functions
;#####################################################################################

; SystemDefault = 0
; SingleBitPerPixelGridFit = 1
; SingleBitPerPixel = 2
; AntiAliasGridFit = 3
; AntiAlias = 4
Gdip_SetTextRenderingHint(pGraphics, RenderingHint)
{
	return DllCall("gdiplus\GdipSetTextRenderingHint", "uint", pGraphics, "int", RenderingHint)
}

; Default = 0
; LowQuality = 1
; HighQuality = 2
; Bilinear = 3
; Bicubic = 4
; NearestNeighbor = 5
; HighQualityBilinear = 6
; HighQualityBicubic = 7
Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
{
   return DllCall("gdiplus\GdipSetInterpolationMode", "uint", pGraphics, "int", InterpolationMode)
}

; Default = 0
; HighSpeed = 1
; HighQuality = 2
; None = 3
; AntiAlias = 4
Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
{
   return DllCall("gdiplus\GdipSetSmoothingMode", "uint", pGraphics, "int", SmoothingMode)
}

; CompositingModeSourceOver = 0 (blended)
; CompositingModeSourceCopy = 1 (overwrite)
Gdip_SetCompositingMode(pGraphics, CompositingMode=0)
{
   return DllCall("gdiplus\GdipSetCompositingMode", "uint", pGraphics, "int", CompositingMode)
}

;#####################################################################################
; Extra functions
;#####################################################################################

Gdip_Startup()
{
	if !DllCall("GetModuleHandle", "str", "gdiplus")
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", "uint*", pToken, "uint", &si, "uint", 0)
	return pToken
}

Gdip_Shutdown(pToken)
{
	DllCall("gdiplus\GdiplusShutdown", "uint", pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus")
		DllCall("FreeLibrary", "uint", hModule)
	return 0
}

; Prepend = 0; The new operation is applied before the old operation.
; Append = 1; The new operation is applied after the old operation.
Gdip_RotateWorldTransform(pGraphics, Angle, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipRotateWorldTransform", "uint", pGraphics, "float", Angle, "int", MatrixOrder)
}

Gdip_ScaleWorldTransform(pGraphics, x, y, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipScaleWorldTransform", "uint", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_TranslateWorldTransform(pGraphics, x, y, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipTranslateWorldTransform", "uint", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_ResetWorldTransform(pGraphics)
{
	return DllCall("gdiplus\GdipResetWorldTransform", "uint", pGraphics)
}

Gdip_GetRotatedTranslation(Width, Height, Angle, ByRef xTranslation, ByRef yTranslation)
{
	pi := 3.14159, TAngle := Angle*(pi/180)	

	Bound := (Angle >= 0) ? Mod(Angle, 360) : 360-Mod(-Angle, -360)
	if ((Bound >= 0) && (Bound <= 90))
		xTranslation := Height*Sin(TAngle), yTranslation := 0
	else if ((Bound > 90) && (Bound <= 180))
		xTranslation := (Height*Sin(TAngle))-(Width*Cos(TAngle)), yTranslation := -Height*Cos(TAngle)
	else if ((Bound > 180) && (Bound <= 270))
		xTranslation := -(Width*Cos(TAngle)), yTranslation := -(Height*Cos(TAngle))-(Width*Sin(TAngle))
	else if ((Bound > 270) && (Bound <= 360))
		xTranslation := 0, yTranslation := -Width*Sin(TAngle)
}

Gdip_GetRotatedDimensions(Width, Height, Angle, ByRef RWidth, ByRef RHeight)
{
	pi := 3.14159, TAngle := Angle*(pi/180)
	if !(Width && Height)
		return -1
	RWidth := Ceil(Abs(Width*Cos(TAngle))+Abs(Height*Sin(TAngle)))
	RHeight := Ceil(Abs(Width*Sin(TAngle))+Abs(Height*Cos(Tangle)))
}

; RotateNoneFlipNone   = 0
; Rotate90FlipNone     = 1
; Rotate180FlipNone    = 2
; Rotate270FlipNone    = 3
; RotateNoneFlipX      = 4
; Rotate90FlipX        = 5
; Rotate180FlipX       = 6
; Rotate270FlipX       = 7
; RotateNoneFlipY      = Rotate180FlipX
; Rotate90FlipY        = Rotate270FlipX
; Rotate180FlipY       = RotateNoneFlipX
; Rotate270FlipY       = Rotate90FlipX
; RotateNoneFlipXY     = Rotate180FlipNone
; Rotate90FlipXY       = Rotate270FlipNone
; Rotate180FlipXY      = RotateNoneFlipNone
; Rotate270FlipXY      = Rotate90FlipNone 

Gdip_ImageRotateFlip(pBitmap, RotateFlipType=1)
{
	return DllCall("gdiplus\GdipImageRotateFlip", "uint", pBitmap, "int", RotateFlipType)
}

; Replace = 0
; Intersect = 1
; Union = 2
; Xor = 3
; Exclude = 4
; Complement = 5
Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode=0)
{
   return DllCall("gdiplus\GdipSetClipRect", "uint", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
}

Gdip_SetClipPath(pGraphics, Path, CombineMode=0)
{
   return DllCall("gdiplus\GdipSetClipPath", "uint", pGraphics, "uint", Path, "int", CombineMode)
}

Gdip_ResetClip(pGraphics)
{
   return DllCall("gdiplus\GdipResetClip", "uint", pGraphics)
}

Gdip_GetClipRegion(pGraphics)
{
	Region := Gdip_CreateRegion()
	DllCall("gdiplus\GdipGetClip", "uint" pGraphics, "uint*", Region)
	return Region
}

Gdip_SetClipRegion(pGraphics, Region, CombineMode=0)
{
	return DllCall("gdiplus\GdipSetClipRegion", "uint", pGraphics, "uint", Region, "int", CombineMode)
}

Gdip_CreateRegion()
{
	DllCall("gdiplus\GdipCreateRegion", "uint*", Region)
	return Region
}

Gdip_DeleteRegion(Region)
{
	return DllCall("gdiplus\GdipDeleteRegion", "uint", Region)
}

;#####################################################################################
; BitmapLockBits
;#####################################################################################

Gdip_LockBits(pBitmap, x, y, w, h, ByRef Stride, ByRef Scan0, ByRef BitmapData, LockMode = 3, PixelFormat = 0x26200a)
{   
	CreateRect(Rect, x, y, w, h)
	VarSetCapacity(BitmapData, 21, 0)
	E := DllCall("Gdiplus\GdipBitmapLockBits", "uint", pBitmap, "uint", &Rect, "uint", LockMode, "int", PixelFormat, "uint", &BitmapData)
	Stride := NumGet(BitmapData, 8)
	Scan0 := NumGet(BitmapData, 16)
	return E
}

;#####################################################################################

Gdip_UnlockBits(pBitmap, ByRef BitmapData)
{
	return DllCall("Gdiplus\GdipBitmapUnlockBits", "uint", pBitmap, "uint", &BitmapData)
}

;#####################################################################################

Gdip_SetLockBitPixel(ARGB, Scan0, x, y, Stride)
{
	Numput(ARGB, Scan0+0, (x*4)+(y*Stride))
}

;#####################################################################################

Gdip_GetLockBitPixel(Scan0, x, y, Stride)
{
	return NumGet(Scan0+0, (x*4)+(y*Stride))
}

;#####################################################################################

Gdip_PixelateBitmap(pBitmap, ByRef pBitmapOut, BlockSize)
{
	static PixelateBitmap
	if !PixelateBitmap
	{
		MCode_PixelateBitmap := "83EC388B4424485355568B74245C99F7FE8B5C244C8B6C2448578BF88BCA894C241C897C243485FF0F8E2E0300008B44245"
		. "499F7FE897C24448944242833C089542418894424308944242CEB038D490033FF397C2428897C24380F8E750100008BCE0FAFCE894C24408DA4240000"
		. "000033C03BF08944241089442460894424580F8E8A0000008B5C242C8D4D028BD52BD183C203895424208D3CBB0FAFFE8BD52BD142895424248BD52BD"
		. "103F9897C24148974243C8BCF8BFE8DA424000000008B5C24200FB61C0B03C30FB619015C24588B5C24240FB61C0B015C24600FB61C11015C241083C1"
		. "0483EF0175D38B7C2414037C245C836C243C01897C241475B58B7C24388B6C244C8B5C24508B4C244099F7F9894424148B44245899F7F9894424588B4"
		. "4246099F7F9894424608B44241099F7F98944241085F60F8E820000008D4B028BC32BC18D68038B44242C8D04B80FAFC68BD32BD142895424248BD32B"
		. "D103C18944243C89742420EB038D49008BC88BFE0FB64424148B5C24248804290FB644245888010FB644246088040B0FB644241088040A83C10483EF0"
		. "175D58B44243C0344245C836C2420018944243C75BE8B4C24408B5C24508B6C244C8B7C2438473B7C2428897C24380F8C9FFEFFFF8B4C241C33D23954"
		. "24180F846401000033C03BF2895424108954246089542458895424148944243C0F8E82000000EB0233D2395424187E6F8B4C243003C80FAF4C245C8B4"
		. "424280FAFC68D550203CA8D0C818BC52BC283C003894424208BC52BC2408BFD2BFA8B54241889442424895424408B4424200FB614080FB60101542414"
		. "8B542424014424580FB6040A0FB61439014424600154241083C104836C24400175CF8B44243C403BC68944243C7C808B4C24188B4424140FAFCE99F7F"
		. "9894424148B44245899F7F9894424588B44246099F7F9894424608B44241099F7F98944241033C08944243C85F60F8E7F000000837C2418007E6F8B4C"
		. "243003C80FAF4C245C8B4424280FAFC68D530203CA8D0C818BC32BC283C003894424208BC32BC2408BFB2BFA8B54241889442424895424400FB644241"
		. "48B5424208804110FB64424580FB654246088018B4424248814010FB654241088143983C104836C24400175CF8B44243C403BC68944243C7C818B4C24"
		. "1C8B44245C0144242C01742430836C2444010F85F4FCFFFF8B44245499F7FE895424188944242885C00F8E890100008BF90FAFFE33D2897C243C89542"
		. "45489442438EB0233D233C03BCA89542410895424608954245889542414894424400F8E840000003BF27E738B4C24340FAFCE03C80FAF4C245C034C24"
		. "548D55028BC52BC283C003894424208BC52BC2408BFD03CA894424242BFA89742444908B5424200FB6040A0FB611014424148B442424015424580FB61"
		. "4080FB6040F015424600144241083C104836C24440175CF8B4424408B7C243C8B4C241C33D2403BC1894424400F8C7CFFFFFF8B44241499F7FF894424"
		. "148B44245899F7FF894424588B44246099F7FF894424608B44241099F7FF8944241033C08944244085C90F8E8000000085F67E738B4C24340FAFCE03C"
		. "80FAF4C245C034C24548D53028BC32BC283C003894424208BC32BC2408BFB03CA894424242BFA897424448D49000FB65424148B4424208814010FB654"
		. "24580FB644246088118B5424248804110FB644241088043983C104836C24440175CF8B4424408B7C243C8B4C241C403BC1894424407C808D04B500000"
		. "00001442454836C2438010F858CFEFFFF33D233C03BCA89542410895424608954245889542414894424440F8E9A000000EB048BFF33D2395424180F8E"
		. "7D0000008B4C24340FAFCE03C80FAF4C245C8B4424280FAFC68D550203CA8D0C818BC52BC283C003894424208BC52BC240894424248BC52BC28B54241"
		. "8895424548DA424000000008B5424200FB6140A015424140FB611015424588B5424240FB6140A015424600FB614010154241083C104836C24540175CF"
		. "8B4424448B4C241C403BC1894424440F8C6AFFFFFF0FAF4C24188B44241499F7F9894424148B44245899F7F9894424588B44246099F7F9894424608B4"
		. "4241099F7F98944241033C03944241C894424540F8E7B0000008B7C241885FF7E688B4C24340FAFCE03C80FAF4C245C8B4424280FAFC68D530203CA8D"
		. "0C818BC32BC283C003894424208BC32BC2408BEB894424242BEA0FB65424148B4424208814010FB65424580FB644246088118B5424248804110FB6442"
		. "41088042983C10483EF0175D18B442454403B44241C894424547C855F5E5D33C05B83C438C3"
		VarSetCapacity(PixelateBitmap, StrLen(MCode_PixelateBitmap)//2)
		Loop % StrLen(MCode_PixelateBitmap)//2		;%
			NumPut("0x" SubStr(MCode_PixelateBitmap, (2*A_Index)-1, 2), PixelateBitmap, A_Index-1, "char")
	}

	Gdip_GetImageDimensions(pBitmap, Width, Height)
	if (Width != Gdip_GetImageWidth(pBitmapOut) || Height != Gdip_GetImageHeight(pBitmapOut))
		return -1
	if (BlockSize > Width || BlockSize > Height)
		return -2

	E1 := Gdip_LockBits(pBitmap, 0, 0, Width, Height, Stride1, Scan01, BitmapData1)
	E2 := Gdip_LockBits(pBitmapOut, 0, 0, Width, Height, Stride2, Scan02, BitmapData2)
	if (E1 || E2)
		return -3

	E := DllCall(&PixelateBitmap, "uint", Scan01, "uint", Scan02, "int", Width, "int", Height, "int", Stride1, "int", BlockSize)
	Gdip_UnlockBits(pBitmap, BitmapData1), Gdip_UnlockBits(pBitmapOut, BitmapData2)
	return 0
}

;#####################################################################################

Gdip_ToARGB(A, R, G, B)
{
	return (A << 24) | (R << 16) | (G << 8) | B
}

;#####################################################################################

Gdip_FromARGB(ARGB, ByRef A, ByRef R, ByRef G, ByRef B)
{
	A := (0xff000000 & ARGB) >> 24
	R := (0x00ff0000 & ARGB) >> 16
	G := (0x0000ff00 & ARGB) >> 8
	B := 0x000000ff & ARGB
}

;#####################################################################################

Gdip_AFromARGB(ARGB)
{
	return (0xff000000 & ARGB) >> 24
}

;#####################################################################################

Gdip_RFromARGB(ARGB)
{
	return (0x00ff0000 & ARGB) >> 16
}

;#####################################################################################

Gdip_GFromARGB(ARGB)
{
	return (0x0000ff00 & ARGB) >> 8
}

;#####################################################################################

Gdip_BFromARGB(ARGB)
{
	return 0x000000ff & ARGB
}

;#####################################Exit##################################

^!+x:: ExitApp

Exit:
Gdip_ShutDown(pToken)
Process, Close, EzQ.exe
ExitApp
return
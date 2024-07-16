---@diagnostic disable: undefined-global, lowercase-global
--[[ 
AOBs:
t? rpm? c? 76 03 0F 28 F0 F3 44 0F 10 93
vf?        48 85 C0 74 3C 8B 80 00 00 00 00 C1 E8 0F
]]

tokyodrift = gui.get_tab("GUI_TAB_VEHICLE"):add_tab("Tokyo Drift")
local popsnd, sndRef
local flame_size
local driftMode          = false
local DriftTires         = false
local is_car             = false
local is_quad            = false
local is_boat            = false
local is_bike            = false
local validModel         = false
local speedBoost         = false
local sfx                = false
local ptfx               = false
local nosvfx             = false
local hornLight          = false
local nosPurge           = false
local rgbLights          = false
local has_xenon          = false
local purge_started      = false
local nos_started        = false
local twostep_started    = false
local is_typing          = false
local loud_radio         = false
local louderPops         = false
local open_sounds_window = false
local started_lct        = false
local launch_active      = false
local started_popSound   = false
local started_popSound2  = false
local holdF              = false
local timerA             = 0
local timerB             = 0
-- local defaultFcamber     = 0
-- local defaultRcamber     = 0
-- local fCamber            = 0
-- local rCamber            = 0
local lastVeh            = 0
local defaultXenon       = 0
local DriftIntensity     = 0
local vehSound_index     = 0
local lightSpeed         = 1
local tdBtn              = 21
local search_term        = ""
local nosptfx_t          = {}
local purgePtfx_t        = {}
local lctPtfx_t          = {}
local popSounds_t        = {}
local popsPtfx_t         = {}
local gta_vehicles       = {"Airbus", "Airtug", "akula", "akuma", "aleutian", "alkonost", "alpha", "alphaz1", "AMBULANCE", "annihilator", "annihilator2", "apc", "ardent", "armytanker", "armytrailer", "armytrailer2", "asbo", "asea", "asea2", "asterope", "asterope2", "astron", "autarch", "avarus", "avenger", "avenger2", "avenger3", "avenger4", "avisa", "bagger", "baletrailer", "Baller", "baller2", "baller3", "baller4", "baller5", "baller6", "baller7", "baller8", "banshee", "banshee2", "BARRACKS", "BARRACKS2", "BARRACKS3", "barrage", "bati", "bati2", "Benson", "benson2", "besra", "bestiagts", "bf400", "BfInjection", "Biff", "bifta", "bison", "Bison2", "Bison3", "BjXL", "blade", "blazer", "blazer2", "blazer3", "blazer4", "blazer5", "BLIMP", "BLIMP2", "blimp3", "blista", "blista2", "blista3", "BMX", "boattrailer", "boattrailer2", "boattrailer3", "bobcatXL", "Bodhi2", "bombushka", "boor", "boxville", "boxville2", "boxville3", "boxville4", "boxville5", "boxville6", "brawler", "brickade", "brickade2", "brigham", "brioso", "brioso2", "brioso3", "broadway", "bruiser", "bruiser2", "bruiser3", "brutus", "brutus2", "brutus3", "btype", "btype2", "btype3", "buccaneer", "buccaneer2", "buffalo", "buffalo2", "buffalo3", "buffalo4", "buffalo5", "bulldozer", "bullet", "Burrito", "burrito2", "burrito3", "Burrito4", "burrito5", "BUS", "buzzard", "Buzzard2", "cablecar", "caddy", "Caddy2", "caddy3", "calico", "CAMPER", "caracara", "caracara2", "carbonizzare", "carbonrs", "Cargobob", "cargobob2", "Cargobob3", "Cargobob4", "cargoplane", "cargoplane2", "casco", "cavalcade", "cavalcade2", "cavalcade3", "cerberus", "cerberus2", "cerberus3", "champion", "cheburek", "cheetah", "cheetah2", "chernobog", "chimera", "chino", "chino2", "cinquemila", "cliffhanger", "clique", "clique2", "club", "coach", "cog55", "cog552", "cogcabrio", "cognoscenti", "cognoscenti2", "comet2", "comet3", "comet4", "comet5", "comet6", "comet7", "conada", "conada2", "contender", "coquette", "coquette2", "coquette3", "coquette4", "corsita", "coureur", "cruiser", "CRUSADER", "cuban800", "cutter", "cyclone", "cypher", "daemon", "daemon2", "deathbike", "deathbike2", "deathbike3", "defiler", "deity", "deluxo", "deveste", "deviant", "diablous", "diablous2", "dilettante", "dilettante2", "Dinghy", "dinghy2", "dinghy3", "dinghy4", "dinghy5", "dloader", "docktrailer", "docktug", "dodo", "Dominator", "dominator2", "dominator3", "dominator4", "dominator5", "dominator6", "dominator7", "dominator8", "dominator9", "dorado", "double", "drafter", "draugur", "drifteuros", "driftfr36", "driftfuto", "driftjester", "driftremus", "drifttampa", "driftyosemite", "driftzr350", "dubsta", "dubsta2", "dubsta3", "dukes", "dukes2", "dukes3", "dump", "dune", "dune2", "dune3", "dune4", "dune5", "duster", "Dynasty", "elegy", "elegy2", "ellie", "emerus", "emperor", "Emperor2", "emperor3", "enduro", "entity2", "entity3", "entityxf", "esskey", "eudora", "Euros", "everon", "everon2", "exemplar", "f620", "faction", "faction2", "faction3", "fagaloa", "faggio", "faggio2", "faggio3", "FBI", "FBI2", "fcr", "fcr2", "felon", "felon2", "feltzer2", "feltzer3", "firetruk", "fixter", "flashgt", "FLATBED", "fmj", "FORKLIFT", "formula", "formula2", "fq2", "fr36", "freecrawler", "freight", "freight2", "freightcar", "freightcar2", "freightcont1", "freightcont2", "freightgrain", "Frogger", "frogger2", "fugitive", "furia", "furoregt", "fusilade", "futo", "futo2", "gargoyle", "Gauntlet", "gauntlet2", "gauntlet3", "gauntlet4", "gauntlet5", "gauntlet6", "gb200", "gburrito", "gburrito2", "glendale", "glendale2", "gp1", "graintrailer", "GRANGER", "granger2", "greenwood", "gresley", "growler", "gt500", "guardian", "habanero", "hakuchou", "hakuchou2", "halftrack", "handler", "Hauler", "Hauler2", "havok", "hellion", "hermes", "hexer", "hotknife", "hotring", "howard", "hunter", "huntley", "hustler", "hydra", "imorgon", "impaler", "impaler2", "impaler3", "impaler4", "impaler5", "impaler6", "imperator", "imperator2", "imperator3", "inductor", "inductor2", "infernus", "infernus2", "ingot", "innovation", "insurgent", "insurgent2", "insurgent3", "intruder", "issi2", "issi3", "issi4", "issi5", "issi6", "issi7", "issi8", "italigtb", "italigtb2", "italigto", "italirsx", "iwagen", "jackal", "jb700", "jb7002", "jester", "jester2", "jester3", "jester4", "jet", "jetmax", "journey", "journey2", "jubilee", "jugular", "kalahari", "kamacho", "kanjo", "kanjosj", "khamelion", "khanjali", "komoda", "kosatka", "krieger", "kuruma", "kuruma2", "l35", "landstalker", "landstalker2", "Lazer", "le7b", "lectro", "lguard", "limo2", "lm87", "locust", "longfin", "lurcher", "luxor", "luxor2", "lynx", "mamba", "mammatus", "manana", "manana2", "manchez", "manchez2", "manchez3", "marquis", "marshall", "massacro", "massacro2", "maverick", "menacer", "MESA", "mesa2", "MESA3", "metrotrain", "michelli", "microlight", "Miljet", "minitank", "minivan", "minivan2", "Mixer", "Mixer2", "mogul", "molotok", "monroe", "monster", "monster3", "monster4", "monster5", "monstrociti", "moonbeam", "moonbeam2", "Mower", "Mule", "Mule2", "Mule3", "mule4", "mule5", "nebula", "nemesis", "neo", "neon", "nero", "nero2", "nightblade", "nightshade", "nightshark", "nimbus", "ninef", "ninef2", "nokota", "Novak", "omnis", "omnisegt", "openwheel1", "openwheel2", "oppressor", "oppressor2", "oracle", "oracle2", "osiris", "outlaw", "Packer", "panthere", "panto", "paradise", "paragon", "paragon2", "pariah", "patriot", "patriot2", "patriot3", "patrolboat", "pbus", "pbus2", "pcj", "penetrator", "penumbra", "penumbra2", "peyote", "peyote2", "peyote3", "pfister811", "Phantom", "phantom2", "phantom3", "Phantom4", "Phoenix", "picador", "pigalle", "polgauntlet", "police", "police2", "police3", "police4", "police5", "policeb", "policeold1", "policeold2", "policet", "polmav", "pony", "pony2", "postlude", "Pounder", "pounder2", "powersurge", "prairie", "pRanger", "Predator", "premier", "previon", "primo", "primo2", "proptrailer", "prototipo", "pyro", "r300", "radi", "raiden", "raiju", "raketrailer", "rallytruck", "RancherXL", "rancherxl2", "RapidGT", "RapidGT2", "rapidgt3", "raptor", "ratbike", "ratel", "ratloader", "ratloader2", "rcbandito", "reaper", "Rebel", "rebel2", "rebla", "reever", "regina", "remus", "Rentalbus", "retinue", "retinue2", "revolter", "rhapsody", "rhinehart", "RHINO", "riata", "RIOT", "riot2", "Ripley", "rocoto", "rogue", "romero", "rrocket", "rt3000", "Rubble", "ruffian", "ruiner", "ruiner2", "ruiner3", "ruiner4", "rumpo", "rumpo2", "rumpo3", "ruston", "s80", "sabregt", "sabregt2", "Sadler", "sadler2", "Sanchez", "sanchez2", "sanctus", "sandking", "sandking2", "savage", "savestra", "sc1", "scarab", "scarab2", "scarab3", "schafter2", "schafter3", "schafter4", "schafter5", "schafter6", "schlagen", "schwarzer", "scorcher", "scramjet", "scrap", "seabreeze", "seashark", "seashark2", "seashark3", "seasparrow", "seasparrow2", "seasparrow3", "Seminole", "seminole2", "sentinel", "sentinel2", "sentinel3", "sentinel4", "serrano", "SEVEN70", "Shamal", "sheava", "SHERIFF", "sheriff2", "shinobi", "shotaro", "skylift", "slamtruck", "slamvan", "slamvan2", "slamvan3", "slamvan4", "slamvan5", "slamvan6", "sm722", "sovereign", "SPECTER", "SPECTER2", "speeder", "speeder2", "speedo", "speedo2", "speedo4", "speedo5", "squaddie", "squalo", "stafford", "stalion", "stalion2", "stanier", "starling", "stinger", "stingergt", "stingertt", "stockade", "stockade3", "stratum", "streamer216", "streiter", "stretch", "strikeforce", "stromberg", "Stryder", "Stunt", "submersible", "submersible2", "Sugoi", "sultan", "sultan2", "sultan3", "sultanrs", "Suntrap", "superd", "supervolito", "supervolito2", "Surano", "SURFER", "Surfer2", "surfer3", "surge", "swift", "swift2", "swinger", "t20", "Taco", "tahoma", "tailgater", "tailgater2", "taipan", "tampa", "tampa2", "tampa3", "tanker", "tanker2", "tankercar", "taxi", "technical", "technical2", "technical3", "tempesta", "tenf", "tenf2", "terbyte", "terminus", "tezeract", "thrax", "thrust", "thruster", "tigon", "TipTruck", "TipTruck2", "titan", "toreador", "torero", "torero2", "tornado", "tornado2", "tornado3", "tornado4", "tornado5", "tornado6", "toro", "toro2", "toros", "TOURBUS", "TOWTRUCK", "Towtruck2", "towtruck3", "towtruck4", "tr2", "tr3", "tr4", "TRACTOR", "tractor2", "tractor3", "trailerlarge", "trailerlogs", "trailers", "trailers2", "trailers3", "trailers4", "trailers5", "trailersmall", "trailersmall2", "Trash", "trash2", "trflat", "tribike", "tribike2", "tribike3", "trophytruck", "trophytruck2", "tropic", "tropic2", "tropos", "tug", "tula", "tulip", "tulip2", "turismo2", "turismo3", "turismor", "tvtrailer", "tvtrailer2", "tyrant", "tyrus", "utillitruck", "utillitruck2", "Utillitruck3", "vacca", "Vader", "vagner", "vagrant", "valkyrie", "valkyrie2", "vamos", "vectre", "velum", "velum2", "verlierer2", "verus", "vestra", "vetir", "veto", "veto2", "vigero", "vigero2", "vigero3", "vigilante", "vindicator", "virgo", "virgo2", "virgo3", "virtue", "viseris", "visione", "vivanite", "volatol", "volatus", "voltic", "voltic2", "voodoo", "voodoo2", "vortex", "vstr", "warrener", "warrener2", "washington", "wastelander", "weevil", "weevil2", "windsor", "windsor2", "winky", "wolfsbane", "xa21", "xls", "xls2", "yosemite", "yosemite2", "yosemite3", "youga", "youga2", "youga3", "youga4", "z190", "zeno", "zentorno", "zhaba", "zion", "zion2", "zion3", "zombiea", "zombieb", "zorrusso", "zr350", "zr380", "zr3802", "zr3803", "Ztype",}
local vehOffsets         = {
                    fc   = 0x001C,
                    ft   = 0x0014,
                    rc   = 0x0020,
                    rt   = 0x0018,
                    cg   = 0x0882,
                    ng   = 0x0880,
                    tg   = 0x0886,
                    vm   = 0x000C,
                    dfm  = 0x0014,
                    accm = 0x004C,
                    cofm = 0x0020,
                    bf   = 0x006C,
                }

local function resettokyodrift()
    DriftTires       = false
    driftMode        = false
    speedBoost       = false
    sfx              = false
    ptfx             = false
    purge_started    = false
    nos_started      = false
    hornLight        = false
    autobrklight     = false
    launchCtrl       = false
    popsNbangs       = false
    nosPurge         = false
    has_xenon        = false
    rgbLights        = false
    loud_radio       = false
    DriftIntensity   = 0
    defaultXenon     = 0
    lightSpeed       = 1
    if nosptfx_t[1] ~= nil then
        for _, n in ipairs(nosptfx_t) do
            if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(n) then
                GRAPHICS.STOP_PARTICLE_FX_LOOPED(n)
                GRAPHICS.REMOVE_PARTICLE_FX(n)
            end
        end
    end
    if purgePtfx_t[1] ~= nil then
        for _, p in ipairs(purgePtfx_t) do
            if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(p) then
                GRAPHICS.STOP_PARTICLE_FX_LOOPED(p)
                GRAPHICS.REMOVE_PARTICLE_FX(p)
            end
        end
    end
    nosptfx_t   = {}
    purgePtfx_t = {}
end

local function filterVehNames()
    filteredNames = {}
    for _, veh in ipairs(gta_vehicles) do
        if VEHICLE.IS_THIS_MODEL_A_CAR(joaat(veh)) or VEHICLE.IS_THIS_MODEL_A_BIKE(joaat(veh)) or VEHICLE.IS_THIS_MODEL_A_QUADBIKE(joaat(veh)) then
            valid_veh = veh
            if string.find(string.lower(valid_veh), string.lower(search_term)) then
                table.insert(filteredNames, valid_veh)
            end
        end
    end
end

local function displayVehNames()
    filterVehNames()
    local vehNames = {}
    for _, veh in ipairs(filteredNames) do
        local vehName = vehicles.get_vehicle_display_name(joaat(veh))
        table.insert(vehNames, vehName)
    end
    vehSound_index, used = ImGui.ListBox("##Vehicle Names", vehSound_index, vehNames, #filteredNames)
end

local function helpmarker(colorFlag, text, color)
    if not disableTooltips then
        ImGui.SameLine()
        ImGui.TextDisabled("(?)")
        if ImGui.IsItemHovered() then
            ImGui.SetNextWindowBgAlpha(0.85)
            ImGui.BeginTooltip()
            if colorFlag == true then
                coloredText(text, color)
            else
                ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
                ImGui.TextWrapped(text)
                ImGui.PopTextWrapPos()
            end
            ImGui.EndTooltip()
        end
    end
end

local function widgetToolTip(colorFlag, text, color)
    if not disableTooltips then
        if ImGui.IsItemHovered() then
            ImGui.SetNextWindowBgAlpha(0.85)
            ImGui.BeginTooltip()
            if colorFlag == true then
                coloredText(text, color)
            else
                ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
                ImGui.TextWrapped(text)
                ImGui.PopTextWrapPos()
            end
            ImGui.EndTooltip()
        end
    end
end

local function resetLastVehState()
    -- placeholder func
end

local function onVehEnter()
    lastVeh         = PLAYER.GET_PLAYERS_LAST_VEHICLE()
    current_vehicle = PED.GET_VEHICLE_PED_IS_USING(self.get_ped())
    lastVehPtr      = memory.handle_to_ptr(lastVeh)
    currentVehPtr   = memory.handle_to_ptr(current_vehicle)
    if current_vehicle ~= lastVeh then
        resetLastVehState()
    end
    return lastVeh, lastVehPtr, current_vehicle, currentVehPtr
end

local function isDriving()
    local retBool
    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
        if VEHICLE.GET_PED_IN_VEHICLE_SEAT(current_vehicle, -1, true) == self.get_ped() then
            retBool = true
        else
            retBool = false
        end
    else
        retBool = false
    end
    return retBool
end

tokyodrift:add_imgui(function()
manufacturer = VEHICLE.GET_MAKE_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(current_vehicle))
mfr_name = (manufacturer:lower():gsub("^%l", string.upper))
vehicle_name = vehicles.get_vehicle_display_name(ENTITY.GET_ENTITY_MODEL(current_vehicle))
    if PED.IS_PED_IN_ANY_VEHICLE(self.get_ped(), true) then
        if validModel then
            ImGui.Text("Vehicle: "..mfr_name.." "..vehicle_name)
            ImGui.Spacing()
            driftMode, _ = ImGui.Checkbox("Activate Drift Mode", driftMode, true)
            helpmarker(false, "This will make your car lose grip. Hold [Left Shift] to drift")
            if driftMode then
                DriftTires = false
                ImGui.Spacing()
                ImGui.Text("Intensity:")
                ImGui.PushItemWidth(250)
                DriftIntensity, _ = ImGui.SliderInt("##Intensity", DriftIntensity, 0, 3)
                widgetToolTip(false, "0: No Grip (very stiff).\n1: Balanced (Recommended).\n2: Weak Drift.\n3: Weakest Drift.")
                ImGui.PopItemWidth()
            end
            DriftTires, _ = ImGui.Checkbox("Equip Drift Tires", DriftTires, true)
            helpmarker(false, "This will equip your car with drift tires whenver you press [Left Shift]. Your tires will be reset when you release the button.")
            if DriftTires then
                driftMode = false
            end
            -- ImGui.Separator();ImGui.Text("¤ Stancer ¤");ImGui.Spacing()
            -- ImGui.Indent()
            -- ImGui.PushItemWidth(180)
            -- ImGui.Text("Front Camber: ");ImGui.SameLine();fCamber, fCamberUsed = ImGui.SliderFloat("##frontcamber", fCamber, -0.50, 0.50)
            -- ImGui.Text("Rear Camber:  ");ImGui.SameLine();rCamber, rCamberUsed = ImGui.SliderFloat("##rearcamber", rCamber, -0.50, 0.50)
            -- ImGui.PopItemWidth()
            -- ImGui.Unindent()
            -- if fCamberUsed then
            --     _, _,_, currentVehPtr = onVehEnter()
            --     currentVehPtr:add(vehOffsets.fc):set_float(fCamber)
            -- end
            -- if rCamberUsed then
            --     _, _,_, currentVehPtr = onVehEnter()
            --     currentVehPtr:add(vehOffsets.rc):set_float(rCamber)
            -- end
            ImGui.Spacing();ImGui.Text("TIP: You can not use both options together.\10Choose one of the two. Experiment and find the\10style that suits you.")
        else
            ImGui.TextWrapped("\10You can only drift cars, trucks and quad bikes.\10\10")
        end

        ImGui.Separator();ImGui.Spacing();launchCtrl, _ = ImGui.Checkbox("Launch Control", launchCtrl, true)
        widgetToolTip(false, "When your vehicle is completely stopped, press and hold [Accelerate] + [Brake] for 3 seconds then let go of the brakes.")

        ImGui.SameLine();ImGui.Dummy(31, 1);ImGui.SameLine();speedBoost, _ = ImGui.Checkbox("NOS", speedBoost, true)
        widgetToolTip(false, "A speed boost that simulates nitrous. Gives you more power and increases your top speed when pressing [Left Shift].")
        if speedBoost then
            -- if not pussyShaver() then
                sfx, ptfx = true, true
                ImGui.SameLine();nosvfx, _ = ImGui.Checkbox("VFX", nosvfx, true)
                widgetToolTip(false, "Activates a visual effect on your screen when using NOS.")
            -- else
                -- gui.show_error("TokyoDrift", "This option doesn't work on sex toys... I mean, electric vehicles.")
                -- speedBoost = false
            -- end
        else
            sfx, ptfx, nosvfx = false, false, false
        end

        loud_radio, used = ImGui.Checkbox("Big Subwoofer", loud_radio, true)
        widgetToolTip(false, "Makes your vehicle's radio sound louder from the outside. To notice the difference, activate this option then stand close to your car while the engine is running and the radio is on.")
        if loud_radio then
            script.run_in_fiber(function()
                AUDIO.SET_VEHICLE_RADIO_LOUD(current_vehicle, true)
            end)
        else
            script.run_in_fiber(function()
                AUDIO.SET_VEHICLE_RADIO_LOUD(current_vehicle, false)
            end)
        end

        ImGui.SameLine();ImGui.Dummy(32, 1);ImGui.SameLine();nosPurge, _ = ImGui.Checkbox("NOS Purge", nosPurge, true)
        widgetToolTip(false, "Press [X] on keyboard or [A] on controller to purge your NOS Fast & Furious style.")

        popsNbangs, _ = ImGui.Checkbox("Pops & Bangs", popsNbangs, true)
        widgetToolTip(false, "Enables exhaust pops whenever you let go of [Accelerate] from high RPM.")

        if popsNbangs then
            ImGui.SameLine();ImGui.Dummy(37, 1);ImGui.SameLine();louderPops, _ = ImGui.Checkbox("Louder Pops", louderPops, true)
            widgetToolTip(false, "Makes your pops & bangs sound extremely loud.")
            if not louderPops then
                popsnd, sndRef = "BOOT_POP", "DLC_VW_BODY_DISPOSAL_SOUNDS"
                flame_size = 0.42069
            else
                popsnd, sndRef = "SNIPER_FIRE", "DLC_BIKER_RESUPPLY_MEET_CONTACT_SOUNDS"
                flame_size = 1.5
            end
        end

        hornLight, _ = ImGui.Checkbox("High Beams on Horn", hornLight, true)
        widgetToolTip(false, "Flash high beams when honking.")

        ImGui.SameLine();autobrklight, _ = ImGui.Checkbox("Auto Brake Lights", autobrklight, true)
        widgetToolTip(false, "Automatically turns on the brake lights when your car is stopped.")

        holdF, _ = ImGui.Checkbox("Keep Engine On", holdF, true)
        widgetToolTip(false, "Brings back GTA IV's vehicle exit: Hold [F] to turn off the engine before exiting the vehicle or press normally to exit and keep it running.")

        ImGui.SameLine();ImGui.Dummy(25, 1);ImGui.SameLine();noJacking, _ = ImGui.Checkbox("Can't Touch This!", noJacking, true)
        widgetToolTip(false, "Prevent NPCs and players from carjacking you.")
        if noJacking then
            script.run_in_fiber(function()
                if not PED.GET_PED_CONFIG_FLAG(self.get_ped(), 398) then
                    PED.SET_PED_CONFIG_FLAG(self.get_ped(), 398, true)
                end
                if PED.GET_PED_CONFIG_FLAG(self.get_ped(), 177) then
                    PED.SET_PED_CONFIG_FLAG(self.get_ped(), 177, true)
                end
            end)
        else
            script.run_in_fiber(function()
                PED.SET_PED_CONFIG_FLAG(self.get_ped(), 177, false)
            end)
        end

        rgbLights, rgbToggled = ImGui.Checkbox("RGB Headlights", rgbLights, true)
        if rgbToggled then
            script.run_in_fiber(function()
                if not VEHICLE.IS_TOGGLE_MOD_ON(current_vehicle, 22) then
                    has_xenon = false
                else
                    has_xenon    = true
                    defaultXenon = VEHICLE.GET_VEHICLE_XENON_LIGHT_COLOR_INDEX(current_vehicle)
                end
            end)
        end
        if rgbLights then
            ImGui.SameLine();
            ImGui.PushItemWidth(120)
            lightSpeed, used = ImGui.SliderInt("RGB Speed", lightSpeed, 1, 3)
            ImGui.PopItemWidth()
        end
        ImGui.Spacing()
        if ImGui.Button("Change Engine Sound") then
            if is_car or is_bike or is_quad then
                open_sounds_window = true
            else
                open_sounds_window = false
                gui.show_error("Tokyo Drift", "This option only works on road vehicles.")
            end
        end
        if open_sounds_window then
            ImGui.SetNextWindowPos(740, 300, ImGuiCond.Appearing)
            ImGui.SetNextWindowSizeConstraints(100, 100, 600, 800)
            ImGui.Begin("Vehicle Sounds",  ImGuiWindowFlags.AlwaysAutoResize | ImGuiWindowFlags.NoTitleBar | ImGuiWindowFlags.NoCollapse)
            if ImGui.Button("Close") then
                open_sounds_window = false
            end
            ImGui.Spacing();ImGui.Spacing()
            ImGui.PushItemWidth(250)
            search_term, used = ImGui.InputTextWithHint("", "Search Vehicle Names", search_term, 32)
            if ImGui.IsItemActive() then
                is_typing = true
            else
                is_typing = false
            end
            ImGui.PushItemWidth(270)
            displayVehNames()
            ImGui.PopItemWidth()
            local selected_name = filteredNames[vehSound_index + 1]
            ImGui.Spacing()
            if ImGui.Button("Use This Sound") then
                script.run_in_fiber(function()
                    AUDIO.FORCE_USE_AUDIO_GAME_OBJECT(current_vehicle, selected_name)
                end)
            end
            ImGui.SameLine()
            if ImGui.Button("Restore Default") then
                script.run_in_fiber(function()
                    AUDIO.FORCE_USE_AUDIO_GAME_OBJECT(current_vehicle, vehicles.get_vehicle_display_name(ENTITY.GET_ENTITY_MODEL(current_vehicle)))
                end)
            end
            ImGui.End()
        end

        ImGui.SameLine();ImGui.Dummy(10, 1);ImGui.SameLine()
        local engineHealth = VEHICLE.GET_VEHICLE_ENGINE_HEALTH(current_vehicle)
        if engineHealth <= 300 then
            engineDestroyed = true
        else
            engineDestroyed = false
        end
        if engineDestroyed then
            engineButton_label = "Fix Engine"
            engine_hp          = 1000
        else
            engineButton_label = "Destroy Engine"
            engine_hp          = -4000
        end
        if ImGui.Button(engineButton_label) then
            script.run_in_fiber(function()
                VEHICLE.SET_VEHICLE_ENGINE_HEALTH(current_vehicle, engine_hp)
            end)
        end
        -- if NETWORK.NETWORK_IS_SESSION_ACTIVE() then
        --     ImGui.SameLine();ImGui.Dummy(40, 1);ImGui.SameLine();nodripfeed, used = ImGui.Checkbox("No Dripfeeding", nodripfeed, true)
        --     if nodripfeed then
        --       globals.set_int(2707347, 1)
        --     end
        -- end
    else
        ImGui.Text("\nPlease get in a vehicle!")
    end

    ImGui.Dummy(1, 20);ImGui.Separator();ImGui.Spacing()
    if ImGui.Button("-- Credits --") then
        ImGui.OpenPopup("Credits")
    end
    ImGui.SetNextWindowPos(760, 400, ImGuiCond.Appearing)
    ImGui.SetNextWindowBgAlpha(0.6)
    if ImGui.BeginPopupModal("Credits", true, ImGuiWindowFlags.AlwaysAutoResize | ImGuiWindowFlags.NoMove) then
        ImGui.Text("¤ Written by SAMURAI (xesdoog).\10¤ Credits to Harmless05 for the drift options [Shift-Drift].")
        ImGui.Text(" - Harmless on GitHub:")
        ImGui.Indent()
        ImGui.TextColored(0.25, 0.65, 0.96, 0.8, "https://github.com/Harmless05")
        widgetToolTip(false, "Click to copy link")
        if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
            ImGui.SetClipboardText("https://github.com/Harmless05")
            gui.show_message("Tokyo Drift", "Copied \"https://github.com/Harmless05\" to clipboard!")
            log.info("Copied \"https://github.com/Harmless05\" to clipboard!")
        end
        ImGui.Unindent()
        ImGui.Text(" - SAMURAI on GitHub:")
        ImGui.Indent()
        ImGui.TextColored(0.25, 0.65, 0.96, 0.8, "https://github.com/xesdoog")
        widgetToolTip(false, "Click to copy link")
        if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
            ImGui.SetClipboardText("https://github.com/xesdoog")
            gui.show_message("Tokyo Drift", "Copied \"https://github.com/xesdoog\" to clipboard!")
            log.info("Copied \"https://github.com/xesdoog\" to clipboard!")
        end
        ImGui.Unindent()
        -- ImGui.Text("Checkout Harmless-Scripts:")
        -- ImGui.BulletText("https://github.com/YimMenu-Lua/Harmless-Scripts")
        -- if ImGui.IsItemHovered() then
        --     ImGui.BeginTooltip()
        --     ImGui.Text("Click to copy link")
        --     ImGui.EndTooltip()
        -- end
        -- if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
        --     ImGui.SetClipboardText("https://github.com/YimMenu-Lua/Harmless-Scripts") <-- Crashes my game for some reason! The profile link is fine but clicking the YimMenu-Lua repo link crashes my game???🤨
        --     gui.show_message("TokyoDrift Credits", "Copied \"https://github.com/YimMenu-Lua/Harmless-Scripts\" to clipboard!")
        -- end
        ImGui.EndPopup()
    end
end)

script.register_looped("game input", function()
    if is_typing then
        PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
    end
    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
        if validModel then
            if nosPurge then
                PAD.DISABLE_CONTROL_ACTION(0, 73, true)
            end
        end
        if speedBoost and PAD.IS_CONTROL_PRESSED(0, 71) then
            if validModel or is_boat or is_bike then
            -- prevent face planting when using NOS mid-air
                PAD.DISABLE_CONTROL_ACTION(0, 60, true)
                PAD.DISABLE_CONTROL_ACTION(0, 61, true)
                PAD.DISABLE_CONTROL_ACTION(0, 62, true)
            end
        end
        if holdF then
            if isDriving() then
                PAD.DISABLE_CONTROL_ACTION(0, 75, true)
            else
                timerB = 0
            end
        end
    end
end)

script.register_looped("TDFT", function(script)
    script:yield()
    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
        _, _, current_vehicle, _ = onVehEnter()
        is_car  = VEHICLE.IS_THIS_MODEL_A_CAR(ENTITY.GET_ENTITY_MODEL(current_vehicle))
        is_quad = VEHICLE.IS_THIS_MODEL_A_QUADBIKE(ENTITY.GET_ENTITY_MODEL(current_vehicle))
        is_bike = VEHICLE.IS_THIS_MODEL_A_BIKE(ENTITY.GET_ENTITY_MODEL(current_vehicle))
        is_boat = VEHICLE.IS_THIS_MODEL_A_BOAT(ENTITY.GET_ENTITY_MODEL(current_vehicle)) or VEHICLE.IS_THIS_MODEL_A_JETSKI(ENTITY.GET_ENTITY_MODEL(current_vehicle))
        if is_car or is_quad then
            validModel = true
        else
            validModel = false
        end
        if validModel and DriftTires and PAD.IS_CONTROL_PRESSED(0, tdBtn) then
            VEHICLE.SET_DRIFT_TYRES(current_vehicle, true)
            VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(current_vehicle, 5.0)
        else
            VEHICLE.SET_DRIFT_TYRES(current_vehicle, false)
            VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(current_vehicle, 1.0)
        end
        script:yield()
        if validModel and driftMode and PAD.IS_CONTROL_PRESSED(0, tdBtn) and not DriftTires then
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(current_vehicle, true)
            VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(current_vehicle, DriftIntensity)
            VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(current_vehicle, 5.0)
        else
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(current_vehicle, false)
            VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(current_vehicle, 1.0)
        end
        if speedBoost then
            if validModel or is_boat or is_bike then
                if VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(current_vehicle) then
                    if PAD.IS_DISABLED_CONTROL_PRESSED(0, tdBtn) and PAD.IS_CONTROL_PRESSED(0, 71) then
                        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(current_vehicle, 5.0)
                        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(current_vehicle, 100.0)
                        using_nos = true
                        if sfx then
                            AUDIO.SET_VEHICLE_BOOST_ACTIVE(current_vehicle, true)
                        else
                            AUDIO.SET_VEHICLE_BOOST_ACTIVE(current_vehicle, false)
                        end
                    end
                else
                    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
                        if PAD.IS_DISABLED_CONTROL_PRESSED(0, tdBtn) and PAD.IS_CONTROL_PRESSED(0, 71) then
                            if VEHICLE.GET_VEHICLE_ENGINE_HEALTH(current_vehicle) < 300 then
                                failSound = AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Engine_fail", current_vehicle, "DLC_PILOT_ENGINE_FAILURE_SOUNDS", true, 0)
                                repeat
                                    script:sleep(50)
                                until
                                    AUDIO.HAS_SOUND_FINISHED(failSound) and PAD.IS_CONTROL_PRESSED(0, tdBtn) == false and PAD.IS_CONTROL_PRESSED(0, 71) == false
                                AUDIO.STOP_SOUND(failSound)
                            end
                        end
                    end
                end
            end
            if using_nos and PAD.IS_DISABLED_CONTROL_RELEASED(0, tdBtn) then
                VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(current_vehicle, 1.0)
                VEHICLE.MODIFY_VEHICLE_TOP_SPEED(current_vehicle, -1)
                AUDIO.SET_VEHICLE_BOOST_ACTIVE(current_vehicle, false)
                using_nos = false
            end
        end
        if hornLight then
            if not VEHICLE.GET_BOTH_VEHICLE_HEADLIGHTS_DAMAGED(current_vehicle) then
                if PAD.IS_CONTROL_PRESSED(0, 86) then
                    VEHICLE.SET_VEHICLE_LIGHTS(current_vehicle, 2)
                    VEHICLE.SET_VEHICLE_FULLBEAM(current_vehicle, true)
                    repeat
                        script:sleep(50)
                    until
                        PAD.IS_CONTROL_PRESSED(0, 86) == false
                    VEHICLE.SET_VEHICLE_FULLBEAM(current_vehicle, false)
                    VEHICLE.SET_VEHICLE_LIGHTS(current_vehicle, 0)
                end
            else
                if PAD.IS_CONTROL_JUST_RELEASED(0, 86) then
                    gui.show_warning("Tokyo Drift", "Your headlights are broken!")
                end
            end
        end
        if holdF then
            if PAD.IS_DISABLED_CONTROL_PRESSED(0, 75) then
                timerB = timerB + 1
                if timerB >= 15 then
                    PED.SET_PED_CONFIG_FLAG(self.get_ped(), 241, false)
                    TASK.TASK_LEAVE_VEHICLE(self.get_ped(), current_vehicle, 0)
                    timerB = 0
                end
            end
            if timerB >= 1 and timerB <= 10 then
                if PAD.IS_DISABLED_CONTROL_RELEASED(0, 75) then
                    PED.SET_PED_CONFIG_FLAG(self.get_ped(), 241, true)
                    TASK.TASK_LEAVE_VEHICLE(self.get_ped(), current_vehicle, 0)
                    timerB = 0
                end
            end
        else
            if PED.GET_PED_CONFIG_FLAG(self.get_ped(), 241, 1) then
                PED.SET_PED_CONFIG_FLAG(self.get_ped(), 241, false)
            end
        end
    else
        current_vehicle = 0
        if started_lct then
            started_lct = false
        end
        if started_popSound then
            started_popSound = false
        end
        if started_popSound2 then
            started_popSound2 = false
        end
    end
end)

script.register_looped("LCTRL", function(lct)
    if isDriving() then
        if launchCtrl then
            local notif_sound, notif_ref
            if NETWORK.NETWORK_IS_SESSION_ACTIVE() then
                notif_sound, notif_ref = "SELL", "GTAO_EXEC_SECUROSERV_COMPUTER_SOUNDS"
            else
                notif_sound, notif_ref = "MP_5_SECOND_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"
            end
            if validModel or is_bike or is_quad then
                if VEHICLE.IS_VEHICLE_STOPPED(current_vehicle) and VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(current_vehicle) and VEHICLE.GET_VEHICLE_ENGINE_HEALTH(current_vehicle) > 300 then
                    if PAD.IS_CONTROL_PRESSED(0, 71) and PAD.IS_CONTROL_PRESSED(0, 72) then
                        started_lct = true
                        ENTITY.FREEZE_ENTITY_POSITION(current_vehicle, true)
                        timerA = timerA + 1
                        if timerA >= 150 then
                            gui.show_success("TokyoDrift", "Launch Control Activated!")
                            AUDIO.PLAY_SOUND_FRONTEND(-1, notif_sound, notif_ref, true)
                            repeat
                                lct:sleep(100)
                            until PAD.IS_CONTROL_RELEASED(0, 72)
                            launch_active = true
                        end
                    elseif started_lct and timerA > 0 and timerA < 150 then
                        if PAD.IS_CONTROL_RELEASED(0, 71) or PAD.IS_CONTROL_RELEASED(0, 72) then
                            timerA = 0
                            ENTITY.FREEZE_ENTITY_POSITION(current_vehicle, false)
                            started_lct = false
                        end
                    end
                end
                if launch_active then
                    if PAD.IS_CONTROL_PRESSED(0, 71) and PAD.IS_CONTROL_RELEASED(0, 72) then
                        PHYSICS.SET_IN_ARENA_MODE(true)
                        VEHICLE.SET_VEHICLE_MAX_LAUNCH_ENGINE_REVS_(current_vehicle, -1)
                        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(current_vehicle, 10)
                        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(current_vehicle, 100.0)
                        ENTITY.FREEZE_ENTITY_POSITION(current_vehicle, false)
                        VEHICLE.SET_VEHICLE_FORWARD_SPEED(current_vehicle, 9.3)
                        lct:sleep(4269)
                        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(current_vehicle, -1)
                        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(current_vehicle, 1.0)
                        VEHICLE.SET_VEHICLE_MAX_LAUNCH_ENGINE_REVS_(current_vehicle, 1.0)
                        PHYSICS.SET_IN_ARENA_MODE(false)
                        launch_active = false
                        timerA = 0
                    end
                end
            end
        end
    else
        lct:yield()
    end
end)

script.register_looped("Auto Brake Lights", function()
    if autobrklight then
        if isDriving() then
            if VEHICLE.IS_VEHICLE_DRIVEABLE(current_vehicle) and VEHICLE.IS_VEHICLE_STOPPED(current_vehicle) and VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(current_vehicle) then
                VEHICLE.SET_VEHICLE_BRAKE_LIGHTS(current_vehicle, true)
            end
        end
    end
end)

script.register_looped("NOS ptfx", function(spbptfx)
    if isDriving() then
        if speedBoost and ptfx then
            if validModel or is_boat or is_bike then
                if PAD.IS_DISABLED_CONTROL_PRESSED(0, tdBtn) and PAD.IS_CONTROL_PRESSED(0, 71) then
                    if VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(current_vehicle) then
                        local effect  = "veh_xs_vehicle_mods"
                        local counter = 0
                        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect) do
                            STREAMING.REQUEST_NAMED_PTFX_ASSET(effect)
                            spbptfx:yield()
                            if counter > 100 then
                                return
                            else
                                counter = counter + 1
                            end
                        end
                        local exhaustCount = VEHICLE.GET_VEHICLE_MAX_EXHAUST_BONE_COUNT_() - 1
                        for i = 0, exhaustCount do
                            local retBool, boneIndex = VEHICLE.GET_VEHICLE_EXHAUST_BONE_(current_vehicle, i, retBool, boneIndex)
                            if retBool then
                                GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
                                nosPtfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("veh_nitrous", current_vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, boneIndex, 1.0, false, false, false, 0, 0, 0)
                                table.insert(nosptfx_t, nosPtfx)
                                if nosvfx then
                                    GRAPHICS.ANIMPOSTFX_PLAY("DragRaceNitrous", 0, false)
                                end
                                nos_started = true
                            end
                        end
                        if nos_started then
                            repeat
                                spbptfx:sleep(50)
                            until
                                PAD.IS_DISABLED_CONTROL_RELEASED(0, tdBtn) or PAD.IS_CONTROL_RELEASED(0, 71)
                            if nosvfx then
                                GRAPHICS.ANIMPOSTFX_PLAY("DragRaceNitrousOut", 0, false)
                            end
                            if GRAPHICS.ANIMPOSTFX_IS_RUNNING("DragRaceNitrous") then
                                GRAPHICS.ANIMPOSTFX_STOP("DragRaceNitrous")
                            end
                            if GRAPHICS.ANIMPOSTFX_IS_RUNNING("DragRaceNitrousOut") then
                                GRAPHICS.ANIMPOSTFX_STOP("DragRaceNitrousOut")
                            end
                            for _, nos in ipairs(nosptfx_t) do
                                if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(nos) then
                                    GRAPHICS.STOP_PARTICLE_FX_LOOPED(nos)
                                    GRAPHICS.REMOVE_PARTICLE_FX(nos)
                                    nos_started = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

script.register_looped("2-step", function(twostep)
    if isDriving then
        if launchCtrl then
            if validModel or is_bike or is_quad then
                if VEHICLE.IS_VEHICLE_STOPPED(current_vehicle) and VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(current_vehicle) and VEHICLE.GET_VEHICLE_ENGINE_HEALTH(current_vehicle) >= 300 then
                    if PAD.IS_CONTROL_PRESSED(0, 71) and PAD.IS_CONTROL_PRESSED(0, 72) then
                        local asset     = "core"
                        local counter   = 0
                        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
                            STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
                            twostep:yield()
                            if counter > 100 then
                                return
                            else
                                counter = counter + 1
                            end
                        end
                        local exhaustCount = VEHICLE.GET_VEHICLE_MAX_EXHAUST_BONE_COUNT_() - 1
                        for i = 0, exhaustCount do
                            local retBool, boneIndex = VEHICLE.GET_VEHICLE_EXHAUST_BONE_(current_vehicle, i, retBool, boneIndex)
                            if retBool then
                                GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
                                lctPtfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("veh_backfire", current_vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, boneIndex, 0.69420, false, false, false, 0, 0, 0)
                                table.insert(lctPtfx_t, lctPtfx)
                                twostep_started = true
                            end
                        end
                        if twostep_started then
                            repeat
                                twostep:sleep(50)
                            until PAD.IS_CONTROL_RELEASED(0, 72) or launch_active == false
                            for _, bfire in ipairs(lctPtfx_t) do
                                if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(bfire) then
                                    GRAPHICS.STOP_PARTICLE_FX_LOOPED(bfire)
                                    GRAPHICS.REMOVE_PARTICLE_FX(bfire)
                                end
                            end
                            twostep_started = false
                        end
                    end
                end
            end
        end
    end
end)

script.register_looped("LCTRL SFX", function(tstp)
    if isDriving() then
        if launchCtrl then
            if lctPtfx_t[1] ~= nil then
                local popSound
                if VEHICLE.IS_VEHICLE_STOPPED(current_vehicle) and PAD.IS_CONTROL_PRESSED(0, 71) and PAD.IS_CONTROL_PRESSED(0, 72) then
                    for _, p in ipairs(lctPtfx_t) do
                        if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(p) then
                            local randStime = math.random(60, 120)
                            popSound = AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "BOOT_POP", current_vehicle, "DLC_VW_BODY_DISPOSAL_SOUNDS", true, 0)
                            AUDIO.SET_AUDIO_SPECIAL_EFFECT_MODE(1)
                            table.insert(popSounds_t, popSound)
                            tstp:sleep(randStime)
                            started_popSound = true
                        end
                    end
                end
                if started_popSound then
                    if PAD.IS_CONTROL_RELEASED(0, 71) or PAD.IS_CONTROL_RELEASED(0, 72) then
                        for _, s in ipairs(popSounds_t) do
                            AUDIO.STOP_SOUND(s)
                        end
                    end
                end
            end
        end

        if popsNbangs then
            if VEHICLE.IS_VEHICLE_STOPPED(current_vehicle) then
                rpmThreshold = 0.45
            else
                rpmThreshold = 0.69
            end
            local currRPM = VEHICLE.GET_VEHICLE_CURRENT_REV_RATIO_(current_vehicle)
            local _, _,_, currentVehPtr = onVehEnter()
            local currGear = currentVehPtr:add(vehOffsets.cg):get_byte()
            if PAD.IS_CONTROL_RELEASED(0, 71) and currRPM < 1.0 and currRPM > rpmThreshold and currGear ~= 0 then
                local popSound2
                local randStime = math.random(60, 200)
                popSound2 = AUDIO.PLAY_SOUND_FROM_ENTITY(-1, popsnd, current_vehicle, sndRef, true, 0)
                table.insert(popSounds_t, popSound2)
                tstp:sleep(randStime)
                started_popSound2 = true
            end
            if started_popSound2 then
                currRPM = VEHICLE.GET_VEHICLE_CURRENT_REV_RATIO_(current_vehicle)
                if PAD.IS_CONTROL_PRESSED(0, 71) or currRPM < rpmThreshold then
                    for _, s in ipairs(popSounds_t) do
                        AUDIO.STOP_SOUND(s)
                    end
                end
            end
        end
    else
        tstp:yield()
    end
end)

script.register_looped("pops&bangs", function(pnb)
    if isDriving() and VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(current_vehicle) then
        if is_car or is_bike or is_quad then
            if popsNbangs then
                local counter = 0
                local asset   = "core"
                local currRPM = VEHICLE.GET_VEHICLE_CURRENT_REV_RATIO_(current_vehicle)
                local _, _,_, currentVehPtr = onVehEnter()
                local currGear = currentVehPtr:add(vehOffsets.cg):get_byte()
                if VEHICLE.IS_VEHICLE_STOPPED(current_vehicle) then
                    rpmThreshold = 0.45
                else
                    rpmThreshold = 0.69
                end
                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
                    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
                    pnb:yield()
                    if counter > 100 then
                        return
                    else
                        counter = counter + 1
                    end
                end
                if PAD.IS_CONTROL_RELEASED(0, 71) and currRPM < 1.0 and currRPM > rpmThreshold and currGear ~= 0 then
                    local exhaustCount = VEHICLE.GET_VEHICLE_MAX_EXHAUST_BONE_COUNT_() - 1
                    for i = 0, exhaustCount do
                        local retBool, boneIndex = VEHICLE.GET_VEHICLE_EXHAUST_BONE_(current_vehicle, i, retBool, boneIndex)
                        if retBool then
                            currRPM = VEHICLE.GET_VEHICLE_CURRENT_REV_RATIO_(current_vehicle)
                            if currRPM < 1.0 and currRPM > 0.55 then
                                GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
                                popsPtfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("veh_backfire", current_vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, boneIndex, flame_size, false, false, false, 0, 0, 0)
                                GRAPHICS.STOP_PARTICLE_FX_LOOPED(popsPtfx)
                                table.insert(popsPtfx_t, popsPtfx)
                                started_popSound2 = true
                            end
                        end
                    end
                end
                if started_popSound2 then
                    currRPM = VEHICLE.GET_VEHICLE_CURRENT_REV_RATIO_(current_vehicle)
                    if PAD.IS_CONTROL_PRESSED(0, 71) or currRPM < rpmThreshold then
                        for _, bfire in ipairs(popsPtfx_t) do
                            if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(bfire) then
                                GRAPHICS.STOP_PARTICLE_FX_LOOPED(bfire)
                                GRAPHICS.REMOVE_PARTICLE_FX(bfire)
                            end
                        end
                        for _, s in ipairs(popSounds_t) do
                            AUDIO.STOP_SOUND(s)
                        end
                    end
                end
            end
        end
    else
        pnb:yield()
    end
end)

script.register_looped("Purge", function(nosprg)
    if isDriving() then
        if nosPurge and validModel or nosPurge and is_bike then
            if PAD.IS_DISABLED_CONTROL_PRESSED(0, 73) then
                local dict       = "core"
                local purgeBones = {"suspension_lf", "suspension_rf"}
                if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(dict) then
                    STREAMING.REQUEST_NAMED_PTFX_ASSET(dict)
                    coroutine.yield()
                end
                for _, boneName in ipairs(purgeBones) do
                    local purge_exit = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(current_vehicle, boneName)
                    if boneName == "suspension_lf" then
                        rotZ = -180.0
                        posX = -0.3
                    else
                        rotZ = 0.0
                        posX = 0.3
                    end
                    GRAPHICS.USE_PARTICLE_FX_ASSET(dict)
                    purgePtfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("weap_extinguisher", current_vehicle, posX, -0.33, 0.2, 0.0, -17.5, rotZ, purge_exit, 0.4, false, false, false, 0, 0, 0)
                    table.insert(purgePtfx_t, purgePtfx)
                    purge_started = true
                end
                if purge_started then
                    repeat
                        nosprg:sleep(50)
                    until
                        PAD.IS_DISABLED_CONTROL_RELEASED(0, 73)
                    for _, purge in ipairs(purgePtfx_t) do
                        if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(purge) then
                            GRAPHICS.STOP_PARTICLE_FX_LOOPED(purge)
                            GRAPHICS.REMOVE_PARTICLE_FX(purge)
                            purge_started = false
                        end
                    end
                end
            end
        end
    else
        nosprg:yield()
    end
end)

script.register_looped("rgbheadlights", function(rgb)
    if rgbLights then
        for i = 0, 14 do
            if rgbLights and not VEHICLE.GET_BOTH_VEHICLE_HEADLIGHTS_DAMAGED(current_vehicle) then
                if not has_xenon then
                    VEHICLE.TOGGLE_VEHICLE_MOD(current_vehicle, 22, true)
                end
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.9)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.8)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.7)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.6)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.5)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(current_vehicle, i)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.4)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.3)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.2)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.1)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(current_vehicle, i)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.2)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.3)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.4)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.5)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(current_vehicle, i)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.6)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.7)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.8)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 0.9)
                rgb:sleep(100 / lightSpeed)
                VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 1.0)
                VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(current_vehicle, i)
                rgb:sleep(100 / lightSpeed)
            else
                if has_xenon then
                    VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 1.0)
                    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(current_vehicle, defaultXenon)
                    break
                else
                    VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(current_vehicle, 1.0)
                    VEHICLE.TOGGLE_VEHICLE_MOD(current_vehicle, 22, false)
                    break
                end
            end
        end
    else
        rgb:yield()
    end
end)


event.register_handler(menu_event.MenuUnloaded, function()
    resettokyodrift()
end)
event.register_handler(menu_event.ScriptsReloaded, function()
    resettokyodrift()
end)
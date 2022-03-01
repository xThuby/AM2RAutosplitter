state("AM2R", "v1.5+")
{
    uint room : "AM2R.exe", 0x5CB860;
    double metroids : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x400, 0x0;
    double facing : "AM2R.exe", 0x003C9434, 0x110, 0xAC, 0x8, 0x34, 0x10, 0x8BC, 0x0;
    double timeOfDay : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x8, 0xA0;

    double bombs : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0x0;
    double spider : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0x20;
    double spring : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0x30;
    double highJump : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0x40;
    double varia : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0x50;
    double spaceJump : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0x60;
    double speedBooster : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0x70;
    double screwAttack : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0x80;
    double gravity : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0x90;
    double charge : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0xA0;
    double ice : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0xB0;
    double wave : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0xC0;
    double spazer : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0xD0;
    double plasma : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x22C, 0x0, 0x4, 0x4, 0xE0;
}
//double gamestart : "AM2R.exe", 0x003BD168, 0x0, 0x34, 0x10, 0x19C, 0x0;

init
{
    vars.completedSplits = new Dictionary<string, bool>();
    vars.completedSplits.Add( "goldenTemple", false );
    vars.completedSplits.Add( "hydroStation", false );
    vars.completedSplits.Add( "industrialComplex", false );
    vars.completedSplits.Add( "area35", false );
    vars.completedSplits.Add( "tower", false );
    vars.completedSplits.Add( "area5", false );
    vars.completedSplits.Add( "firstOmega", false );
    vars.completedSplits.Add( "omegaNest", false );
    vars.completedSplits.Add( "lab", false );
    vars.completedSplits.Add( "queen", false );
}

startup
{
    settings.Add("goldenTemple", true, "Golden Temple");
    settings.Add("hydroStation", true, "Hydro Station");
    settings.Add("industrialComplex", true, "Industrial Complex");
    settings.Add("area35", true, "Area 3.5");
    settings.Add("tower", true, "Tower");
    settings.Add("area5", true, "Distribution Center");
    settings.Add("firstOmega", true, "First Omega");
    settings.Add("omegaNest", true, "Omega Nest");
    settings.Add("lab", true, "Genetics Lab");
    settings.Add("queen", true, "Queen");

    settings.Add("majors", false, "Major Items");
    settings.CurrentDefaultParent = "majors";
    settings.Add("bombs", false, "Bombs");
    settings.Add("spider", false, "Spider Ball");
    settings.Add("spring", false, "Spring Ball");
    settings.Add("highJump", false, "High Jump");
    settings.Add("varia", false, "Varia Suit");
    settings.Add("spaceJump", false, "Space Jump");
    settings.Add("speedBooster", false, "Speed Booster");
    settings.Add("screwAttack", false, "Screw Attack");
    settings.Add("gravity", false, "Gravity Suit");
    settings.Add("charge", false, "Charge Beam");
    settings.Add("ice", false, "Ice Beam");
    settings.Add("wave", false, "Wave Beam");
    settings.Add("spazer", false, "Spazer");
    settings.Add("plasma", false, "Plasma Beam");
}

start
{
    if (old.room != current.room && current.room == 17 && old.room == 1)
    {
        return true;
    }
}

update
{
}

// Splits happen on room transitions between specific rooms, and when
// a specific amount of metroids are remaining
// Golden Temple - 42 metroids. Room 55 -> 35
// Hydro Station - 34 metroids. Room 82 -> 33
// Industrial Complex - 31 metroids. Room 131 -> 130
// Area 3.5 - 20 metroids. Room 179 -> 178
// The Tower - 14 metroids. Room 186 -> 49
// Area 5 - 6 metroids. Room 238 -> 50
// First Omega - 4 metroids. Room 314 -> 313
// Omega Nest - 1 metroids. Room 335 -> 337
// Lab - 1 metroids. Room 367 -> 368
// Queen - 0 metroids. Room 368 -> 369
// Finished - 0 metroids. First frame of samus entering her ship

split
{

    // Only check on room transitions
    if (old.room != current.room && current.room == 17)
    {
        // Golden temple
        if (current.metroids == 42 && !vars.completedSplits["goldenTemple"] && old.room == 55 && settings["goldenTemple"])
        {
            vars.completedSplits["goldenTemple"] = true;
            return true;
        }

        // Hydro station
        if (current.metroids == 34 && !vars.completedSplits["hydroStation"] && old.room == 82 && settings["hydroStation"])
        {
            vars.completedSplits["hydroStation"] = true;
            return true;
        }

        // Industrial complex
        if (current.metroids == 31 && !vars.completedSplits["industrialComplex"] && old.room == 131 && settings["industrialComplex"])
        {
            vars.completedSplits["industrialComplex"] = true;
            return true;
        }

        // Area 3.5
        if (current.metroids == 20 && !vars.completedSplits["area35"] && old.room == 179 && settings["area35"])
        {
            vars.completedSplits["area35"] = true;
            return true;
        }

        // The Tower
        if (current.metroids == 14 && !vars.completedSplits["tower"] && old.room == 186 && settings["tower"])
        {
            vars.completedSplits["tower"] = true;
            return true;
        }

        // Area 5
        if (current.metroids == 6 && !vars.completedSplits["area5"] && old.room == 238 && settings["area5"])
        {
            vars.completedSplits["area5"] = true;
            return true;
        }

        // First Omega
        if (current.metroids == 4 && !vars.completedSplits["firstOmega"] && old.room == 314 && settings["firstOmega"])
        {
            vars.completedSplits["firstOmega"] = true;
            return true;
        }

        // Omega Nest
        if (current.metroids == 1 && !vars.completedSplits["omegaNest"] && old.room == 335 && settings["omegaNest"])
        {
            vars.completedSplits["omegaNest"] = true;
            return true;
        }

        // Lab
        if (current.metroids == 1 && !vars.completedSplits["lab"] && old.room == 367 && settings["lab"])
        {
            vars.completedSplits["lab"] = true;
            return true;
        }

        // Queen
        if (current.metroids == 0 && !vars.completedSplits["queen"] && old.room == 368 && settings["queen"])
        {
            vars.completedSplits["queen"] = true;
            return true;
        }
    }

    var bombs = current.bombs == 1 && old.bombs == 0 && settings["bombs"];
    var spider = current.spider == 1 && old.spider == 0 && settings["spider"];
    var spring = current.spring == 1 && old.spring == 0 && settings["spring"];
    var highJump = current.highJump == 1 && old.highJump == 0 && settings["highJump"];
    var varia = current.varia == 1 && old.varia == 0 && settings["varia"];
    var spaceJump = current.spaceJump == 1 && old.spaceJump == 0 && settings["spaceJump"];
    var speedBooster = current.speedBooster == 1 && old.speedBooster == 0 && settings["speedBooster"];
    var screwAttack = current.screwAttack == 1 && old.screwAttack == 0 && settings["screwAttack"];
    var gravity = current.gravity == 1 && old.gravity == 0 && settings["gravity"];
    var charge = current.charge == 1 && old.charge == 0 && settings["charge"];
    var ice = current.ice == 1 && old.ice == 0 && settings["ice"];
    var wave = current.wave == 1 && old.wave == 0 && settings["wave"];
    var spazer = current.spazer == 1 && old.spazer == 0 && settings["spazer"];
    var plasma = current.plasma == 1 && old.plasma == 0 && settings["plasma"];
    return bombs || spider || spring || highJump || varia || spaceJump || speedBooster || screwAttack || gravity || charge || ice || wave || spazer || plasma;

    if (current.timeOfDay == 2 && current.facing == 0 && old.facing != 0) 
    {
        return true;
    }
}

reset
{
    if (current.room == 1)
    {
        // Kinda dumb, but we reset this here.
        vars.completedSplits = new Dictionary<string, bool>();
        vars.completedSplits.Add( "goldenTemple", false );
        vars.completedSplits.Add( "hydroStation", false );
        vars.completedSplits.Add( "industrialComplex", false );
        vars.completedSplits.Add( "area35", false );
        vars.completedSplits.Add( "tower", false );
        vars.completedSplits.Add( "area5", false );
        vars.completedSplits.Add( "firstOmega", false );
        vars.completedSplits.Add( "omegaNest", false );
        vars.completedSplits.Add( "lab", false );
        vars.completedSplits.Add( "queen", false );

        return true;
    }
}

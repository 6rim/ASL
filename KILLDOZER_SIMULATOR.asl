// KILLDOZER SIMULATOR AUTOSPLITTER
// v1.0 11/11/26
// Made by 6rim

state("killdozer_demo")
{
    int pauseTime : 0x5D310A0, 0x248, 0x10, 0x60, 0x28, 0x140;
    int room : 0x5D34CC4;
    int grudge : 0x05CE6E40, 0xA0, 0x38, 0x18, 0x1F8, 0x110;
    float position : 0x05D3AEC0, 0x9B8, 0x18, 0x388, 0x1F8, 0x3C; 
}

init
{
	vars.startCheck = 0;
}

update
{
    if (current.room == 1)
    {
        vars.startCheck = 1;
    } else
    if (current.room == 3)
    {
        if (current.position >= 148) {vars.startCheck = 0;}
    }
}

startup
{
    settings.Add("loadRemoval", true, "Load Removal");
    settings.SetToolTip("loadRemoval", "Enables Load Removal.");
}

start
{
    if (vars.startCheck == 0 && current.pauseTime == 0 && current.room == 3 && current.position < 148)
    {
        return true;
    }
}

split
{
    if (current.grudge != old.grudge && current.room == 3)
    {
        return true;
    }

    if (current.grudge == 10 && old.room == 3 && current.room == 1)
    {
        return true;
    }
}

reset
{
    if (current.grudge != 10 && current.room == 1)
    {
        vars.startCheck = 0;
        return true;
    }
}


isLoading
{
    if (settings["loadRemoval"] && current.pauseTime == 1)
    {
	    return true;
    }
    else
    {
        return false;
    }
}

onReset
{
    vars.startCheck = 0;
}

exit
{

}

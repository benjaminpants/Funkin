//dont edit this. please. like. THIS SCRIPT IS FOR INTERNAL USE BY THE ENGINE.
//THIS SCRIPT IS FOR INTERNAL USE BY THE ENGINE.
//THIS SCRIPT IS FOR INTERNAL USE BY THE ENGINE.
//THIS SCRIPT IS FOR INTERNAL USE BY THE ENGINE.
//THIS SCRIPT IS FOR INTERNAL USE BY THE ENGINE.

function create(instance)
{
	//do nothing
}

function update(instance, elapsed)
{
}

function initializeVisuals(instance)
{
	if (!instance.InPlayState)
	{
		instance.initVisualsSprite("NOTE_assets_hurt");
	}
	instance.alphaMult = 0; //disappear forever
	return false;
}

function onHit(instance)
{
	return false; //no
}

function onMiss(instance)
{
	return false; //no
}

function calculateScrollSpeed(instance,scrollSpeed)
{
	return scrollSpeed; //no tomfoolry
}

function shouldOpponentHit(instance)
{
	return true; //yes the opponent should hit these
}

function onOpponentHit(instance)
{
	instance.runEvent();
	return false; //cancel this to play different animations or whatever
}
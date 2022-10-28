//these create and update functions are for the NOTE not the playstate like most other scripts..

function create(instance)
{
	//do nothing
}

function update(instance, elapsed)
{
}

function initializeVisuals(instance)
{
	//we dont override visuals.
	return true;
}

function onHit(instance)
{
	return true; //allow the original function to run
}

function onMiss(instance)
{
	return true; //allow the original function to run
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
	return true; //cancel this to play different animations or whatever
}
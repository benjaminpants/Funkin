function beatHit()
{
	if (CurState.curBeat % 16 == 15 && CurState.dad.curCharacter == 'gf' && CurState.curBeat > 16 && CurState.curBeat < 48)
	{
		CurState.boyfriend.playAnim('hey', true);
		CurState.dad.playAnim('cheer', true);
	}
}
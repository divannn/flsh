/*
The nuke does one thing: fires a damageAll() method from the EnemyShip class which affects every baddie on stage

*/

package
{

	public class Nuke 
	{
		public function Nuke()
		{
			EnemyShip.damageAll();
		}
	}
}
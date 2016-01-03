package util;

class IsometricPoint
{
    @:isVar public var x(get, set):Float;
    @:isVar public var y(get, set):Float;
    @:isVar public var z(get, set):Float;

    public function new( x:Float = 0, y:Float = 0, z:Float = 0 )
    {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public static function convertNormalCoordinateToIsometric( x:Float = 0, y:Float = 0, z:Float = 0 ):IsometricPoint
    {
        var result:IsometricPoint = new IsometricPoint();

        var distance:Float = Math.sqrt( Math.pow( x, 2 ) + Math.pow( y, 2 ) );
        var baseAngle:Float = Math.atan2( y, x );

        result.x = distance * Math.cos( baseAngle - Math.PI / 4 );
        result.y = distance * Math.sin( baseAngle - Math.PI / 4 );
        result.z = z;

        return result;
    }

    public function set_x( value:Float ):Float
    {
        this.x = value;

        return this.x;
    }

    public function get_x():Float
    {
        return this.x;
    }

    public function set_y( value:Float ):Float
    {
        this.y = value + this.z;

        return this.y;
    }

    public function get_y():Float
    {
        return this.y - this.z;
    }

    public function set_z( value:Float ):Float
    {
        this.z = value;

        return this.z;
    }

    public function get_z():Float
    {
        return this.z;
    }
}
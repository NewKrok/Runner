package world;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.Sprite;

import util.IsometricPoint;

class Block extends Sprite
{
    public static var SIZE:Int = 55;
    public static var HEIGHT:Int = 27;

    @:isVar public var z(get, set):Float;

    private var graphic:Bitmap;

    private var _isometricPoint:IsometricPoint;

    public function new( isometricPoint:IsometricPoint )
    {
        super( );

        this._isometricPoint = isometricPoint;

        var blockBitmapData:BitmapData = Assets.getBitmapData( 'assets/cube.png' );
        this.graphic = new Bitmap( blockBitmapData );
        this.addChild( this.graphic );
    }

    override public function set_x( value:Float ):Float
    {
        this._isometricPoint.x = value;

        return this._isometricPoint.x;
    }

    override public function get_x():Float
    {
        return this._isometricPoint.x;
    }

    override public function set_y( value:Float ):Float
    {
        this._isometricPoint.y = value;

        return this._isometricPoint.y;
    }

    override public function get_y():Float
    {
        return this._isometricPoint.y;
    }

    public function set_z( value:Float ):Float
    {
        this._isometricPoint.z = value;

        return this._isometricPoint.z;
    }

    public function get_z():Float
    {
        return this._isometricPoint.z;
    }

    private function updateNormalCoordinates( ):Void
    {
        super.x = this._isometricPoint.x;
        super.y = this._isometricPoint.y;
    }

    public function draw():Void
    {
        this.updateNormalCoordinates();
    }

    public function dispose( ):Void
    {
        this.graphic.bitmapData.dispose( );
        this.graphic = null;
    }
}
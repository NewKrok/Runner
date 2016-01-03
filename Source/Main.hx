package;

import motion.Actuate;
import motion.easing.Linear;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import openfl.geom.Point;
import openfl.display.Sprite;
import world.Block;
import util.IsometricPoint;

class Main extends Sprite
{
    private var _blockMap:Array<Array<Int>> = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    ];

    private var _blocks:Array<Block> = [];

    private var _timer:Timer;

    private var tempXIndex:Int = 0;
    private var xMin:Int = 0;
    private var xMax:Int = 0;
    private var xDirection:Int = 1;
    private var tempYIndex:Int = 0;
    private var yMin:Int = 0;
    private var yMax:Int = 0;
    private var yDirection:Int = 0;
    private var tempZIndex:Int = 0;

    public function new( )
    {
        super( );

        //initBlockMap( );
        //orderBlockMap( );

        xMax = _blockMap.length - 1;
        yMax = _blockMap[0].length - 1;

        var countOfBlocks:Int = _blockMap.length * _blockMap[0].length - 1;

        _timer = new Timer( 100, countOfBlocks );
        _timer.addEventListener( TimerEvent.TIMER, onTick );
        _timer.start( );

        buildPyramid();
    }

    private function onTick( e:TimerEvent ):Void
    {
        //createView();

        buildPyramid();
    }

    private function buildPyramid():Void
    {
        addBlock( tempXIndex * Block.SIZE, 550 + tempYIndex * Block.SIZE, tempZIndex * Block.HEIGHT );

        if ( xDirection == 1 )
        {
            tempXIndex++;
            if ( tempXIndex == xMax )
            {
                xDirection = 0;
                yDirection = 1;
                xMax--;
            }
        }
        else if ( yDirection == 1 )
        {
            tempYIndex++;
            if ( tempYIndex == yMax )
            {
                xDirection = -1;
                yDirection = 0;
                yMax--;
            }
        }
        else if ( xDirection == -1 )
        {
            tempXIndex--;
            if ( tempXIndex == xMin )
            {
                xDirection = 0;
                yDirection = -1;
                xMin++;
            }
        }
        else if ( yDirection == -1 )
        {
            tempYIndex--;
            if ( tempYIndex == yMin )
            {
                xDirection = 1;
                yDirection = 0;
                yMin++;
                tempZIndex++;
                tempXIndex = xMin;
                tempYIndex = yMin;
            }
        }
        orderBlockMap( );
    }

    private function createView():Void
    {
        clearLastMap( );
        createRandomMap( );
        initBlockMap( );
        orderBlockMap( );
    }

    private function clearLastMap():Void
    {
        var i:Int = 0;
        for( i in 0..._blocks.length )
        {
            removeChild( _blocks[i] );
            _blocks[i].dispose();
            _blocks[i] = null;
        }

        _blocks = [];
    }

    private function createRandomMap( ):Void
    {
        var i:Int = 0;
        for( i in 0..._blockMap.length )
        {
            var j:Int = 0;
            for( j in 0..._blockMap[i].length )
            {
                _blockMap[i][j] = Math.floor( Math.random() * 5 ) - 2;
            }
        }
    }

    private function initBlockMap( ):Void
    {
        var row:Int = _blockMap.length;
        var col:Int = _blockMap[0].length;

        var i:Int = 0;
        for( i in 0..._blockMap.length )
        {
            var j:Int = 0;
            for( j in 0..._blockMap[i].length )
            {
                if ( _blockMap[i][j] != 0 )
                {
                    addBlock( i * Block.SIZE, j * Block.SIZE, _blockMap[i][j] * Block.HEIGHT );
                }
            }
        }
    }

    private function addBlock( x:Int, y:Int, z:Int ):Void
    {
        var position:IsometricPoint = IsometricPoint.convertNormalCoordinateToIsometric( x, y, z );
        position.z += 300;

        var block:Block = new Block( position );

        Actuate.tween( block, .5, { z: position.z - 300 } ).onUpdate( orderBlockMap ).ease( Linear.easeNone );

        addChild( block );
        _blocks.push( block );
    }

    private function orderBlockMap( ):Void
    {
        _blocks.sort( orderByIsometricCoordinates );

        for( i in 0..._blocks.length )
        {
            addChild( _blocks[i] );
            _blocks[i].draw();
        }
    }

    function orderByIsometricCoordinates( a:Block, b:Block ):Int
    {
        if( a.y + a.z > b.y + b.z )
        {
            return 1;
        }
        else if( a.y + a.z < b.y + b.z )
        {
            return -1;
        }
        else
        {
            return 0;
        }
    }
}
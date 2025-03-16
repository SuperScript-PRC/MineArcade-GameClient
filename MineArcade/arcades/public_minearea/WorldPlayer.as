package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.ui.Keyboard;
    import MineArcade.fixer.EventContext;
    import MineArcade.mcs_getter.StageMC;
    import flash.events.Event;
    import flash.events.KeyboardEvent;

    public class WorldPlayer extends MovieClip {
        public var playername:String;
        public var x_speed:Number = 0;
        public var y_speed:Number = 0;
        public var is_cli_player:Boolean;
        private var walk_a:Number = 0;
        private var map:MineAreaMap;

        public function WorldPlayer(playername:String, is_cli_player:Boolean, map:MineAreaMap) {
            super();
            this.map = map
            this.playername = playername
            this.is_cli_player = is_cli_player
            this._TempDraw()
            EventContext.Create(this, StageMC.root, KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void {
                if (e.keyCode == Keyboard.LEFT)
                    walk_a = -0.2
                else if (e.keyCode == Keyboard.RIGHT)
                    walk_a = 0.2
                else if (e.keyCode == Keyboard.SPACE)
                    Jump()
            })
            EventContext.Create(this, StageMC.root, KeyboardEvent.KEY_UP, function(e:KeyboardEvent):void {
                if (e.keyCode == Keyboard.LEFT)
                    walk_a = 0
                else if (e.keyCode == Keyboard.RIGHT)
                    walk_a = 0
            })
            if (this.is_cli_player) {
                // 其他玩家的移动只依赖服务器传输来的 Actor
                EventContext.Create(this, StageMC.root, Event.ENTER_FRAME, function(e:Event):void {
                    ExecuteMove()
                })
            }
        }

        private function _TempDraw():void {
            this.graphics.beginFill(0x00FF00)
            this.graphics.drawRect(0, 0, 25, 64)
            this.graphics.endFill()
        }

        private function Jump():void {
            if (this.getHit().down)
                this.y_speed = -10
        }

        public function ExecuteMove():void {
            if (this.walk_a > 0)
                this.x_speed = Math.min(this.x_speed + walk_a, 4)
            else
                this.x_speed = Math.max(this.x_speed + walk_a, -4)
            this.y_speed += map.G
            this.MoveOneTime(x_speed, y_speed)
            this.walk_a = 0;
        }

        private function getHit():Object {
            const left_x:Number = this.x
            const upper_y:Number = this.y
            const right_x:Number = this.x + this.width
            const lower_y:Number = this.y + this.height
            var left:Boolean = false;
            var right:Boolean = false;
            var up:Boolean = false;
            var down:Boolean = false;
            for (var chunk:Chunk in this.map.chunks) {
                if (this.hitTestObject(chunk)) {
                    var chunk_x:Number = chunk.x
                    var chunk_y:Number = chunk.y
                    for (var block:MineBlock in chunk.blocks) {
                        if (block.id == 0)
                            continue;
                        var block_left_x:Number = chunk_x + block.x
                        var block_upper_y:Number = chunk_y + block.y
                        var block_right_x:Number = block_left_x + BLOCK_SIZE
                        var block_lower_y:Number = block_upper_y + BLOCK_SIZE
                        if ((block_upper_y > upper_y && block_upper_y < lower_y) || (block_lower_y > upper_y && block_lower_y < lower_y)) {
                            if (this.x_speed > 0 && right_x + 2 >= block_left_x)
                                right = true;
                            else if (this.x_speed < 0 && left_x - 2 <= block_right_x)
                                left = true;
                        }
                        if ((block_left_x > left_x && block_left_x < right_x) || (block_right_x > left_x && block_right_x < right_x)) {
                            if (this.y_speed > 0 && lower_y + 2 >= block_upper_y) {
                                down = true;
                            } else if (this.y_speed < 0 && upper_y - 2 <= block_lower_y)
                                up = true;
                        }
                    }
                }
            }
            return {left: left, right: right, up: up, down: down}
        }

        private function MoveOneTime(x:int, y:int):void {
            var step_x:Number = this.x_speed
            var step_y:Number = this.y_speed
            while (step_x != 0 || step_y != 0) {
                var hit:Object = this.getHit()
                if ((hit.left && this.x_speed < 0) || (hit.right && this.x_speed > 0)) {
                    this.x_speed = 0
                    step_x = 0
                }
                if ((hit.up && this.y_speed < 0) || (hit.down && this.y_speed > 0)) {
                    this.y_speed = 0
                    step_y = 0
                }
                if (hit.down && this.x_speed != 0) {
                    this.x_speed *= 0.8;
                    if (Math.abs(this.x_speed) < 0.1)
                        this.x_speed = 0
                }
                var change_x:Number, change_y:Number
                if (this.x_speed < 0) {
                    change_x = Math.max(-1, step_x)
                } else {
                    change_x = Math.min(1, step_x)
                }
                if (this.y_speed < 0) {
                    change_y = Math.max(-1, step_y)
                } else {
                    change_y = Math.min(1, step_y)
                }
                this.x += change_x
                this.y += change_y
                step_x -= change_x
                step_y -= change_y
            }
        }
    }
}

const BLOCK_SIZE:Number = 32

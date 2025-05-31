package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.ui.Keyboard;
    import MineArcade.fixer.EventContext;
    import MineArcade.mcs_getter.StageMC;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import MineArcade.protocol.PacketWriter;
    import MineArcade.core.Main;
    import MineArcade.fixer.IntervalContext;
    import MineArcade.protocol.packets.arcade.public_minearea.PublicMineareaPlayerActorData;

    public class WorldPlayer extends MovieClip {
        private var map:MineAreaMap;
        public var playername:String;
        public var uuid:String
        public var x_speed:Number = 0;
        public var y_speed:Number = 0;
        public var is_cli_player:Boolean;
        public var dig_speed: Number = 1;
        private var walk_a:Number = 0;
        private var is_jump:Boolean = false;

        public function WorldPlayer(playername:String, uuid:String, is_cli_player:Boolean, map:MineAreaMap) {
            super();
            this.playername = playername
            this.uuid = uuid
            this.is_cli_player = is_cli_player
            this.map = map
            var pk_sender:PacketWriter = Main.GCore.getPacketWriter()
            this._TempDraw()
            if (this.is_cli_player) {
                // 其他玩家的移动只依赖服务器传输来的 Actor
                EventContext.Create(this, StageMC.stage, KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void {
                    if (e.keyCode == Keyboard.A)
                        walk_a = -0.4
                    else if (e.keyCode == Keyboard.D)
                        walk_a = 0.4
                    else if (e.keyCode == Keyboard.SPACE) {
                        if (!is_jump)
                            Jump()
                        is_jump = true
                    }
                })
                EventContext.Create(this, StageMC.stage, KeyboardEvent.KEY_UP, function(e:KeyboardEvent):void {
                    if (e.keyCode == Keyboard.A)
                        walk_a = 0
                    else if (e.keyCode == Keyboard.D)
                        walk_a = 0
                    else if (e.keyCode == Keyboard.SPACE)
                        is_jump = false
                })
                EventContext.Create(this, this, Event.ENTER_FRAME, function(e:Event):void {
                    ExecuteMove()
                    map.MapMoveRelative()
                })
                IntervalContext.Create(this, this.uploadActor, 100)
                    // IntervalContext.Create(this, function():void {
                    //     trace("x=" + x + ", y=" + y + ", xspeed=" + x_speed + ", yspeed=" + y_speed)
                    // }, 100)
            }
        }

        public function UpdateFromPacket(pk:PublicMineareaPlayerActorData):void {
            // TODO: Action 没有被利用
            this.x = pk.X * BLOCK_SIZE
            this.y = (MAP_BORDER_Y - pk.Y * BLOCK_SIZE)
            this.map.MapMoveRelative()
        }

        private function _TempDraw():void {
            this.graphics.beginFill(0x00FF00)
            this.graphics.drawRect(0, 0, 25, 60)
            this.graphics.endFill()
        }

        private function Jump():void {
            if (this.getHit().down) {
                this.y_speed = -10
            } else {
            }
        }

        public function ExecuteMove():void {
            if (this.walk_a > 0)
                this.x_speed = Math.min(this.x_speed + walk_a, 5)
            else if (this.walk_a < 0)
                this.x_speed = Math.max(this.x_speed + walk_a, -5)
            this.y_speed = Math.min(this.y_speed + this.map.G, 10)
            this.MoveOneTime(x_speed, y_speed)
        }

        private function uploadActor():void {
            Main.GCore.getPacketWriter().WritePacket(new PublicMineareaPlayerActorData("", this.uuid, this.x / 32, (MAP_BORDER_Y - this.y) / 32))
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
            for each (var chunk:Chunk in this.map.chunks) {
                if (chunk == null)
                    continue
                if (this.hitTestObject(chunk)) {
                    var chunk_x:Number = chunk.x
                    var chunk_y:Number = chunk.y
                    for each (var block:MineBlock in chunk.blocks) {
                        if (block.is_hidden)
                            continue;
                        var block_left_x:Number = chunk_x + block.x
                        var block_upper_y:Number = chunk_y + block.y
                        var block_right_x:Number = block_left_x + BLOCK_SIZE
                        var block_lower_y:Number = block_upper_y + BLOCK_SIZE
                        if ( //
                            (block_upper_y > upper_y && block_upper_y < lower_y) || //
                            (block_lower_y > upper_y && block_lower_y < lower_y) || //
                            (block_upper_y < lower_y && block_lower_y > upper_y) //
                            )
                            if (right_x + 1 > block_left_x && right_x - 1 < block_right_x)

                                right = true;
                            else if (left_x - 1 < block_right_x && left_x + 1 > block_left_x)
                                left = true;
                        if ( //
                            (block_left_x > left_x && block_left_x < right_x) || //
                            (block_right_x > left_x && block_right_x < right_x) || //
                            (block_left_x < right_x && block_right_x > left_x) //
                            )
                            if (lower_y + 1 > block_upper_y && lower_y - 1 < block_lower_y) {
                                down = true;
                            } else if (upper_y - 1 < block_lower_y && upper_y + 1 > block_upper_y)
                                up = true;
                    }
                }
            }
            return {left: left, right: right, up: up, down: down}
        }

        private function MoveOneTime(x:int, y:int):void {
            // 存在极大的卡顿问题
            var step_x:Number = this.x_speed
            var step_y:Number = this.y_speed
            var hit:Object;
            while (step_x != 0 || step_y != 0) {
                hit = this.getHit()
                if ((hit.left && this.x_speed < 0) || (hit.right && this.x_speed > 0)) {
                    this.x_speed = 0
                    //trace("left=" + hit.left + ", right=" + hit.right)
                    step_x = 0
                }
                if ((hit.up && this.y_speed < 0) || (hit.down && this.y_speed > 0)) {
                    this.y_speed = 0
                    step_y = 0
                }
                if (hit.down && this.x_speed != 0) {
                    //this.x_speed *= 0.8;
                    if (Math.abs(this.x_speed) < 0.1)
                        this.x_speed = 0
                }
                var change_x:Number, change_y:Number
                if (step_x < 0) {
                    change_x = Math.max(-1, step_x)
                } else {
                    change_x = Math.min(1, step_x)
                }
                if (step_y < 0) {
                    change_y = Math.max(-1, step_y)
                } else {
                    change_y = Math.min(1, step_y)
                }
                this.x += change_x
                this.y += change_y
                step_x -= change_x
                step_y -= change_y
            }
            if (hit != null && hit.down) {
                if (this.x_speed > 0)
                    this.x_speed -= 0.2
                else if (this.x_speed < 0)
                    this.x_speed += 0.2
            }
        }
    }
}

const BLOCK_SIZE:Number = 32
const MAP_BORDER_Y:int = 32 * 16 * 32

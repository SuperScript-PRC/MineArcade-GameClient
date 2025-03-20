package MineArcade.utils
{
    import flash.ui.ContextMenu;
    import MineArcade.mcs_getter.StageMC;
    import flash.ui.ContextMenuItem;

    public class FlashPlayerProtecter
    {
        public static function Protect():void {
            /*
            使得播放器禁用用户的右键菜单设置.
            */
            var contextMenu:ContextMenu = new ContextMenu();
            contextMenu.hideBuiltInItems()
            addCustom(contextMenu)
            StageMC.root.contextMenu = contextMenu
        }

        private static function addCustom(contextMenu:ContextMenu):void{
        }
    }
}
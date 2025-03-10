package MineArcade.protecter
{
    import flash.ui.ContextMenu;
    import MineArcade.mcs_getter.StageMC;

    public class FlashPlayerProtecter
    {
        public static function Protect():void {
            /*
            使得播放器禁用用户的右键菜单设置.
            */
            var contextMenu:ContextMenu = new ContextMenu();
            contextMenu.hideBuiltInItems()
            StageMC.root.contextMenu = contextMenu
        }
    }
}
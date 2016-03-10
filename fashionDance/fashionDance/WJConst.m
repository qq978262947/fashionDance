
#import <UIKit/UIKit.h>

/** 精华-顶部标题的高度 */
CGFloat const WJTitilesViewH = 35;
/** 精华-顶部标题的Y */
CGFloat const WJTitilesViewY = 64;

/** 精华-cell-间距 */
CGFloat const WJTopicCellMargin = 10;
/** 精华-cell-文字内容的Y值 */
CGFloat const WJTopicCellTextY = 55;
/** 精华-cell-底部工具条的高度 */
CGFloat const WJTopicCellBottomBarH = 49;

/** 精华-cell-图片帖子的最大高度 */
CGFloat const WJTopicCellPictureMaxH = 1000;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
CGFloat const WJTopicCellPictureBreakH = 250;


NSString * const WJUserSexMale = @"m";
NSString * const WJUserSexFemale = @"f";

/** tabBar被选中的通知名字 */
NSString * const WJTabBarDidSelectNotification = @"WJTabBarDidSelectNotification";
/** tabBar被选中的通知 - 被选中的控制器的index key */
NSString * const WJSelectedControllerIndexKey = @"WJSelectedControllerIndexKey";
/** tabBar被选中的通知 - 被选中的控制器 key */
NSString * const WJSelectedControllerKey = @"WJSelectedControllerKey";
/** 状态栏颜色改变的动画时间 */
CGFloat const WJStatusBarAnimationTime = 0.75;
CGFloat const WJStatusAndBarHeight = 64;

#import <UIKit/UIKit.h>

typedef enum {
    WJTopicTypeAll = 1,
    WJTopicTypePicture = 10,
    WJTopicTypeWord = 29,
    WJTopicTypeVoice = 31,
    WJTopicTypeVideo = 41
} WJTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const WJTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const WJTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const WJTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const WJTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const WJTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const WJTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const WJTopicCellPictureBreakH;

/** WJUser模型-性别属性值 */
UIKIT_EXTERN NSString * const WJUserSexMale;
UIKIT_EXTERN NSString * const WJUserSexFemale;

/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const WJTabBarDidSelectNotification;
/** tabBar被选中的通知 - 被选中的控制器的index key */
UIKIT_EXTERN NSString * const WJSelectedControllerIndexKey;
/** tabBar被选中的通知 - 被选中的控制器 key */
UIKIT_EXTERN NSString * const WJSelectedControllerKey;
UIKIT_EXTERN CGFloat const WJStatusBarAnimationTime;
UIKIT_EXTERN CGFloat const WJStatusAndBarHeight;

#import "MyActivityIndicatorView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
#define MYCOLOR [UIColor blackColor]
@implementation MyActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 菊花背景的大小
        self.frame = CGRectMake(kWidth/2-25, KHeight/2-250, 60, 50);
        // 菊花的背景色
        self.backgroundColor = MYCOLOR;
        self.layer.cornerRadius = 10;
        // 菊花的颜色和格式（白色、白色大、灰色）
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        // 在菊花下面添加文字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 60, 20)];
        label.text = @"loading...";
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
    }
    return  self;
}

@end

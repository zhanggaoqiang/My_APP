//
//  Define.h
//  Timer
//
//  Created by qianfeng on 15/8/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef Timer_Define_h
#define Timer_Define_h

#define kScreenSize [UIScreen mainScreen].bounds.size

#define NEWS__URL @"http://api.m.mtime.cn/News/NewsList.api?pageIndex=%ld"

#define HEAD_URL  @"http://api.m.mtime.cn/PageSubArea/GetRecommendationIndexInfo.api" //4*每页头视图

#define kTicketOfficeUrl @"http://api.m.mtime.cn/TopList/TopListOnNews.api"
//票房详情
#define kBoardDetail @"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?pageIndex=1&pageSubAreaID=%@"


#define  NATIVEURL @"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?pageIndex=1&pageSubAreaID=2020"


#define kForeDisplayUrl @"http://api.m.mtime.cn/PageSubArea/TrailerList.api"//预告片

#define kFindCommentUrl @"http://api.m.mtime.cn/MobileMovie/Review.api?needTop=false" //影视评论

#define kReviewDetailUrl @"http://api.m.mtime.cn/Review/Detail.api?reviewId=%ld"//影评详情

#define DetailCommentURL  @"http://api.m.mtime.cn/Review/Comment.api?reviewId=7914255&pageIndex=1"
#define WebViewURL @"http://i.mtime.com/995702/blog/%ld"

#endif

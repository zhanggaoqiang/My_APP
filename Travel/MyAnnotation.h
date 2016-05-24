//
//  MyAnnotation.h
//  Travel
//
//  Created by qianfeng on 15/6/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "CityMapModel.h"

@interface MyAnnotation : NSObject<MKAnnotation>

@property(nonatomic)CityMapModel * model;

@property(nonatomic)NSString *myTitle;
@property(nonatomic)NSString *mySubTitle;
@property(nonatomic)CLLocationCoordinate2D myCoordinate;
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end

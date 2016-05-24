//
//  MapViewController.m
//  Travel
//
//  Created by qianfeng on 15/6/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "DataEngine.h"
#import "AnalyticalNetWorkData.h"
#import "CityMapModel.h"
#import "MyAnnotationView.h"
#import "MyAnnotation.h"
#import "DesCityController.h"
#import "UIImageView+WebCache.h"
#import "CircleBottomView.h"
#import "SVProgressHUD.h"
#import <objc/message.h>
#import <objc/runtime.h>




@interface MapViewController ()<MKMapViewDelegate>

@property(nonatomic)CircleBottomView * bottomView;

@property(nonatomic,copy)NSString * imageName;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchDataWithUrl];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.index<4) {
        self.bar.barTintColor=[self.colorArray objectAtIndexedSubscript:self.index];
        self.imageName=[self.annotationImageArray objectAtIndex:self.index];
    }else{
        self.imageName=@"";
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)addMapView
{
    self.mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    self.mapView.delegate=self;
    [self.view addSubview:self.mapView];
}

-(void)fetchDataWithUrl
{
    [[DataEngine shareInstance]requestMapWithDict:self.dict type:self.type success:^(NSData *respondsObject) {
        self.dataArray=[AnalyticalNetWorkData parseMapData:respondsObject];
        [self setCoordinateForMap];
        [self addAnnotation];
    } faile:^(NSError *error) {
    }];
}

-(void)setCoordinateForMap
{
    CityMapModel * model=[self.dataArray objectAtIndex:0];
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
    MKCoordinateSpan span;
    if ([self.type isEqualToString:@"city"]) {
       span=MKCoordinateSpanMake(10, 10);
    }else{
       span=MKCoordinateSpanMake(0.3, 0.3);
    }
    MKCoordinateRegion region=MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
}

-(void)addAnnotation
{
    int index=0;
    for (CityMapModel * model in self.dataArray) {
        MKPointAnnotation * annotation=[[MKPointAnnotation alloc]init];
        annotation.coordinate=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
        annotation.title=model.cnname;
        objc_setAssociatedObject(annotation, "model", model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(annotation, "index", [NSNumber numberWithInt:index], OBJC_ASSOCIATION_ASSIGN);
        [self.mapView addAnnotation:annotation];
        index++;
    }
}

#pragma mark----<MKMapViewDelegate>

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView   *myAnnotationView = (MKAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:ANNOTATION_ID];
    if (myAnnotationView == nil) {
        myAnnotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ANNOTATION_ID];
    }
    myAnnotationView.canShowCallout = YES;
    int index=[objc_getAssociatedObject(annotation, "index") intValue];
    if (index<10) {
        myAnnotationView.image=[UIImage imageNamed:[NSString stringWithFormat:@"ic_map%@_recommend",_imageName]];
        myAnnotationView.frame=CGRectMake(0, 0, 21, 28);
        
    }else{
        myAnnotationView.image=[UIImage imageNamed:[NSString stringWithFormat:@"ic_map_poi%@",_imageName]];
        myAnnotationView.frame=CGRectMake(0, 0, 10, 10);
    }
    return myAnnotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSString * pressedName=[NSString stringWithFormat:@"ic_map%@_recommend_pressed",self.imageName];
    NSString * normalName=[NSString stringWithFormat:@"ic_map%@_recommend",self.imageName];
    MKPointAnnotation * annotation=(MKPointAnnotation *)view.annotation;
    int index=[objc_getAssociatedObject(annotation, "index") intValue];
    CityMapModel * model=objc_getAssociatedObject(annotation, "model");
    if (index<10) {
        if (self.currentView==nil) {
            self.currentView=view;
            view.image=[UIImage imageNamed:pressedName];
            view.frame=CGRectMake(0, 0, 21, 28);
        }else if(self.currentView!=view){
            self.currentView.selected=NO;
            self.currentView.image=[UIImage imageNamed:normalName];
            self.currentView.frame=CGRectMake(0, 0, 21, 28);
            self.currentView=view;
            self.currentView.selected=YES;
            view.image=[UIImage imageNamed:pressedName];
            view.frame=CGRectMake(0, 0, 21, 28);
        }
        
    }else{
        if (self.currentView==nil) {
            self.currentView=view;
            view.image=[UIImage imageNamed:pressedName];
            view.frame=CGRectMake(0, 0, 10, 10);
        }else if(self.currentView!=view){
            self.currentView.selected=NO;
            self.currentView.image=[UIImage imageNamed:normalName];
            self.currentView.frame=CGRectMake(0, 0, 10, 10);
            self.currentView=view;
            self.currentView.selected=YES;
            view.image=[UIImage imageNamed:pressedName];
            view.frame=CGRectMake(0, 0, 10, 10);
        }
    }
    [self changeRegionOfMap:model];
    [self callDetailViewAboutAnnotation:model];
}

-(void)changeRegionOfMap:(CityMapModel *)model
{
    MKCoordinateRegion region=self.mapView.region;
    region.center=CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
    [self.mapView setRegion:region animated:YES];
}

-(void)callDetailViewAboutAnnotation:(CityMapModel *)model
{
    UINib * nib=[UINib nibWithNibName:@"CircleBottomView" bundle:nil];
    NSArray * array=[nib instantiateWithOwner:nil options:nil];
    self.bottomView=[array lastObject];
    self.bottomView.frame=CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100);
    self.bottomView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomViewClick:)];
    objc_setAssociatedObject(tap, "model", model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.bottomView addGestureRecognizer:tap];
    
    [self.bottomView initUIWithModel:model];
    [self.view addSubview:self.bottomView];
}

-(void)bottomViewClick:(UITapGestureRecognizer *)tap
{
    if ([self.dict objectForKey:@"country_id"]!=nil) {
        CityMapModel * model=objc_getAssociatedObject(tap, "model");
        DesCityController * desCityVC=[[DesCityController alloc]init];
        desCityVC.model=(DesHotCityModel *)model;
        [self.navigationController pushViewController:desCityVC animated:YES];
    }
}

@end

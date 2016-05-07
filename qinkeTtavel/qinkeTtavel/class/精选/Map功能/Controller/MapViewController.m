//
//  MapViewController.m
//  qinkeTtavel
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapKit/BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <Masonry.h>


@interface MapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (nonatomic , retain) BMKMapView *mapView;

@property (nonatomic , retain) BMKLocationService *location;


@property (nonatomic , retain) BMKPointAnnotation *pointAnnot;

@end

@implementation MapViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _pointAnnot = [[BMKPointAnnotation alloc]init];
    
    
    _location = [[BMKLocationService alloc]init];
    _location.delegate = self;
    
    [_location startUserLocationService];
    
    _mapView = [[BMKMapView alloc]init];
    _mapView.zoomLevel = 14;
    
    
    self.view = _mapView;
    
    [self searchMapPoint];
    
}

-(void)searchMapPoint
{
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(30.027283, 116.313217);
//    
//    [_mapView setCenterCoordinate:coordinate animated:YES];
    
}


#pragma mark -- BMKLocationServiceDelegate

//定位成功之后的不停调用
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    _pointAnnot.coordinate = userLocation.location.coordinate;
    _pointAnnot.title = userLocation.title;
    [_mapView addAnnotation:_pointAnnot];
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}

-(void)didStopLocatingUser
{
//    CLLocationCoordinate2D coordinate = _location.userLocation.location.coordinate;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    _mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
    _mapView.delegate = self;
}

@end

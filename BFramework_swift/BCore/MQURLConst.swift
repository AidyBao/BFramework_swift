//
//  MQURLConst.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/4.
//  Copyright © 2017年 120v. All rights reserved.
//

import Foundation
import UIKit

let ZXBOUNDS_WIDTH      =   UIScreen.main.bounds.size.width
let ZXBOUNDS_HEIGHT     =   UIScreen.main.bounds.size.height

class ZX {
    
    static let PageSize:Int             =   12
    static let HUDDelay                 =   1.2
    static let CallDelay                =   0.5
    
    //定位失败 默认位置
    struct Location {
        static let latitude             =   30.592061
        static let longitude            =   104.063396
    }
}

/// 接口地址
class ZXURLConst {
    struct Api {
        static let url                  =   "http://115.182.15.118"
        static let port                 =   "8111"
        //测试
        //        static let url                  =   "http://192.168.0.182"
        //        static let port                 =   "80/aggInterface"
    }
    
    struct Resource {
        static let url                  =   "http://115.182.15.118"
        static let port                 =   "8118"
    }
    
    struct Web {
        static let about                =   "pages/about.html"                  //关于H5
        static let serviceItems         =   "pages/userAgreement.html"          //服务条款H5
    }
    
    struct WX {
        static let oauthAccessToken    =    "https://api.weixin.qq.com/sns/oauth2/access_token?" //获取授权access_token
        static let refreshAccessToken  =    "https://api.weixin.qq.com/sns/oauth2/refresh_token?" //刷新access_token
        static let verfifyAuth         =    "https://api.weixin.qq.com/sns/auth?"                 //检验授权凭证（access_token）是否有效
        static let getWXUserinfo       =    "https://api.weixin.qq.com/sns/userinfo?"              //获取用户个人信息
    }
}

/// 功能模块接口
class ZXAPIConst {
    struct System {
        static let time                 = "member/getServerTime"
    }
    
    struct FileResouce {
        static let url                  =   "agg/pages/uploadFileApp"             //文件上传接口
    }
    
    //MARK: - User
    struct User {
        static let getSMSCode    = "verificationCode/getSMSVerificationCode"  //获取验证码
        static let telLogin      = "member/loginByTel"                        //手机号登录
        static let WXLogin       = "member/loginByWX"                         //微信登录
        static let WXbinding     = "member/bindingWX"                         //微信绑定
        static let authTel       = "member/authTel"                           //验证手机号
        static let verCode       = "verificationCode/authVerificationCode"    //校验验证码
        //        static let memberVerCode       = "member/authVerificationCode"      //会员校验验证码
        static let verInviteCode = "inviteCode/authInviteCode"                //校验邀请码
        static let updateEqInfo  = "member/updateEquipmentInfo"               //更新设备信息
        static let getDictList   = "dict/getDictListByTypes"                  //1:年龄段 2:扣税说明 3:提现须知 4:游戏规则
        static let setSexAndAge  = "member/setSexAndAgeGroups"                //登录设置性别和年龄段
        static let memberInfo    = "member/getInfo"                           //获取用户信息
        static let getMemberInfo = "member/getMemberInfo"                     //根据二维码或者口令获取会员信息
        static let register      = "member/register"                          //注册
        static let autoLogin     = "member/autoLogin"                         //自动登录
        static let shareRecords  = "shareRecords/add"                         //新增分享记录
    }
    
    //MARK: - Home
    struct Home {
        static let shakeAds             =   "shake/shakeAd"                     //摇一摇接口
        static let adsDetail            =   "ad/view"
        static let effectiveRedPk       =   "redEnvelopeRecords/updateEffective"//红包生效
        static let openBonus            =   "member/updateByProfit"             //领取红包
        static let todayRecord          =   "member/getTodayRecord"             //今日战绩
        static let selectOneInFour      =   "shakeRecord/changeAdId"            //选择-四选一广告
        static let behavior             =   "behaviorRecords/addBehavior"       //界面行为记录
        static let onlineTime           =   "member/addOnlineTime"              //在线时长
    }
    
    //MARK: - Store
    struct Store {
        static let goodsList            =   "goods/list"                        //商品列表
        static let goodsDetail          =   "goods/view"                        //商品详情
        static let goodsMark            =   "goods/changePraise"                //商品赞/取消赞
        static let labelList            =   "goodsLabel/list"                   //商品分类标签列表
        static let saveLabel            =   "goodsLabel/saveMemberLabels"       //保存会员关注商品标签
    }
    //MARK: - Coupon
    struct Coupon {
        static let list                 =   "memberCoupon/list"
        static let detail               =   "memberCoupon/view"
        static let use                  =   "memberCoupon/useCoupon"            //使用线下券
    }
    //MARK: - Shopping Cart
    struct ShoppingCart {
        static let list                 =   "shoppingCart/list"                 //购物车列表
        static let updateGoodsNum       =   "shoppingCart/updateNum"            //修改购物车商品数量
        static let delete               =   "shoppingCart/remove"               //删除购物车商品
        static let check                =   "shoppingCart/changeSelect"         //修改购物车商品选中状态
        static let addToCart            =   "shoppingCart/add"                  //新增购物车商品
        static let totalCount           =   "shoppingCart/sumNum"               //总数
    }
    
    //MARK: - Order
    struct Order {
        static let prePay               =   "order/confirmOrder"                //结算
        static let create               =   "order/createOrder"                 //创建订单
        static let list                 =   "order/getOrderList"                //订单列表
        static let detail               =   "order/view"                        //订单详情
        static let updateStatus         =   "order/updateOrderStatus"           //修改订单状态(1、取消订单 2、确认收货)
        static let express              =   "orderLogistics/getOrderLogistics"  //查看物流信息
        static let delete               =   "order/deleteOrder"                 //删除订单
        static let refundDetail         =   "orderOperate/getRefundSchedule"    //查看退款进度
        static let wxPay                =   "common/wxpay"                      //
        static let receiveInviteCode    =   "inviteCode/receiveInviteCode"      //领取邀请码
    }
    
    //MARK: - EL Garden
    struct Garden {
        static let msgList              =   "dynamic/list"
        static let elephantList         =   "elephant/list"
        static let exchange             =   "member/loveNumToMoney"             //爱心兑换余额
    }
    //MARK: - Elephant
    struct Elephant {
        static let detail               =   "elephant/view"
        static let feed                 =   "elephant/feed"
        static let playWithMine         =   "elephant/playByOwn"
        static let playWithOthers       =   "elephant/playByFriend"
        static let harvestLove          =   "loveJournal/receiveLove"
        static let harvestOthersLove    =   "loveJournal/receiveLoveByFriend"
    }
    
    //MARK: - EL MessageBoard
    struct MessageBoard {
        static let list                 =   "messageBoard/list"
        static let replyList            =   "messageBoard/childList"            //更多
        static let addNew               =   "messageBoard/add"
        static let delete               =   "messageBoard/delete"
        static let unreadCount          =   "messageBoard/noReadNum"
        static let setAllRead           =   "messageBoard/changeIsRead"
    }
    
    //MARK: - 个人
    struct Personal {
        static let updateSex            =   "member/updateSex"                  //修改性别
        static let updateAgeGroups      =   "member/updateAgeGroups"            //修改年龄段
        static let updateHeadPortrait   =   "member/updateHeadPortrait"         //更新会员头像
        static let addressList          =   "address/list"                      //收货地址清单
        static let removeAddress        =   "address/remove"                    //移除收货地址
        static let defaultAddress       =   "address/setDefault"                //设置默认收货地址
        static let updateAddress        =   "address/update"                    //修改收货地址
        static let addAddress           =   "address/add"                       //新增收货地址
        static let updateName           =   "member/updateName"                 //修改用户名字
        static let getAreaList          =   "area/getAreaList"                  //获取区域
        static let updateTel            =   "member/updateTel"                  //修改电话
        static let messageList          =   "message/list"                      //消息
        static let messageDetail        =   "message/view"                      //消息详情
        static let messageNoRead        =   "message/noReadNum"                 //未读消息数
        static let expensesList         =   "accountRecords/list"               //收支记录
        static let rankList             =   "accountRecords/ownerList"          //金主排行榜
        static let extract              =   "member/extract"                    //提现申请
        static let extractRecords       =   "extractRecords/list"               //提现记录
        static let extractDetail        =   "extractRecords/view"               //提现详情
        static let updateMsgStatus      =   "message/updateStatus"              //更新消息状态
    }
    
    //MARK: - 邀请码
    struct Code {
        static let getInviteCode        =   ""                                  //获取邀请码
        static let getInviteCodeList    =   "inviteCode/getListByMemberId"      //获取邀请码列表
        static let isHaveInviteCode     =   "goods/isHaveInviteCode"            //查看商品中是否有邀请码
    }
    
    //MARK: - 爱心公益
    struct Donation {
        static let projectDonationList  =   "donationJournal/messageList"       //获取项目捐赠列表
        static let memberDonationList   =   "donationJournal/list"              //获取会员捐赠列表
        static let donationMessageList  =   "donationJournal/messageList"       //获取项目捐赠留言
        static let publicWelfareProjectList   =   "publicWelfareProject/list"   //公益项目列表
        static let publicWelfareProjectDetail =  "publicWelfareProject/view"    //查看公益项目详情
        static let whereDonateList            =  "whereabouts/list"             //善款去向
        static let loveNumToDonationTen       =  "member/loveNumToDonationTen"  //快捷爱心捐赠10枚
        static let loveNumToDonation          =  "member/loveNumToDonation"     //爱心捐赠
        static let donationSuccProjectList    =  "publicWelfareProject/randList"   //捐赠完成后进行中公益项目列表
    }
    
    struct Friend {
        static let friendsList              =   "friends/list"           //获取好友列表
        static let recommendFriendsList     =   "friends/systemPushList" //获取系统推荐好友列表
        static let friendsRequestsList      =   "friends/requestsList"   //获取好友申请列表
        static let friendsRequestsCount     =   "friends/requestsCount"  //获取会员好友申请总数
        static let friendsAgreeOrReject     =   "friends/agreeOrReject"  //会员同意或者拒绝好友添加申请
        static let addFriend                =   "friends/addFriend"
        //添加好友
        static let getQrCode                =   "member/getQrCode"       //我的二维码
        static let getCommendCode           =   "member/getTokenCode"    //我的口令
        static let getMemberInfo            =   "member/getMemberInfo"   //根据二维码或者口令获取会员信息
    }
}

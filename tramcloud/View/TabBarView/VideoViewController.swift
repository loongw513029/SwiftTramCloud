//
//  VideoViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import UIKit
import VideoToolbox
import AVFoundation
import HandyJSON
class VideoViewController: TramUIViewController {
    
    var formatDesc: CMVideoFormatDescription?
    var decompressionSession: VTDecompressionSession?
    var videoPlayer: AVSampleBufferDisplayLayer?
    
    var socket:GCDAsyncSocket!
    let socketPort:UInt16 = 9201
    var hostName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        CustomNavigationBar("视频预览", false, true, false, "", 0, 0, 2)
        self.initView()
        self.initSocket()
    }
    
    ///初始化播放界面
    func initView(){
        videoPlayer = AVSampleBufferDisplayLayer()
        let Height = bounds.height - AppDelegate().StatusHeight - (self.navigationController?.navigationBar.frame.height)!
        let videoHeight = bounds.width*9/16
        if let layer = videoPlayer {
            layer.frame = CGRect(x:0,y:(Height-videoHeight)/2,width:bounds.width,height:videoHeight)
            layer.videoGravity = .resizeAspect
            let _CMTimebasePointer = UnsafeMutablePointer<CMTimebase?>.allocate(capacity: 1)
            let status = CMTimebaseCreateWithMasterClock(kCFAllocatorDefault, CMClockGetHostTimeClock(), _CMTimebasePointer)
            layer.controlTimebase = _CMTimebasePointer.pointee
            
            if let controlTimebase = layer.controlTimebase,status == noErr{
                CMTimebaseSetTime(controlTimebase, kCMTimeZero)
                CMTimebaseSetRate(controlTimebase, 1.0)
            }
            self.view.layer.addSublayer(layer)
        }
    }
    
    
    
}
extension VideoViewController:GCDAsyncSocketDelegate{
    
    func initSocket(){
        let host = AppDelegate().BaseUrl
        self.hostName = host.components(separatedBy: "//")[1].components(separatedBy: ":")[0]
        self.socket = GCDAsyncSocket()
        self.socket.delegate = self
        self.socket.delegateQueue = DispatchQueue.global()
        do{
            try self.socket.connect(toHost: self.hostName, onPort: self.socketPort)
        }
        catch{
            print("try connect error:\(error)")
        }
    }
    ///登录转发命令
    func SendLoginRequest(source:String,platform:String) ->String{
        var obj = BaseRequest<String>()
        obj.type = 101
        obj.source = source
        obj.msgInfo = "IOS"
        return obj.toJSONString()!+"\n";
    }
    
    ///发送视频数据请求命令
    func SendVideoRequestCMD(uuid:String,devicecode:String,trun:Bool,channel:Int,stream:Int,ipstring:String,type:String) ->String{
        var channelObj = RequestChannelModel()
        channelObj.State = trun
        channelObj.IpString = ipstring
        channelObj.type = type
        channelObj.Channel = channel
        channelObj.SubChannel = stream
        var obj = BaseRequest<RequestChannelModel>()
        obj.msgInfo = channelObj
        obj.type = 103
        obj.source = uuid
        obj.target = devicecode
        return obj.toJSONString()!+"\n"
    }
    ///发送数据
    func sendSocketMsg(msg:String){
        self.socket.write(msg.data(using: .utf8)!, withTimeout: -1, tag: 0)
    }
    ///接收socket数据
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        let readDataString = String(data:data as Data,encoding:.utf8)
        print(readDataString)
        var obj = JSONDeserializer<BaseRequest<SocketResponseModel>>.deserializeFrom(json: readDataString)
        let byte = obj?.msgInfo!.Buffer
        
    }
}

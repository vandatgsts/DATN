import UIKit
import Flutter
import opencv2

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let openCvChannel = FlutterMethodChannel(name: "opencv", binaryMessenger: controller.binaryMessenger)
        
        openCvChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "getPlatformVersion":
                let version: NSInteger = Core.version()
                result(String("OpenCV \(version)"))
                break
                
            case "process_image":
                let args = call.arguments as? [String: Any]
                
                if(args == nil) {
                    return
                }
                
                let byteData = args!["byteData"] as? [NSNumber]
                let threshold1 = args!["threshold1"] as? Double
                let threshold2 = args!["threshold2"] as? Double
                let kernelSize = args!["kernelSize"] as? Double
                let noise = args!["noise"] as? Double
                let edgeLevel = args!["edgeLevel"] as? Int
                
                let matOfByte: Mat = MatOfByte.init(array: byteData!)
                
                let src = Imgcodecs.imdecode(buf: matOfByte, flags: 0)
                
                let gaussianBlur = Mat()
                Imgproc.GaussianBlur(
                    src: src,
                    dst: gaussianBlur,
                    ksize: Size2i(width: 5, height: 5),
                    sigmaX: 0.0
                )
                
                // Áp dụng Adaptive Threshold
                let adaptiveThreshold = Mat()
                Imgproc.adaptiveThreshold(src: gaussianBlur, dst: adaptiveThreshold, maxValue: 255, adaptiveMethod: AdaptiveThresholdTypes.ADAPTIVE_THRESH_GAUSSIAN_C, thresholdType: ThresholdTypes.THRESH_BINARY_INV, blockSize: 9, C: noise!)
                
                // Phát hiện cạnh bằng Canny
                let edge = Mat()
                Imgproc.Canny(image: adaptiveThreshold, edges: edge, threshold1: threshold1!, threshold2: threshold2!)
                
                // Dilate edges
                let kernel = Imgproc.getStructuringElement(
                    shape: MorphShapes.MORPH_RECT,
                    ksize: Size2i(
                        width: Int32(kernelSize!),
                        height: Int32(kernelSize!)
                    )
                )
                let edgesDilated = Mat()
                Imgproc.dilate(src: edge, dst: edgesDilated, kernel: kernel, anchor: Point2i(x: -1, y: -1), iterations: 1)
                
                
                // Tạo một Mat trong suốt
                let transparentMat = Mat.init(
                    rows: edgesDilated.rows(),
                    cols: edgesDilated.cols(),
                    type: CvType.CV_8UC4,
                    scalar: Scalar(0, 0, 0, 0)
                )
                
                // Tìm và vẽ đường viền
                var contours = [[Point2i]]()
                var hierarchy = Mat()
                
                Imgproc.findContours(
                    image: edgesDilated,
                    contours: [contours],
                    hierarchy: hierarchy,
                    mode: RetrievalModes.RETR_TREE,
                    method: ContourApproximationModes.CHAIN_APPROX_SIMPLE
                )
                
                for contour in contours {
                    Imgproc.drawContours(
                        image: transparentMat,
                        contours: [contour],
                        contourIdx: -1,
                        color: Scalar(0, 0, 0, 255),
                        thickness: Int32(edgeLevel!)
                    )
                }
                
                // Mã hóa Mat sang dữ liệu PNG
                let matOfByteOut = ByteVector()
                Imgcodecs.imencode(
                    ext: ".png",
                    img: transparentMat,
                    buf: matOfByteOut
                )
                // Chuyển đổi MatOfByte sang mảng byte
                let answer = Array(matOfByteOut)
                
                result(answer)
                
                break
                
            default:  //Code for case where you don't recognize the call method
                result(FlutterMethodNotImplemented)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

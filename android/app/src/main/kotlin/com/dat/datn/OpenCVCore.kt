package com.dat.datn

import io.flutter.Log
import org.opencv.core.CvType
import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.core.MatOfPoint
import org.opencv.core.Point
import org.opencv.core.Scalar
import org.opencv.core.Size
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import org.opencv.imgproc.Imgproc.ADAPTIVE_THRESH_GAUSSIAN_C
import org.opencv.imgproc.Imgproc.THRESH_BINARY_INV
import kotlin.system.measureTimeMillis

object OpenCVCore {
    private const val TAG = "CVCore"
    private const val JPG = ".jpg"
    private const val PNG = ".png"

    fun adaptiveThreshold(
        byteData: ByteArray?, blockSize: Int, cValue: Double
    ): ByteArray {
        var byteArray = ByteArray(0)

        try {
            val dst = Mat()
            val src = Imgcodecs.imdecode(MatOfByte(byteData), Imgcodecs.IMREAD_UNCHANGED)

            // Kiểm tra nếu src đã là grayscale thì không cần chuyển đổi
            val gray = if (src.channels() > 1) {
                // Chuyển đổi sang Grayscale
                Mat().also { Imgproc.cvtColor(src, it, Imgproc.COLOR_BGR2GRAY) }
            } else {
                src
            }
            var gaussianBlur = Mat()
            Imgproc.GaussianBlur(gray, gaussianBlur, Size(1.0, 31.0), -0.005)
            Imgproc.adaptiveThreshold(
                gaussianBlur,
                dst,
                255.0,
                ADAPTIVE_THRESH_GAUSSIAN_C,
                THRESH_BINARY_INV,
                blockSize,
                cValue
            )
            println("$blockSize $cValue")


            val transparentMat = Mat(dst.size(), CvType.CV_8UC4, Scalar(0.0, 0.0, 0.0, 0.0))
            val contours = ArrayList<MatOfPoint>()
            val hierarchy = Mat()
            Imgproc.findContours(
                dst, contours, hierarchy, Imgproc.RETR_TREE, Imgproc.CHAIN_APPROX_SIMPLE
            )
            println("do dai: ${dst.size()}")
            // Đo thời gian thực thi việc vẽ contours lên nền trong suốt
            val elapsedTime = measureTimeMillis {
                for (contour in contours) {
                    Imgproc.drawContours(
                        transparentMat, listOf(contour), -1, Scalar(0.0, 0.0, 0.0, 255.0), -1
                    )
                }
            }
            println("Thời gian thực thi: $elapsedTime ms")


            val matOfByte = MatOfByte()
            Imgcodecs.imencode(".png", transparentMat, matOfByte)
            byteArray = matOfByte.toArray()
        } catch (e: Exception) {
            Log.e(TAG, "OpenCV Error: $e")
            println("OpenCV Error: $e")
        }

        return byteArray
    }

    fun processImage(
        byteData: ByteArray?,
        threshold1: Double,
        threshold2: Double,
        kernelSize: Double,
        edgeLevel: Int,
        noise: Double,
    ): ByteArray {
        var byteArray = ByteArray(0)

        try {

            val elapsedTime = measureTimeMillis {
                val src = Imgcodecs.imdecode(MatOfByte(byteData), Imgcodecs.IMREAD_GRAYSCALE)

                val gaussianBlur = Mat()
                Imgproc.GaussianBlur(src, gaussianBlur, Size(5.0, 5.0), 0.0)

                val adaptiveThreshold = Mat()
                Imgproc.adaptiveThreshold(
                    gaussianBlur,
                    adaptiveThreshold,
                    255.0,
                    ADAPTIVE_THRESH_GAUSSIAN_C,
                    THRESH_BINARY_INV,
                    9,
                    noise
                )

                val edge = Mat()
                Imgproc.Canny(adaptiveThreshold, edge, threshold1, threshold2)

                val kernel =
                    Imgproc.getStructuringElement(Imgproc.MORPH_RECT, Size(kernelSize, kernelSize))

                val edgesDilated = Mat()
                Imgproc.dilate(edge, edgesDilated, kernel, Point(-1.0, -1.0), 1)

                val transparentMat = Mat(
                    edgesDilated.size(), CvType.CV_8UC4, Scalar(0.0, 0.0, 0.0, 0.0)
                )
                val contours = ArrayList<MatOfPoint>()
                val hierarchy = Mat()
                Imgproc.findContours(
                    edgesDilated,
                    contours,
                    hierarchy,
                    Imgproc.RETR_TREE,
                    Imgproc.CHAIN_APPROX_SIMPLE
                )

                for (contour in contours) {
                    Imgproc.drawContours(
                        transparentMat, listOf(contour), -1, Scalar(0.0, 0.0, 0.0, 255.0), edgeLevel
                    )
                }


                val matOfByte = MatOfByte()
                // Lưu ý: Sử dụng định dạng PNG để hỗ trợ nền trong suốt
                Imgcodecs.imencode(PNG, transparentMat, matOfByte)
                byteArray = matOfByte.toArray()
            }
            println("Thời gian thực thi: $elapsedTime ms")
        } catch (e: Exception) {
            Log.e(TAG, "OpenCV Error: ${e.message}")
            println("OpenCV Error: ${e.message}")
        }

        return byteArray
    }
}
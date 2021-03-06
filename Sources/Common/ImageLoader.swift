/*
* Copyright 2015 Google Inc. All Rights Reserved.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Foundation

/**
 Helper class for loading images.
 */
@objc(BKYImageLoader)
public final class ImageLoader: NSObject {
  /**
   Returns an image with a given name in the main application bundle. As a fallback, it returns
   the image inside the associated bundle for the given class (typically, this will be the
   framework's default bundle).

   - parameter imageName: The name of the image in a bundle's asset catalog.
   - parameter anyClass: The class that is requesting the image.
   - parameter flipForRTL: `true` if the image should be flipped on the Y-axis for RTL purposes.
   `false` if the image should not be flipped.
   - returns: The image, either from the main application bundle or the default bundle for the
   given class.
   - note: Images are loaded via UIImage(imageNamed:), which means they are cached in the system
   by default after they are loaded.
   */
  public class func loadImage(
    named imageName: String, forClass anyClass: AnyClass, flipForRTL: Bool = false) -> UIImage? {
    var returnImage: UIImage?
    if let image = UIImage(named: imageName) {
      returnImage = image
    } else {
      let bundle = Bundle(for: anyClass)
      returnImage = UIImage(named: imageName, in: bundle, compatibleWith: nil)
    }

    if flipForRTL,
      let cgImage = returnImage?.cgImage,
      let scale = returnImage?.scale {
      return UIImage(cgImage: cgImage, scale: scale, orientation: .upMirrored)
    } else {
      return returnImage
    }
  }
}

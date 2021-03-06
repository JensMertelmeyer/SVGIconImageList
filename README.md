# SVGIconImageList [![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## An extended ImageList for Delphi (VCL+FMX) to simplify use of SVG Icons (resize, opacity, grayscale and more...)

## Welcome to the SVGIconFontImageList guide (VCL+FMX)

### Actual official version 1.8 (VCL+FMX)

| Component | Description |
| - | - |
| ![https://github.com/EtheaDev/SVGIconImageList/blob/master/Packages/SVGIconImageCollectionComponentIcon.png](https://github.com/EtheaDev/SVGIconImageList/blob/master/Packages/SVGIconImageCollectionComponentIcon.png) | **SVGIconImageCollection is collection of SVG Images for Delphi to provide a centralized list of images for VirtualImageLists (only for VCL)** |
| ![https://github.com/EtheaDev/SVGIconImageList/blob/master/Packages/SVGIconVirtualImageListComponentIcon.png](https://github.com/EtheaDev/SVGIconImageList/blob/master/Packages/SVGIconVirtualImageListComponentIcon.png) | **SVGIconVirtualImageList is a special "virtual" ImageList for Delphi linked to an SVGIconImageCollection (only for VCL) to simplify use of SVG Icons (resize, opacity, grayscale and more...)** |
| ![https://github.com/EtheaDev/SVGIconImageList/blob/master/Packages/SVGIconImageListComponentIcon.png](https://github.com/EtheaDev/SVGIconImageList/blob/master/Packages/SVGIconImageListComponentIcon.png) | **SVGIconImageList is an extended ImageList for Delphi (VCL+FMX) with an embedded SVG image collection, to simplify use of SVG Icons (resize, opacity, grayscale and more...)** |
| ![https://github.com/EtheaDev/SVGIconImageList/blob/master/Packages/SVGIconImageComponentIcon.png](https://github.com/EtheaDev/SVGIconImageList/blob/master/Packages/SVGIconImageComponentIcon.png) | **SVGIconImage is an extended Image component for Delphi (VCL+FMX) to show any SVG image directly or included into a an SVGIconImageList with all functionality (stretch, opacity, grayscale and more...)** |

A single SVGIconImageList can draw icons in SVG format at any resolution similar to a VirtualImageList+ImageCollection.  The ImageList, placed on a form, scales automatically when DPI changes.

If you want a full support for High-DPI in a multi-form application on multi-monitors, you must use a single TSVGIconImageCollection into a centralized resource (like a Datamodule) and add a TSVGVirtualImageList (connected to this Collection) on every form of your app.

![Delphi 10.4 Sydney Support](/Demo/Images/SupportingDelphi.jpg)

**Sample image of VCL version**
![https://github.com/EtheaDev/SVGIconImageList/blob/master/Demo/Images/Sample.jpg](https://github.com/EtheaDev/SVGIconImageList/blob/master/Demo/Images/Sample.jpg)

**Sample image of FMX (Windows) version**
![https://github.com/EtheaDev/SVGIconImageList/blob/master/Demo/Images/SampleFMX.jpg](https://github.com/EtheaDev/SVGIconImageList/blob/master/Demo/Images/SampleFMX.jpg)

**Sample image of the VCL SVGText-property editor**
![https://github.com/EtheaDev/SVGIconImageList/blob/master/Demo/Images/SVGTextPropertyEditor.jpg](https://github.com/EtheaDev/SVGIconImageList/blob/master/Demo/Images/SVGTextPropertyEditor.jpg)

**UTILITY**

The [SVG Icon Explorer](https://github.com/EtheaDev/SVGIconImageList/wiki/SVGIconExplorer) utility is useful to explore and preview your svg image collections.

**DOCUMENTATION**

Follow the [guide in Wiki section](https://github.com/EtheaDev/SVGIconImageList/wiki) to known how to use those components to modernize your Delphi VCL or FMX Windows applications scalable, colored and beautiful with few lines of code.

**RELEASE NOTES:**

03 Aug 2020: version 1.8 (VCL+FMX)
 - Complete refactoring for full support of High-DPI
 - New SVGIconImageCollection component
 - New SVGIconVirtualImageList component
 - Redesign of SVGIconImageList component and Component Editor
 - Demo updated to test multi-monitor with different DPI
 - Fixed issue #20: Coordinates in double (PaintTo methods)
 - Fixed issue #25: Transform matrix is wrongly parsed 
 - Fixed issue #26: Error in CalcMartrix
 - Fixed issue #27: TSVGRadialGradient.ReadIn does not read the gradientTransform matrix
 - Fixed issue #28: Colors should be reversed in TSVGRadialGradient
 - Fixed issue #29: Scaling should be based on ViewBox width/height
 - Fixed issue #31: Empty svg properties cause exceptions
 - Fixed issue #33: "fill-rule' presentation attribute is not processed
 - Fixed issue #34: Exception text elements cause exceptions

05 Aug 2020: version 1.7 (VCL+FMX)
 - Added DPIChanged method
 - Enhanced SVGExplorer
 - Fixed issue #20: replaced Double with Single
 - Fixed issue #19 and 18#: Load/SaveToStream inefficient and encoding inconsistency
 - Fixed issue #17: Wrong conversion from pt to px
 - Fixed issue #14: scaling problem
 - Fixed issue #11: Incompatible with Drag-Drop of TImageList
 - Fixed issue #6: Rendering of some SVG images is incorrect

15 July 2020: version 1.6 (VCL+FMX)
 - Fixed rendering on TButton! (VCL)
 - Fixed "Apply" into ImageEditor (VCL)
 - Added reformat XML to ImageEditor (VCL)
 - Added utility to explore icons into disk/folder (SVGExplorer)
 - Fixed inherited color drawing (SVG)
 - Fixed storing properties into dfm in binary mode (VCL)
 - Fixed storing for some properties (don't store default values)
 
13 June 2020: versione 1.5 (VCL+FMX)
 - Added support for DisabledGrayScale and DisabledOpacity as in VirtualImageList
 - Fixed drawing disabled icons also with VCLStyles active

09 June 2020: versione 1.4 (VCL+FMX)
- Added GrayScale and FixedColor to ImageList for every Icons
- Added GrayScale and FixedColor for single Icon
- Added some complex svg demo images
- Updated demos

06 June 2020: version 1.3 (VCL+FMX)
- Added property editor for TSVGIconImage.SVGText and TSVGIconItem.SVGText
- Fixed some drawing problems with transform attribute
- Fixed rescaling icons when monitor DPI changes

28 May 2020: version 1.2 (VCL+FMX)
- Complete support of **Delphi 10.4**
- Added support for other Delphi versions (VCL): **DXE6**, **DXE8**, **D10.1**
- Added position memory of component editor
- Fixed Issue: Icon Editor not keeping added icons
- Fixed Issue: SVG with exponent notation does not parse correctly and affects image display

25 May 2020: version 1.1 (VCL+FMX)
- Added the component **TSVGIconImageListFMX** with advanced component editor.
- Added the component **TSVGIconImageFMX** to show SVG into a TImage.
- Demos to show how they works.
- Very high performance for building hundreds of icons.

24 May 2020: first version 1.0 (VCL)
- Added the component **TSVGIconImageList** with advanced component editor.
- Added the component **TSVGIconImage** to show SVG into a TImage.
- Demos to show how they works.
- Very high performance for building hundreds of icons.
- Support from Delphi 10.2 to 10.4 Sydney (other Delphi versions coming soon)

**THANKS TO:**

Those components uses library SVG Martin Walter (Original version (c) 2005, 2008) with license:
Use of this file is permitted for commercial and non-commercial. Use, as long as the author is credited.
home page: http://www.mwcs.de  email: martin.walter@mwcs.de 
This library is included in this project into svg folder

Many thanks to **Vincent Parrett** and **Kiriakos Vlahos** for their great contibution.

**TSVGIconImageList** and **TSVGIconImage** are similar to **TSVGImageList** and **TSVGImage** included into project: [https://github.com/ekot1/DelphiSVG.git](https://github.com/ekot1/DelphiSVG.git)
but those versions are more efficient in performances, and adds some features like SVGText property, store icons in binary or SVGText format into dfm and more...

**TSVGIconImageListFMX** and **TSVGIconImageFMX** are similar to **TIconFontsImageListFMX** and **TIconFontsImage** included into similar project made by Ethea for Icon Fonts: [https://github.com/EtheaDev/IconFontsImageList](https://github.com/EtheaDev/IconFontsImageList)

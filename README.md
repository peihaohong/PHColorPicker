# PHColorPicker
Color Picker, Color Wheel;
A colorPicker written by swift5 for ios;
There two class and one extension inside ;
UIColor + Hestring.swift change value to UIColor；
BrightnessSider.swift  control  brightness of the color;
ColorWheel.swift  pick color what you want ;
more detail ,see the code.

颜色获取
可以根据输入的16位进制颜色数值获取颜色，也可以根据颜色轮盘自己选择，还可以调节亮度
包含三个类
UIColor + Hestring.swift 颜色与16位进制 的转换，主要是用于自己输入，方法简单，网上一堆，顺便加的
BrightnessSider.swift   控制颜色亮度，根据一个颜色然后调亮度，获取新的颜色，是一个滑动条，可以是水平的，也可以是垂直的
ColorWheel.swift  颜色选择器，真正比较有用的吧
颜色选择器跟亮度滑动条可以搭配使用，也可以单独使用。具体看示例

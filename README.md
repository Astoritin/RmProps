## RmProps | 移除属性值
A Magisk module to remove specific system properties (included PiHooks/PixelProps/PlayIntegrityFix related properties).   
一个移除指定属性值的Magisk模块(包括PiHooks/PixelProps/PlayIntegrityFix相关的属性值)。
#### Tips | 提示
If you are looking for similar module to deal with PiHooks/PixelProps/PlayIntegrityFix related properties and only running once, see [RmPIFProps](https://github.com/Astoritin/RmPIFProps/).   
如果你仅需要处理PiHooks/PixelProps/PlayIntegrityFix相关属性值的仅运行一次的模块，参阅[RmPIFProps](https://github.com/Astoritin/RmPIFProps/)。
### How to config? | 如何配置?
Config file is loacted in `/data/adb/rmprops/rmprops.conf`. Open this file to config everything.   
- **remove_props**: Remove custom properties in `props_to_remove`. `false` by default to disable this feature, `true` to enable this feature.
- **remove_pi_props**: Remove PiHooks/PixelProps/PlayIntegrityFix related properties. `true` by default to enable this feature, `false` to disable this feature.
- **props_to_remove**: Properties list to remove in `remove_props` section, supports multi-line, one per line, please enclose the items in double quotation marks. For example: props_to_remove="persist.a persist.b persist.c"   
   
配置文件位于 `/data/adb/rmprops/rmprops.conf`. 打开此文件以配置RmProps。   
- **remove_props**: 移除位于 `props_to_remove` 的属性值。 默认值为 `false` (默认禁用该功能), 设定为 `true` 以启用该功能。
- **remove_pi_props**: 移除 PiHooks/PixelProps/PlayIntegrityFix 相关的属性值。 默认值为 `true` (默认启用该功能) ，设定为 `false` 以禁用该功能。
- **props_to_remove**: 指定 `remove_props` 节要移除的属性值清单, 支持多行，一行一个，请用英文的双引号将其括起来，例如: props_to_remove="persist.a persist.b persist.c"   
### Why this module exists? | 为什么存在这个模块?
[Click here | 点我](https://github.com/Astoritin/RmPIFProps/?tab=readme-ov-file#why-this-module-exists--%E4%B8%BA%E4%BB%80%E4%B9%88%E5%AD%98%E5%9C%A8%E8%BF%99%E4%B8%AA%E6%A8%A1%E5%9D%97)
### What does this module do? | 这个模块是干什么的？
[Click here | 点我](https://github.com/Astoritin/RmPIFProps/?tab=readme-ov-file#what-does-this-module-do--%E8%BF%99%E4%B8%AA%E6%A8%A1%E5%9D%97%E6%98%AF%E5%B9%B2%E4%BB%80%E4%B9%88%E7%9A%84)   
   
**建议刷入后重新启动一次，以避免由于property区被resetprop修改导致的 Property modified (10)。**
### A Call for Better Practices | 姑且呼吁一些东西
[Click here | 点我](https://github.com/Astoritin/RmPIFProps/?tab=readme-ov-file#a-call-for-better-practices--%E5%A7%91%E4%B8%94%E5%91%BC%E5%90%81%E4%B8%80%E4%BA%9B%E4%B8%9C%E8%A5%BF)
### Credits | 鸣谢
- [Magisk](https://github.com/topjohnwu/Magisk) - the foundation which makes everything possible | 让一切成为可能的基石
- [LSPosed](https://github.com/LSPosed/LSPosed) - the implementation of function root solution check and extract | Root方案检测函数和解压函数的实现
- [Zygisk Next](https://github.com/Dr-TSNG/ZygiskNext) - the implementation of function root solution check | Root方案检测函数和解压函数的实现

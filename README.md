## RmProps | 移除属性值
A Magisk module to remove specific system properties (included PiHooks/PixelProps/PlayIntegrityFix related properties).   
一个移除指定属性值的Magisk模块(包括PiHooks/PixelProps/PlayIntegrityFix相关的属性值)。
#### Tips | 提示
If you are looking for similar module to deal with PiHooks/PixelProps/PlayIntegrityFix related properties and only running once, see [RmPIFProps](https://github.com/Astoritin/RmPIFProps/).   
如果你仅需要处理PiHooks/PixelProps/PlayIntegrityFix相关属性值的仅运行一次的模块，参阅[RmPIFProps](https://github.com/Astoritin/RmPIFProps/)。
### Why this module exists? | 为什么存在这个模块?
See [here](https://github.com/Astoritin/RmPIFProps/?tab=readme-ov-file#why-this-module-exists--%E4%B8%BA%E4%BB%80%E4%B9%88%E5%AD%98%E5%9C%A8%E8%BF%99%E4%B8%AA%E6%A8%A1%E5%9D%97).   
参阅 [这里](https://github.com/Astoritin/RmPIFProps/?tab=readme-ov-file#why-this-module-exists--%E4%B8%BA%E4%BB%80%E4%B9%88%E5%AD%98%E5%9C%A8%E8%BF%99%E4%B8%AA%E6%A8%A1%E5%9D%97)。
### What does this module do? | 这个模块是干什么的？
In short, it's a cleanup tool.   
It's specifically designed to remove those invalid property values (PiHooks/PixelProps/PlayIntegrityFix related) that were forcibly written by the ROM and cannot be cleared otherwise. Especially after Play Integrity rule/API updates, the original integrated components often become obsolete, but their "footprints" remain. This module helps erase those footprints.   
**After flashing, a reboot is highly recommended to clear any potential "Property modified (10)" errors that may occur due to the property partition being modified by resetprop.**   
   
简单来说，这个模块是一个 “清理工具”。   
它专门用于处理那些被 ROM 强行写入、又无法自行清除的 PiHooks/PixelProps/PlayIntegrityFix 相关的无效属性值。尤其是在 Play Integrity API更新并生效后，原先的组件可能已经失效，但它们留下的“脚印”却还在——这个模块就是来帮你擦掉这些脚印的。   
**建议刷入后重新启动一次，以避免由于property区被resetprop修改导致的 Property modified (10)。**
### A Call for Better Practices | 姑且呼吁一些东西
See [here](https://github.com/Astoritin/RmPIFProps/?tab=readme-ov-file#a-call-for-better-practices--%E5%A7%91%E4%B8%94%E5%91%BC%E5%90%81%E4%B8%80%E4%BA%9B%E4%B8%9C%E8%A5%BF).   
参阅 [这里](https://github.com/Astoritin/RmPIFProps/?tab=readme-ov-file#a-call-for-better-practices--%E5%A7%91%E4%B8%94%E5%91%BC%E5%90%81%E4%B8%80%E4%BA%9B%E4%B8%9C%E8%A5%BF)。
### Credits | 鸣谢
- [Magisk](https://github.com/topjohnwu/Magisk) - the foundation which makes everything possible | 让一切成为可能的基石
- [LSPosed](https://github.com/LSPosed/LSPosed) - the implementation of function root solution check and extract | Root方案检测函数和解压函数的实现
- [Zygisk Next](https://github.com/Dr-TSNG/ZygiskNext) - the implementation of function root solution check | Root方案检测函数和解压函数的实现

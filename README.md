# st - simple terminal

## 安装

sudo make clean install

## Nix Flake
下面是在 nixos configuration 中使用它的示例
```nix 
{
  description = "My configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dwm.url = "github:yaocccc/st";
  };

  outputs = { nixpkgs, st, ... }:
    {
      nixosConfigurations = {
        hostname = nixpkgs.lib.nixosSystem
          {
            system = "x86_64-linux";
            modules = [
              {
                nixpkgs.overlays = [ st.overlays.default ];
                environment.systemPackages = with pkgs;[
                  st
                  tabbed # 多tab支持
                ];
              }
            ];
          };
      };
    };
}
```

## 如果你想使用多tab能力

可参考 [https://github.com/yaocccc/tabbed](https://github.com/yaocccc/tabbed)

## 补丁

- st-alpha-0.8.2.diff `可设置透明度 且可用 -A float 导入透明度`
- st-anysize-0.8.1.diff `任意尺寸`
- st-appsync-20200618-b27a383.diff `减少刷新同步`
- st-boxdraw_v2-0.8.3.diff `去除字体间隙 例如制表符`
- st-colors-at-launch-0.8.4.diff `启动时可自定义颜色 例如 -C '#123456@3' 定义`
- st-hidecursor-0.8.1.diff `输入时隐藏光标`
- st-ligatures-boxdraw-20200430-0.8.3.diff `连体字`
- st-scrollback-20190331-21367a0.diff `缓冲区滚动`

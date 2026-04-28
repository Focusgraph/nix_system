{ inputs, ... }:
{
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.llama-cpp = {
    enable = true;
    package = inputs.llama-cpp.packages.x86_64-linux.vulkan;
    port = 11000;
    modelsDir = "/storage/Models/";
    extraFlags = [
      "--ctx-size 8000"
    ];
  };
}

This package includes CPU and Vulkan backends, without CUDA or ROCm.
For AMD GPU acceleration, install mesa-vulkan-radeon and ensure your user
has access to /dev/dri/renderD* (normally through the render group).

Start the server with: ollama serve
Then run models from another terminal with: ollama run <model>

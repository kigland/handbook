# KigLand 知识库

## 部署流程

本项目使用 GitHub Actions 自动部署到 GitHub Pages 和华为云对象存储服务（OBS）。

### 部署工作流程

当代码推送到 `main` 分支时，会触发以下自动部署流程：

1. 安装最新版本的 mdbook
2. 构建静态网站
3. 部署到 GitHub Pages
4. 使用华为云 OBS SDK 将文件上传到华为云存储

### 配置华为云 OBS 部署

要启用华为云 OBS 部署功能，需要在 GitHub 仓库中设置以下 Secrets：

1. `S3_ACCESS_KEY` - 华为云 OBS 的访问密钥（AK）
2. `S3_SECRET_KEY` - 华为云 OBS 的秘密访问密钥（SK）
3. `S3_REGION` - 华为云区域名称（例如 `cn-east-3`）
4. `S3_ENDPOINT_URL` - 华为云 OBS 的服务端点（例如 `https://obs.cn-east-3.myhuaweicloud.com`）
5. `S3_BUCKET_NAME` - 华为云 OBS 存储桶名称（必须提前在华为云控制台创建）

可以在 GitHub 仓库的 Settings → Secrets and variables → Actions 页面中添加这些 secrets。

**技术说明**：

1. 部署流程使用华为云官方 OBS Python SDK（`esdk-obs-python`）进行文件上传，而不是使用 AWS CLI：
   - 解决了 S3 协议兼容性问题
   - 提供更好的错误处理和兼容性
   - 可以准确检测存储桶是否存在

2. 上传过程会：
   - 跳过 `.git` 目录和不兼容的文件类型（字体文件等）
   - 保持文件目录结构不变
   - 提供详细的上传状态和错误信息

3. 华为云 OBS 使用准备：
   - 在华为云控制台创建 OBS 存储桶
   - 确保 AK/SK 有正确的读写权限
   - 如需公开访问，需要在华为云控制台配置桶的访问权限
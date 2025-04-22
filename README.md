# KigLand 知识库

## 部署流程

本项目使用 GitHub Actions 自动部署到 GitHub Pages 和兼容 S3 协议的对象存储服务。

### 部署工作流程

当代码推送到 `main` 分支时，会触发以下自动部署流程：

1. 安装最新版本的 mdbook
2. 构建静态网站
3. 部署到 GitHub Pages
4. 使用 AWS CLI 将文件上传到兼容 S3 的对象存储服务

### 配置对象存储部署

要启用对象存储部署功能，需要在 GitHub 仓库中设置以下 Secrets：

1. `S3_ACCESS_KEY` - 对象存储服务的访问密钥（AK）
2. `S3_SECRET_KEY` - 对象存储服务的秘密访问密钥（SK）
3. `S3_REGION` - 区域名称（例如 `cn-east-3`）
4. `S3_ENDPOINT_URL` - 对象存储服务的端点（例如 `https://obs.cn-east-3.myhuaweicloud.com`）
5. `S3_BUCKET_NAME` - 存储桶名称（必须提前创建）

可以在 GitHub 仓库的 Settings → Secrets and variables → Actions 页面中添加这些 secrets。

**部署流程说明**：

1. 部署流程使用标准 AWS CLI 与兼容 S3 的存储服务通信：
   - 安装最新版本的 AWS CLI
   - 进行验证，确保存储桶存在和可访问
   - 提供详细的进度显示

2. 每次部署前会：
   - 清空目标存储桶中的所有现有文件
   - 排除不需要的文件（如 `.git` 目录）
   - 使用 `--debug` 参数显示详细上传过程和进度

3. 如果对接华为云 OBS 或其他 S3 兼容服务，请确保：
   - 存储桶已创建并配置正确的访问权限
   - 区域和端点 URL 与服务提供商的文档一致
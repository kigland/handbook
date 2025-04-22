# KigLand 知识库

## 部署流程

本项目使用 GitHub Actions 自动部署到 GitHub Pages 和 S3 兼容的对象存储服务。

### 部署工作流程

当代码推送到 `main` 分支时，会触发以下自动部署流程：

1. 安装最新版本的 mdbook
2. 构建静态网站
3. 部署到 GitHub Pages
4. 同步部署到 S3 兼容的对象存储服务

### 配置部署到 S3

要启用 S3 部署功能，需要在 GitHub 仓库中设置以下 Secrets：

1. `S3_ACCESS_KEY` - S3 兼容服务的访问密钥
2. `S3_SECRET_KEY` - S3 兼容服务的秘密密钥
3. `S3_REGION` - S3 服务的区域
4. `S3_ENDPOINT_URL` - S3 兼容服务的 API 端点 URL
5. `S3_BUCKET_NAME` - 要部署到的存储桶名称

可以在 GitHub 仓库的 Settings → Secrets and variables → Actions 页面中添加这些 secrets。
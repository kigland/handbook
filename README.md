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
3. `S3_REGION` - S3 服务的区域名称（对于某些第三方服务，可使用其建议的区域值）
4. `S3_ENDPOINT_URL` - S3 兼容服务的 API 端点 URL（完整的服务端点 URL，例如 `https://obs.cn-north-4.myhuaweicloud.com`）
5. `S3_BUCKET_NAME` - 要部署到的存储桶名称（确保此存储桶已经创建且有写入权限）

可以在 GitHub 仓库的 Settings → Secrets and variables → Actions 页面中添加这些 secrets。

**注意事项**：

1. 工作流配置已针对第三方 S3 兼容服务（如华为云 OBS）进行了优化：
   - 直接配置 AWS CLI 凭证而不使用标准 AWS 验证流程
   - 使用 `--endpoint-url` 参数指定服务端点
   - 使用 `--no-verify-ssl` 参数避免 SSL 验证问题
   
2. 为避免上传错误，工作流会：
   - 先测试桶是否存在和可访问
   - 排除可能导致问题的文件类型（.git、字体文件等）
   
3. 如果使用华为云 OBS，请确保：
   - 存储桶已创建并可访问
   - 权限配置允许写入操作
   - S3_BUCKET_NAME 参数正确匹配您的存储桶名称
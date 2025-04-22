# KigLand 知识库

## 部署流程

本项目使用 GitHub Actions 自动部署到 GitHub Pages 和兼容 S3 协议的对象存储服务。

### 部署工作流程

当代码推送到 `main` 分支时，会触发以下自动部署流程：

1. 安装最新版本的 mdbook
2. 构建静态网站
3. 部署到 GitHub Pages
4. 使用 rclone 将文件上传到兼容 S3 的对象存储服务

### 配置对象存储部署

要启用对象存储部署功能，需要在 GitHub 仓库中设置以下 Secrets：

1. `S3_ACCESS_KEY` - 对象存储服务的访问密钥（AK）
2. `S3_SECRET_KEY` - 对象存储服务的秘密访问密钥（SK）
3. `S3_ENDPOINT_URL` - 对象存储服务的完整端点URL（包含https://前缀）
4. `S3_BUCKET_NAME` - 存储桶名称（必须提前创建）

可以在 GitHub 仓库的 Settings → Secrets and variables → Actions 页面中添加这些 secrets。

**部署流程说明**：

1. 部署流程使用 rclone 工具与兼容 S3 的存储服务通信：
   - rclone 是一个强大的文件同步工具，支持多种云存储服务
   - 正确处理文件元数据和内容类型（Content-Type）
   - 设置恰当的 Content-Disposition 头信息

2. 每次部署过程会：
   - 自动测试存储桶连接
   - 使用 `--delete-after` 参数删除旧版本文件
   - 应用自定义 MIME 类型映射确保正确的内容类型
   - 设置 `Content-Disposition=inline` 确保文件在浏览器中正确显示

3. 如果对接华为云 OBS 或其他 S3 兼容服务，请确保：
   - 存储桶已创建并配置正确的访问权限
   - 如需公开访问，确保存储桶已设置为公共读取权限
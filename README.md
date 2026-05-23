# DigitLink推广Agent

🤖 **一键安装的AI推广Agent** - 社交媒体涨粉引流专家

## 功能特性

- 🚀 **多平台运营**: TikTok / Instagram / Facebook
- 📊 **竞品监控**: 自动追踪竞争对手动态
- ✍️ **文案创作**: AI生成英文推广文案
- 🎬 **视频生成**: AI视频制作
- ⏰ **定时发布**: 自动按计划发布内容
- 📈 **数据分析**: 追踪涨粉和互动数据

## 快速开始

### 1. 一键安装

```bash
hermes profile install github.com/opendigitlink/digitlink-promoter --alias digitlink
```

### 2. 配置环境变量

```bash
cd ~/.hermes/profiles/digitlink
cp .env.example .env
nano .env  # 填入你的API Keys
```

### 3. 启动Agent

```bash
digitlink chat
```

## 必填配置

| 变量名 | 说明 | 获取方式 |
|--------|------|----------|
| OPENROUTER_API_KEY | 多模型API | [openrouter.ai/keys](https://openrouter.ai/keys) |
| DIGITLINK_EMAIL | DigitLink账号 | 注册 [digitlink.mobi](https://digitlink.mobi) |
| DIGITLINK_PASSWORD | DigitLink密码 | 同上 |

## 可选配置

| 变量名 | 说明 |
|--------|------|
| TELEGRAM_BOT_TOKEN | 接收任务通知 |
| TIKTOK_USERNAME/PASSWORD | TikTok账号 |
| INSTAGRAM_USERNAME/PASSWORD | Instagram账号 |

## 推广策略

### 内容类型
1. 教程类 - AI工具使用技巧
2. 对比类 - 工具对比测评
3. 技巧类 - 效率提升小技巧
4. 资源类 - 免费工具推荐

### 涨粉技巧
- 保持一致发帖频率
- 使用热门话题标签
- 回复所有评论
- 发布时间：美国东部晚6-9点

## 更新Agent

```bash
hermes profile update digitlink
```

## 卸载

```bash
hermes profile delete digitlink --yes
```

## 技术架构

- **Hermes Agent**: 核心AI系统
- **Profile Distribution**: 配置分发
- **Playwright**: 浏览器自动化
- **OpenRouter**: 多模型API

## 许可证

MIT License

## 支持

- 官网: [digitlink.mobi](https://digitlink.mobi)
- 问题反馈: GitHub Issues

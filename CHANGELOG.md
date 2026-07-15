# 变更记录

只记录已经实际进入项目的功能、修复和重要变更。

## 未发布

### 新增

- 创建 `xiangmu-chixu-guanli` Codex Skill。
- 增加独立拼音仓库创建规则和详细 README 要求。
- 增加长期项目检查点、项目记忆、里程碑和安全交接流程。
- 增加五份项目文档模板和 PowerShell 验证脚本。
- 增加 Codex UI 元数据和用户级安装方式。

### 变更

- 强制创建模式在现有仓库之外建立独立目录、独立 Git 仓库和新的 GitHub 仓库。
- PowerShell 验证脚本运行时消息改用 ASCII，以兼容 Windows PowerShell 5。

### 修复

- 修复 UI 简介长度不足导致的元数据生成失败。
- 修复 Windows 默认 Python 和 PowerShell 编码造成的中文文件读取问题。

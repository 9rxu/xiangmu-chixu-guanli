# 项目记忆

- 项目名称：项目持续管理 Skill
- GitHub 仓库名称：`xiangmu-chixu-guanli`
- 仓库地址：`https://github.com/9rxu/xiangmu-chixu-guanli`
- 当前分支：`main`
- 当前阶段：首次公开发布
- 最近更新：2026-07-15

## 总体目标

提供可重复调用的 Codex Skill，让新项目拥有独立拼音仓库、详细项目介绍和可跨会话恢复的状态文档，并让已有项目能够安全接管、检查点保存和交接。

## 当前状态

- 已完成：核心 Skill、创建与交接参考规则、五份项目模板、UI 元数据和 PowerShell 验证脚本。
- 进行中：创建并验证独立公开 GitHub 仓库。
- 未完成：在真实新项目任务中进行首次用户验收。

## 问题与决定

- 已知问题：新安装 Skill 可能需要重新加载 Codex；中文多音字可能需要人工确认。
- 技术债务：尚无跨平台 Shell 验证脚本。
- 关键决定：创建模式必须使用现有仓库之外的独立目录、独立 `.git` 和新 GitHub 仓库；验证脚本运行时消息采用 ASCII 以兼容 Windows PowerShell 5。

## 验证与版本

- 最近验证：官方 `quick_validate.py`、自定义 Skill 校验、PowerShell 解析和临时独立 Git 仓库演练均通过。
- 最新有效提交：首次提交后记录。
- 远程状态：创建与首次推送完成后复核。

## 接手指引

- 下一步第一项工作：使用 Skill 创建一个真实但低风险的新项目，检查拼音命名、详细 README 和远程验证报告。
- 优先阅读：`AGENTS.md`、`README.md`、`PLANS.md`、`CHANGELOG.md`、`.codex/skills/xiangmu-chixu-guanli/SKILL.md`
- 不要重复或随意修改：不要放宽独立仓库、安全 Git、敏感信息和真实验证边界。

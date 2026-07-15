# 项目持续管理 Skill

- 仓库名称：`xiangmu-chixu-guanli`
- 当前状态：可用，持续维护
- Skill 调用名称：`$xiangmu-chixu-guanli`

## 项目介绍

这是一个面向 Codex 长期项目的持续管理 Skill。它负责创建独立的拼音命名 GitHub 仓库，建立项目记忆、里程碑计划、变更记录和 Agent 工作规则，并在阶段完成、任务中断或工作环境切换时执行安全检查点与交接。

项目的核心目标是让代码、计划、决定和下一步保存在仓库中，而不是只存在于某个聊天、账号、模型或浏览器会话里。

## 项目背景

长期任务经常跨越多个 Codex 会话，也可能在不同账号、设备、模型或 Agent 之间切换。如果项目状态只保存在聊天记录中，接手者很难准确判断当前进度，容易重复工作、遗漏文件或覆盖已有修改。

本 Skill 把 GitHub 仓库作为可恢复的项目事实来源，并为创建新项目、接管已有项目、阶段保存和最终交接提供统一流程。

## 项目目标

- 近期：稳定支持独立仓库创建、拼音命名、标准文档初始化和安全交接。
- 首个完整版本：通过真实项目验证创建、接管、阶段提交和中断恢复流程。
- 长期：根据实际使用反馈完善跨平台验证、更多 Git 托管平台适配和可选项目模板。

## 目标用户

- 使用 Codex 进行长期开发或自动化工作的个人用户。
- 需要频繁切换账号、设备、模型或 Agent 的项目维护者。
- 希望每个项目都具有清晰 README、开发计划和交接记录的团队。

## 核心功能

### 已完成

- 创建模式强制使用现有仓库之外的独立目录、独立 `.git` 和新的 GitHub 仓库。
- 根据中文项目名称生成小写、短横线分隔的完整拼音仓库名。
- 生成详细 GitHub 简介和 README，区分已完成、开发中与计划中功能。
- 初始化 `AGENTS.md`、`PROJECT_MEMORY.md`、`PLANS.md` 和 `CHANGELOG.md`。
- 在里程碑、上下文过长、额度临近或会话结束时执行项目检查点。
- 保护用户未提交修改，禁止强推、覆盖仓库和提交敏感信息。
- 提供 Skill 包和项目连续性 PowerShell 验证脚本。

### 开发中

- 收集不同技术栈和长期任务中的实际使用反馈。

### 计划中

- 增加更多跨平台验证方式。
- 增加可选的项目类型模板，同时保持核心 Skill 精简。

## 使用场景

### 创建独立新项目

```text
请使用 $xiangmu-chixu-guanli 创建一个新的长期项目。

项目中文名称：个人日记系统
项目详细构想：创建一个用于长期管理个人日记的安卓应用。
仓库可见性：私有

必须创建独立项目目录、独立 Git 仓库和新的 GitHub 仓库，不要放进当前仓库。
```

### 接管已有项目

```text
请使用 $xiangmu-chixu-guanli 接管当前项目。

先阅读项目规则、项目记忆、开发计划、变更记录和 README，检查当前分支、最近提交、未提交修改及远程状态，然后从记录的下一步继续。
```

## 技术方案

- Skill 格式：Codex `SKILL.md` 与 `agents/openai.yaml`
- 工作流与模板：Markdown
- 验证脚本：PowerShell
- 版本管理：Git
- 远程托管：GitHub，可通过 GitHub CLI 执行已授权操作

Skill 使用渐进式信息加载：核心执行顺序保存在 `SKILL.md`，详细创建和交接规则放在 `references/`，输出模板放在 `assets/`。

## 项目结构

```text
.
├── .codex/skills/xiangmu-chixu-guanli/
│   ├── SKILL.md
│   ├── agents/openai.yaml
│   ├── assets/
│   ├── references/
│   └── scripts/validate-project-continuity.ps1
├── AGENTS.md
├── PROJECT_MEMORY.md
├── PLANS.md
├── CHANGELOG.md
└── README.md
```

## 安装与运行

将完整 Skill 目录复制到用户级 Codex Skill 目录：

```powershell
$source = '.\.codex\skills\xiangmu-chixu-guanli'
$destination = Join-Path $env:USERPROFILE '.codex\skills\xiangmu-chixu-guanli'
Copy-Item -LiteralPath $source -Destination $destination -Recurse
```

如果目标目录已存在，请先比较内容，不要直接覆盖用户修改。安装后新建 Codex 任务或重新加载，使 Skill 列表刷新。

## 测试与验证

验证 Skill 元数据和目录：

```powershell
$creator = Join-Path $env:USERPROFILE '.codex\skills\.system\skill-creator'
python (Join-Path $creator 'scripts\quick_validate.py') '.\.codex\skills\xiangmu-chixu-guanli'
powershell -File '.\.codex\skills\xiangmu-chixu-guanli\scripts\validate-project-continuity.ps1' -SkillRoot '.\.codex\skills\xiangmu-chixu-guanli'
```

验证由 Skill 创建的项目：

```powershell
powershell -File '.\.codex\skills\xiangmu-chixu-guanli\scripts\validate-project-continuity.ps1' -ProjectRoot .
```

## 当前进度

Skill 核心规则、参考文档、模板、UI 元数据和验证脚本已经完成，并通过官方 Skill 校验、自定义结构校验和临时独立 Git 仓库演练。

## 开发计划

详见 `PLANS.md`。下一阶段是使用真实项目检验触发准确性、文档质量和跨会话接手体验。

## 已知问题

- Windows PowerShell 5 对无 BOM UTF-8 脚本的中文解析不稳定，因此验证脚本的运行时消息使用 ASCII。
- 新安装的 Skill 通常需要新建任务或重新加载 Codex 后才会出现在 Skill 列表中。
- 中文多音字或专有名词存在实质歧义时仍需用户确认读音。

## 项目文档

- `AGENTS.md`：本仓库长期工作规则。
- `PROJECT_MEMORY.md`：当前状态和下一位 Agent 的接手入口。
- `PLANS.md`：里程碑、验收标准与验证方式。
- `CHANGELOG.md`：实际进入仓库的变更。

## 贡献与开发规范

修改前先阅读上述项目文档。保持 `SKILL.md` 精简，把详细规则放到一层深度的 references 中；新增或修改脚本后必须实际运行验证。提交前检查差异和敏感信息，不强制推送或覆盖用户工作。

## 许可证

本项目暂未确定开源许可证。在许可证确定之前，不代表授权他人复制、修改或分发本项目。

## 项目维护状态

项目处于可用并持续维护状态。当前重点是验证真实长期项目中的可靠性，而不是扩展无关功能。

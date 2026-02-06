---
   title: Python Poetry 包管理标准接入方案
   date: 2026-02-06
   categories:
     - Python开发
     - 工具教程
   tags:
     - Poetry
     - 依赖管理
     - Python工程化
---

# Python Poetry 包管理标准接入方案

## 1. 目标

建立一套 **依赖可控、环境隔离、版本可锁定、可发布、可复现** 的 Python
项目包管理规范，适用于个人项目与团队级工程。

------------------------------------------------------------------------

## 2. 适用范围

-   Web API（FastAPI / Django）
-   Python SDK / 工具库
-   数据工程 / AI 项目
-   企业级 Python 工程

------------------------------------------------------------------------

## 3. 核心能力

-   依赖管理与版本锁定
-   虚拟环境自动隔离
-   多环境分组（dev / prod / test）
-   可复现安装
-   CI / CD 集成
-   PyPI / 私有仓库发布

------------------------------------------------------------------------

## 4. 安装 Poetry

``` bash
pip install poetry
poetry --version
```

------------------------------------------------------------------------

## 5. 创建标准项目

``` bash
poetry new my_project
cd my_project
```

目录结构：

    my_project/
    ├── pyproject.toml
    ├── poetry.lock
    ├── src/
    │   └── my_project/
    │       └── __init__.py
    ├── tests/
    └── README.md

------------------------------------------------------------------------

## 6. pyproject.toml 标准模板

``` toml
[tool.poetry]
name = "my_project"
version = "0.1.0"
description = "Poetry Managed Project"
authors = ["Your Name"]

[tool.poetry.dependencies]
python = "^3.10"
requests = "^2.31.0"

[tool.poetry.group.dev.dependencies]
pytest = "^7.4"
black = "^24.0"
ruff = "^0.4"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

------------------------------------------------------------------------

## 7. 依赖管理流程

### 添加依赖

``` bash
poetry add fastapi
poetry add pytest --group dev
```

### 更新依赖

``` bash
poetry update
```

### 删除依赖

``` bash
poetry remove requests
```

------------------------------------------------------------------------

## 8. 虚拟环境管理

``` bash
poetry install
poetry shell
poetry run python main.py
```

------------------------------------------------------------------------

## 9. 锁定依赖版本

``` bash
poetry lock
```

生成 `poetry.lock`，用于环境一致性保障。

------------------------------------------------------------------------

## 10. 环境分组管理

``` toml
[tool.poetry.group.dev.dependencies]
pytest = "^7.4"

[tool.poetry.group.prod.dependencies]
gunicorn = "^21.0"
```

安装指定环境：

``` bash
poetry install --with dev
```

------------------------------------------------------------------------

## 11. 可复现部署（CI / Server）

``` bash
poetry install --no-root --sync
```

导出 requirements.txt：

``` bash
poetry export -f requirements.txt --without-hashes
```

------------------------------------------------------------------------

## 12. 代码质量与安全

``` bash
poetry add black ruff mypy --group dev
poetry run ruff check .
poetry run mypy .
```

安全扫描：

``` bash
pip install pip-audit
pip-audit
```

------------------------------------------------------------------------

## 13. 构建与发布 PyPI

### 构建包

``` bash
poetry build
```

### 发布包

``` bash
poetry publish
```

------------------------------------------------------------------------

## 14. CI 示例（GitHub Actions）

``` yaml
name: Python CI

on: [push]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: "3.10"
      - run: pip install poetry
      - run: poetry install
      - run: poetry run pytest
```

------------------------------------------------------------------------

## 15. 企业级推荐增强

  能力            推荐
  --------------- -------------------------
  私有仓库        Nexus / GitHub Packages
  高速安装        uv + Poetry
  多包 Monorepo   Poetry Workspace
  依赖审计        pip-audit
  自动发布        GitHub Actions

------------------------------------------------------------------------

## 16. 标准接入流程（Checklist）

1.  安装 Poetry\
2.  初始化项目\
3.  配置 pyproject.toml\
4.  添加依赖\
5.  生成 lock 文件\
6.  提交版本控制\
7.  配置 CI\
8.  发布 PyPI / 私有仓库

------------------------------------------------------------------------

## 17. 推荐命令速查表

``` bash
poetry new project
poetry add package
poetry install
poetry shell
poetry lock
poetry build
poetry publish
```

------------------------------------------------------------------------

## 18. 维护规范

-   必须提交 `poetry.lock`
-   禁止直接 pip install
-   CI 必须使用 poetry install
-   版本升级需变更日志

------------------------------------------------------------------------

## 19. 结论

Poetry 是当前 Python
生态中最现代、可靠、可扩展的包管理解决方案，适用于个人开发、团队协作与商业级交付。

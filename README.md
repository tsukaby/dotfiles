# dotfiles

## Setup

### 1. Homebrew をインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. このリポジトリをクローン

```bash
git clone <repo-url> ~/IdeaProjects/dotfiles
cd ~/IdeaProjects/dotfiles
```

### 3. セットアップスクリプトを実行

```bash
./setup.sh
```

シンボリックリンクを作成して以下を配置します:

- `~/.gitconfig`
- `~/.gitignore_global`
- `~/.zshrc`
- `~/.emacs`
- `~/.config/starship.toml`
- `~/.config/mise/config.toml`
- `~/.claude/settings.json`
- `~/Brewfile`

### 4. Homebrew パッケージを一括インストール

```bash
brew bundle --file=~/Brewfile
```

VS Code 拡張も含めて全パッケージがインストールされます。

### 5. mise でランタイムをインストール

```bash
mise install
```

`~/.config/mise/config.toml` に定義された go, node, python, ruby がインストールされます。

### Brewfile の更新

パッケージを追加・削除した後に Brewfile を更新するには:

```bash
brew bundle dump --file=~/IdeaProjects/dotfiles/Brewfile --force
```

### mise の管理

ツールの追加・バージョン変更:

```bash
mise use -g python@latest    # グローバル設定を更新
mise use -g ruby@3.4.3       # 特定バージョンを指定
```

変更は `~/.config/mise/config.toml`（= dotfiles の `mise-config.toml`）に反映されます。

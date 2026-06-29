# dotfiles

macOS 與 Linux 共用的 shell、Git、Vim 與 tmux 設定。

## 安裝

```sh
cd ~
git clone git@github.com:chronolai/dotfiles.git .dotfiles
cd .dotfiles
./setup.sh
```

`setup.sh` 會：

1. 將 shell、Git、Vim、tmux 設定 symlink 到 `$HOME`。
2. 更新 dotfiles repository。
3. 執行 `setup-git.sh` 建立預設 Git profile。
4. 安裝 Vim plugins。

安裝前請先備份既有設定；下列 `$HOME` 檔案可能被 symlink 取代：

```text
.bash_profile  .bashrc  .profile  .shellrc
.zprofile      .zshrc   .gitconfig  .gitignore
.vimrc         .tmux.conf
```

`setup.sh` 會從自身位置建立 symlink；目前 `.gitconfig` 的 `diff-highlight` pager 仍以 `~/.dotfiles` 為預設位置，因此建議沿用上面的 clone path。

## Shell 設定

共用設定依用途拆分：

| 入口 | 共用設定 | 用途 |
| --- | --- | --- |
| `.zprofile`、`.bash_profile` | `.profile` | login shell 環境、Homebrew、FZF 環境變數 |
| `.zshrc`、`.bashrc` | `.shellrc` | interactive shell aliases |

`.bash_profile` 會額外載入 `.bashrc`，因為 Bash login shell 不會自動讀取它；Zsh login interactive shell 會自行依序讀取 `.zprofile` 與 `.zshrc`。

平台差異集中在共用檔：

- macOS：載入 Homebrew shell environment，使用 BSD `ls`。
- Linux：`ll` 使用 GNU `ls --color=auto`。
- Zsh：載入 Oh My Zsh 與 `~/.fzf.zsh`。
- Bash：載入 `~/.fzf.bash`。

## Git profiles

`.gitconfig` 不保存 identity，而是固定載入本機的 `~/.gitprofile`。實際的 `user.name`、`user.email` 與工作目錄不會進入此 repository。

### 預設 profile

`setup.sh` 會自動執行以下命令，也可單獨執行：

```sh
./setup-git.sh
```

它會建立：

```text
~/.gitprofile
~/.gitprofile.default
```

執行時會詢問 `user.name` 與 `user.email`。已有設定時，直接按 Enter 會沿用顯示的值。

### 目錄專用 profile

傳入自訂 profile 名稱：

```sh
./setup-git.sh work
```

腳本會詢問 identity 與 gitdir，並建立 `~/.gitprofile.work`。再次執行相同命令可更新 identity、沿用既有目錄，或加入另一個 gitdir。

`includeIf gitdir` 比對的是 repository 的 `.git` 路徑，因此必須在實際 Git repository 內驗證：

```sh
cd ~/projects/work/example-repository
git rev-parse --absolute-git-dir
git config --show-origin --get user.name
git config --show-origin --get user.email
```

## Global Git ignore

`.gitignore` 同時作為 `core.excludesFile`，會套用到所有 repositories。內容整合自 GitHub 官方 Global templates：

- [macOS](https://github.com/github/gitignore/blob/main/Global/macOS.gitignore)
- [Linux](https://github.com/github/gitignore/blob/main/Global/Linux.gitignore)
- [Vim](https://github.com/github/gitignore/blob/main/Global/Vim.gitignore)

專案特有的 dependencies、build outputs 與環境檔案仍應由各 repository 自己的 `.gitignore` 管理。

## 其他設定

- `.vimrc`：Vim 與 NeoBundle 設定。
- `.tmux.conf`：tmux 設定。
- `.gitconfig`：Git aliases、diff、pull 與 pager 設定。

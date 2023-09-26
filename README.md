# kickstart.nvim

This is my fork of the kickstart neovim project. **[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim
)** is a simple default Neovim configuration and a great way to start creating a custom config.


### Plugins

> Since I customized the DAP and autopairs configs I moved them to `custom/plugins` and kept the kickstart version disabled in `init.lua`.

This is a list of plugins added on top of kickstart.nvim:
* **autopairs**
* **DAP**
  * *Dependencies:* netcoredbg
* **lsp-format** 
  * A formatting tool.
  * *Dependencies:* Prettier, CSharpier
* **neotree.lua**

### Installation

Build neovim:
```sh
git clone git@github.com:neovim/neovim.git
cd neovim
make
sudo install
```
more [here](https://github.com/neovim/neovim#install-from-source).

Clone kickstart.nvim:

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

Requirements:
* Make sure to review the readmes of the plugins if you are experiencing errors. In particular:
  * [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
### Post Installation

Run the following command and then **you are ready to go**!

```sh
nvim --headless "+Lazy! sync" +qa
```



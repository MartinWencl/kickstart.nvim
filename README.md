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
sudo make install
```
more [here](https://github.com/neovim/neovim#install-from-source).
``

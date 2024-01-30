# kickstart.nvim

This is my fork of the kickstart neovim project. **[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim
)** is a simple default Neovim configuration and a great way to start creating a custom config.


### Organization

I have changed the basic kickstart file organization, deleted the `lua/kickstart` and `lua/plugins` folders, and just use `/lua`. All plugins are in `/lua/plugins`. 

### Installation

Build neovim:
more [here](https://github.com/neovim/neovim#install-from-source).
```sh
git clone git@github.com:neovim/neovim.git
cd neovim
make
sudo make install
```
Clone this config:
```bash
git clone git@github.com:MartinWencl/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

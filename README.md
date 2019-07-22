# webpack-watcher-vim
You can run webpack and check build log from vim.

![screenshot1](https://github.com/ta-daiki/webpack-watcher-vim/blob/master/doc/webpack-watcher-screenshot.jpg?raw=true)

## Usage
1. Set g:webpack_watcher_cmd_path in your .vimrc (see. [Configuration](#configuration))

2. Exec :WebpackRun command.
    ```
    :WebpackRun arg
    ```
    arg is your webpack config filepath

3. :WebpackEcho command shows latest build message.
    ```
    :WebpackEcho
    ```

## Configuration
Global variable "webpack_watcher_cmd_path" must be set in your .vimrc.

Example)
```
let g:webpack_watcher_cmd_path = substitute(system('npm bin') . '/webpack', '\r\?\n', '', 'g')
```

# webpack-watcher-vim
You can run webpack and check build log from vim.

![screenshot1](https://github.com/ta-daiki/webpack-watcher-vim/blob/master/doc/webpack-watcher-screenshot.jpg?raw=true)

## Usage
1. Set g:webpack_watcher_run_cmd in your .vimrc (see. [Configuration](#configuration))

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
Global variable "webpack_watcher_run_cmd" must be set in your .vimrc.

Example 1)
```
let g:webpack_watcher_run_cmd = 'npm run webpack'
```

Example 2)
```
let g:webpack_watcher_run_cmd = join([$HOME, 'node_modules', '.bin', 'webpack'], '/') . ' --watch --progress --config'
```

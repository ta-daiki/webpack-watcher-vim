if exists('g:loaded_webpack_watcher')
    finish
endif

let g:loaded_webpack_watcher = 1

if !exists('g:webpack_watcher_run_cmd')
    let g:webpack_watcher_cmd_path = ''
endif

command! -nargs=1 -complete=file WebpackRun call webpack_watcher#main#run_with_config(<f-args>)
command! -nargs=0 WebpackEcho call webpack_watcher#main#echo_last_build_message()

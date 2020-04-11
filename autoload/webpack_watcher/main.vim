let s:last_build_message_list = []
let s:last_webpack_message_list = []
let s:config_file_path2job_id = {}

function! s:get_job_cmd(config_path)
    if !executable(g:webpack_watcher_cmd_path)
        echo 'g:webpack_watcher_cmd_path is undefined.'
        return
    endif

    if strlen(g:webpack_watcher_cmd_path) == 0
        echo 'g:webpack_watcher_run_cmd is empty.'
        return
    endif

    let l:run_cmd = [
                \ g:webpack_watcher_cmd_path,
                \ '--watch',
                \ '--config',
                \ a:config_path
                \ ]

    return join(l:run_cmd, ' ')
endfunction

function! webpack_watcher#main#run_with_config(config_path) abort
    if strlen(a:config_path) == 0
        echo 'webpack config file path is required.'
        return
    endif

    if get(s:config_file_path2job_id, a:config_path, 0)
        return
    endif

    function! s:job_callback(job_id, data, name) abort
        echo 'Run webpack build!'

        let s:last_webpack_message_list = []

        for l:text in a:data
            if l:text =~ '^Hash:'
                let s:last_build_message_list = []
            endif

            if l:text =~ '^ERROR'
                echo 'Failed to webpack build!'
            endif

            call add(s:last_build_message_list, l:text)
            call add(s:last_webpack_message_list, l:text)
        endfor
    endfunction

    let l:job_cmd = s:get_job_cmd(a:config_path)

    if strlen(l:job_cmd) == 0
        return
    endif

    let l:job_id = jobstart(
        \ l:job_cmd, {
        \   'on_stdout': function('s:job_callback'),
        \   'on_exit': { -> remove(s:config_file_path2job_id, a:config_path) },
        \ })

    let s:config_file_path2job_id[a:config_path] = l:job_id

    return
endfunction

function! webpack_watcher#main#echo_last_build_message()
    let l:message_list = len(s:last_build_message_list) ? s:last_build_message_list : s:last_webpack_message_list
    echo join(l:message_list, "\n")
endfunction

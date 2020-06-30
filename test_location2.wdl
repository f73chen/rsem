workflow test_location {
    call find_tools
}

task find_tools {
    command <<<
        ls -l /data/HG38_RSEM_INDEX_ROOT/hg38_random_rsem
        echo "@@@@@@@@@@@@@"
    >>>
    output{
        String message = read_string(stdout())
    }
    runtime {
        docker: "g3chen/rsem@sha256:dc6358a8e6ccd29b7ccee4f5f8d36d3ba71e7f2164cda5009516f9cf76e3fa54"
    }
}

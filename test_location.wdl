workflow test_location {
    call find_tools
}

task find_tools {
    command {
        ls $RSEM_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $BOWTIE_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $PYTHON_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $RSTATS_CAIRO_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $JAVA_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $BIOCONDUCTOR_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $RSTATS_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $PERL_ROOT
        echo "@@@@@@@@@@@@@@@@"

        echo $PATH
        echo "################"
        echo $MANPATH
        echo "################"
        echo $LD_LIBRARY_PATH
        echo "################"
        echo $R_LIBS_SITE
        echo "################"
        echo $PKG_CONFIG_PATH
        echo "################"
        echo $PYTHONPATH
        echo "################"
        echo $PERL5LIB
        echo "################"
    }
    output{
        String message = read_string(stdout())
    }
    runtime {
        docker: "g3chen/rsem:1.0"
    }
}

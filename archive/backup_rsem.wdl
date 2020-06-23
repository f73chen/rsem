version 1.0

workflow rsem {
input {
  File inputBam
  String outputFileNamePrefix = basename(inputBam, ".bam")
}

# run RSEM
call runRsem { input: inputFile = inputBam, sampleID = outputFileNamePrefix }

parameter_meta {
  inputBam: "Input BAM file with aligned RNAseq reads."
  outputFileNamePrefix: "Output prefix, customizable. Default is the input file's basename."
}

meta {
  author: "Peter Ruzanov"
  email: "peter.ruzanov@oicr.on.ca"
  description: "RSEM 2.0, workflow for accurate quantification of gene and isoform expression from RNA-Seq data"
  dependencies: [
      {
        name: "rsem/1.3.3",
        url: "https://github.com/deweylab/RSEM"
      }
    ]
    output_meta: {
      geneResults: "expression levels for all genes recorded in the reference",
      isoformResults: "expression levels for all isoforms recorded in the reference",
      transcriptBam: "BAM file with additional ZW:f:value, a single precision floating number representing the posterior probability"
    }
}

output {
  File geneResults = runRsem.genes
  File isoformResults = runRsem.isoforms
  File transcriptBam = runRsem.transcriptBam 
}

}

# ==========================
#  configure and run RSEM
# ==========================
task runRsem {
input {
  File inputFile
  String sampleID
  String rsemIndexDir
  String modules
  Int timeout = 48
  Int jobMemory = 12
}

parameter_meta {
 inputFile: "Input .bam file for analysis sample"
 jobMemory: "Memory in Gb for this job"
 rsemIndexDir: "Base of RSEM indexes, includes the directory common file prefix"
 modules: "Names and versions of modules"
 timeout: "Timeout in hours, needed to override imposed limits"
}

command <<<
 $RSEM_ROOT/bin/rsem-calculate-expression --bam --paired-end ~{inputFile} ~{rsemIndexDir} ~{sampleID}
>>>

runtime {
  memory:  "~{jobMemory} GB"
  modules: "~{modules}"
  timeout: "~{timeout}"
}

output {
  File genes    = "~{sampleID}.genes.results"
  File isoforms = "~{sampleID}.isoforms.results"
  File transcriptBam = "~{sampleID}.transcript.bam"
}
}


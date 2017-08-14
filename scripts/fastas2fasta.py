#! /usr/bin/env python

"""A script to reformat fasta downloaded from NCBI for Phame analysis.

The script was used for parsing Ebola virus strains
"""

# --- standard library imports
import argparse
from Bio import SeqIO
import re
import os


__author__ = "Migun Shakya"
__email__ = "microbeatic@gmail.com"
__version__ = "0.1"
__license__ = "The MIT License (MIT)"


def cmdline_parser():
    """
    Create an argparse instance.

    For inputs
    """
    parser = argparse.ArgumentParser(description="""program that converts a
        FASTA file with multple sequence to a FASTA file with one sequence,
        it adds extension, .fna, if the sequence header has complete genome,
        and adds .contif if the sequence header has partial sequence label""")
    parser.add_argument("-i", "--INPUT", help="""input FASTA file with multiple
        sequences""")
    parser.add_argument("-o", "--OUTPUT", help="""output folder where all fasta will be
        written""")
    return parser


def main():
    """Main function."""
    parser = cmdline_parser()
    args = parser.parse_args()

    if os.path.exists(args.OUTPUT) is False:
        os.makedirs(args.OUTPUT)

    sequence = SeqIO.parse(args.INPUT, "fasta")
    for seq in sequence:
        if 'complete genome' in seq.description:
            filename = re.sub('[^a-zA-Z0-9\n]', '_', seq.description) + ".fna"
            out_file = os.path.join(args.OUTPUT, filename)
            SeqIO.write(seq, out_file, 'fasta')
        elif 'partial genome' in seq.description:
            filename = re.sub('[^a-zA-Z0-9\n]', '_', seq.description) + ".contig"
            out_file = os.path.join(args.OUTPUT, filename)
            SeqIO.write(seq, out_file, 'fasta')

if __name__ == '__main__':
    main()

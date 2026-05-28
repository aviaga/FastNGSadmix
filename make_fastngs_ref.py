input_file = "snp_panel/dogBreedFreqs_clean.frq.strat"
output_file = "fastngsadmix/fastNGSadmix_ref.txt"
nind_file = "fastngsadmix/nInd.txt"


snp_data = {}
breeds = set()
breed_sizes = {}


with open(input_file) as f:
    next(f)
    for line in f:
        parts = line.strip().split()
        if len(parts) < 8:
            continue
        snp_raw = parts[1]  
        breed = parts[2]    
        a0 = parts[3]      
        a1 = parts[4]       
        freq = parts[5]    
        nchrobs = parts[7]  
        
        chrom, pos = snp_raw.split(":")[:2]
        snp = f"{chrom}_{pos}"
        
        nind = str(int(float(nchrobs) / 2))
        
        breeds.add(breed)
        if breed not in breed_sizes:
            breed_sizes[breed] = nind

        if snp not in snp_data:
            snp_data[snp] = {
                "chr": chrom.replace("chr", ""),
                "pos": pos,
                "a0": a0,
                "a1": a1,
                "freqs": {}
            }
        snp_data[snp]["freqs"][breed] = freq

breeds = sorted(list(breeds))

with open(output_file, "w") as out:
    header = ["id", "chr", "pos", "name", "A0", "A1"] + breeds
    out.write("\t".join(header) + "\n")
    for snp in snp_data:
        row = [snp, snp_data[snp]["chr"], snp_data[snp]["pos"], snp, snp_data[snp]["a0"], snp_data[snp]["a1"]]
        for breed in breeds:
            row.append(snp_data[snp]["freqs"].get(breed, "0"))
        out.write("\t".join(row) + "\n")

with open(nind_file, "w") as n_out:
    n_out.write("\t".join(breeds) + "\n")
    sizes_list = [breed_sizes[breed] for breed in breeds]
    n_out.write("\t".join(sizes_list) + "\n")

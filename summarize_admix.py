import sys


file_path = sys.argv[1]
sample_name = file_path.split('/')[-1].replace('.qopt', '').replace('_admix', '')

with open(file_path, 'r') as f:
    lines = f.readlines()

breeds = lines[0].strip().split()
proportions = [float(x) for x in lines[1].strip().split()]

results = [(b, p) for b, p in zip(breeds, proportions) if p > 0.0001]
results.sort(key=lambda x: x[1], reverse=True)

print(f"\nAdmixture Results for: {sample_name}")
print("-" * 45)
print(f"{'Breed':<35} {'Percentage':>8}")
print("-" * 45)

for breed, prop in results:
    percentage = prop * 100
    print(f"{breed:<35} {percentage:>7.2f}%")

print("-" * 45, "\n")

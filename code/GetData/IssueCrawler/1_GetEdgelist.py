##First Step: Download sociomatrix results from IssueCrawler

output_file1 = open("edgelist_rawICL2.csv", "w", encoding="utf-8")
output_file2 = open("edgelist_rawICL2_val.csv", "w", encoding="utf-8")

ic_mat = open("icl2_mat.csv")
columns = ic_mat.readline().strip().split(',')[1:]

for line in ic_mat:
    tokens = line.strip().split(',')
    row = tokens[0]
    for column, cell in zip(columns,tokens[1:]):
        if cell == '0':
            continue
        out = '{},{}'.format(row,column)
        out_valued = '{},{},{}'.format(row,column,cell)
        print(out)
        print(out, file = output_file1)
        print(out_valued, file = output_file2)

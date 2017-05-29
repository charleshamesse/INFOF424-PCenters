function read_instance(path)
  file = open(path)
  lines = readlines(file)

  n = parse(Int64, split(lines[1], ":")[2])
  println("N: $n")

  p = parse(Int64, split(lines[2], ":")[2])
  println("p: $p")

  d = zeros(Int64,n,n)
  offset = 3
  for i = 1:n
    line_splitted = split(lines[i+offset], "\t")
    for j = 1:n
      d[i, j] = parse(Int64, line_splitted[j])
    end
  end

  K = parse(Int64, split(lines[n+offset+3], ":")[2])
  println("K: $K")

  rho = zeros(Int64, K)
  for i = 1:K
	   rho[i] = parse(Int64, lines[i+n+offset+5])
  end

  return PCInstance(n,p,d,K,rho)
end
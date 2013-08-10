def lcs_length(a,b)
  return 0 if a.empty? || b.empty?
  if a.first == b.first
    1 + lcs_length(a.drop(1), b.drop(1))
  else
    len1 = lcs_length(a.drop(1), b)
    len2 = lcs_length(a, b.drop(1))
    if len1 >= len2
      len1
    else
      len2
    end
  end
end

# memoized
def subseq(a,b,memo={})
  return memo[[a,b]] if memo.has_key?([a,b])
  return [] if a.empty? || b.empty?
  if a.first == b.first
    [a.first] + subseq(a.drop(1), b.drop(1), memo)
  else
    seq1 = memo[[a.drop(1),b]] = subseq(a.drop(1), b, memo)
    seq2 = memo[[a,b.drop(1)]] = subseq(a, b.drop(1), memo)
    if seq1.count >= seq2.count
      seq1
    else
      seq2
    end
  end
end

# with indices, memoization
def lcs(a,b,i=0,j=0, memo={})
  return memo[[a,b,i,j]] if memo.has_key?([a,b,i,j])
  return [] if a.empty? || b.empty?
  if a.first == b.first
    [[a.first,i,j]] + lcs(a.drop(1), b.drop(1), i+1, j+1, memo)
  else
    seq1 = memo[[a.drop(1), b, i+1, j]] = lcs(a.drop(1), b, i+1, j, memo)
    seq2 = memo[[a, b.drop(1), i, j+1]] = lcs(a, b.drop(1), i, j+1, memo)
    if seq1.count >= seq2.count
      seq1
    else
      seq2
    end
  end
end

# with indeces, not memoized
def subseq_index(a,b,p_a=0,p_b=0)
  return [] if a.empty? || b.empty?
  if a.first == b.first
    [[a.first,p_a,p_b]] + subseq_index(a.drop(1), b.drop(1), p_a+1, p_b+1)
  else
    seq1 = subseq_index(a.drop(1), b, p_a+1, p_b)
    seq2 = subseq_index(a, b.drop(1), p_a, p_b+1)
    if seq1.count >= seq2.count
      seq1
    else
      seq2
    end
  end
end

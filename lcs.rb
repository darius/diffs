require 'minitest/autorun'

def lcs_length(a,b)
  if a.empty? || b.empty?
    return 0
  elsif (a.length == 1 && b.include?(a[0])) || (b.length == 1 && a.include?(b[0]))
    return 1
  elsif a.first == b.first
    lcs_length(a.drop(1), b.drop(1)) + 1
  else
    max(lcs_length(a.drop(1), b), lcs_length(b.drop(1), a))
  end
end


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

# memoize
def subseq_index(a,b,i=0,j=0, memo={})
  return memo[[a,b,i,j]] if memo.has_key?([a,b,i,j])
  return [] if a.empty? || b.empty?
  if a.first == b.first
    [[a.first,i,j]] + subseq_index(a.drop(1), b.drop(1), i+1, j+1, memo)
  else
    seq1 = memo[[a.drop(1), b, i+1, j]] = subseq_index(a.drop(1), b, i+1, j, memo)
    seq2 = memo[[a, b.drop(1), i, j+1]] = subseq_index(a, b.drop(1), i, j+1, memo)
    if seq1.count >= seq2.count
      seq1
    else
      seq2
    end
  end
end


# def subseq_index(a,b,p_a=0,p_b=0)
#   return [] if a.empty? || b.empty?
#   if a.first == b.first
#     [[a.first,p_a,p_b]] + subseq_index(a.drop(1), b.drop(1), p_a+1, p_b+1)
#   else
#     seq1 = subseq_index(a.drop(1), b, p_a+1, p_b)
#     seq2 = subseq_index(a, b.drop(1), p_a, p_b+1)
#     if seq1.count >= seq2.count
#       seq1
#     else
#       seq2
#     end
#   end
# end




class TestIndexSeq < MiniTest::Unit::TestCase
  def test_a_empty
    assert_equal(subseq_index([], [1,2]), [])
  end

  def test_b_empty
    assert_equal(subseq_index([1,2,3], []), [])
  end

  def test_a_subseq_b
    assert_equal(subseq_index([1,2], [5,1,3,2,5]), ([[1,0,1], [2,1,3]]))
  end

  def test_a_overlap_b
    assert_equal(subseq_index([1,2,5], [5,1,3,2,5]), ([[1,0,1], [2,1,3] ,[5,2,4]]))
  end

end




class TestSeq < MiniTest::Unit::TestCase

  def test_a_empty
    assert_equal(subseq([], [1,2]), [])
  end

  def test_b_empty
    assert_equal(subseq([1,2,3], []), [])
  end

  def test_a_subseq_b
    assert_equal(subseq([1,2], [5,1,3,2,5]), [1,2])
  end

  def test_a_overlap_b
    assert_equal(subseq([1,2,5], [5,1,3,2,5]), [1,2,5])
  end


end










class TestLCS < MiniTest::Unit::TestCase

  def test_lcs_length_empty
    a = []
    b = [1]
    assert_equal(lcs_length(a,b), 0)
  end

  def test_lcs_length_identical
    a = [1,2,3]
    b = [1,2,3]
    assert_equal(lcs_length(a,b), 3)
  end

  def test_lcs_length_one_common
    a = [1,2,3,4]
    b = [9,2,5]
    assert_equal(lcs_length(a,b), 1)
  end

end
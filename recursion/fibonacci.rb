# frozen-string-literal: true

def fibs(num)
  return 0 if num.zero?

  last = 0
  current = 1
  1.upto(num) { last, current = current, last + current }
  last
end

def fibs_rec(num)
  return 0 if num.zero?

  return 1 if num == 1

  fibs_rec(num - 1) + fibs_rec(num - 2)
end

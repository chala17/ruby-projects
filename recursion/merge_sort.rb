# frozen-string-literal: true

def merge_sort(arr)
  return arr if arr.length < 2

  b = merge_sort(arr.slice(0, arr.length / 2))
  c = merge_sort(arr.slice((arr.length / 2), (arr.length - 1)))
  a = []
  b[0] < c[0] ? a.append(b.shift) : a.append(c.shift) until b.empty? || c.empty?
  a.concat(b, c)
end

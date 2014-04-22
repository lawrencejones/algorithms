sqrt = (n) -> Math.floor Math.sqrt n

containsFactor = (ps, n) ->
  s = sqrt(n); for f in ps
    return true if n % f is 0
    return false if f > s

genPrimes_reduce = (n) ->
  (2*i+1 for i in [1..(n-1)/2]).reduce ((a,c) ->
    a.push c if not containsFactor a, c; a
  ), [2]

genPrimes = (n) ->
  primes = [2]; i = 1
  while (i += 2) < n
    primes.push i if not containsFactor primes, i
  primes

module.exports = gemPrimesTo = (lim) ->
  primes = [2]; i = 1
  while primes.length < lim
    i += 2
    primes.push i if not containsFactor primes, i
  primes

largestPrimeFactor = (n) ->
  primes = genPrimes(sqrt n)
  for i in [primes.length - 1...0]
    if n % primes[i] is 0 then return p

test = ->
  print = (task, formatter) ->
    start = new Date
    res = do task
    duration = ((new Date) - start)/1000
    formatter res, duration
  
  n = parseInt process.argv[2], 10
  print (-> genPrimes n), (res, dur) ->
    console.log "Found #{res.length} primes with non reduce in #{dur}s"
  print (-> genPrimes_reduce n), (res, dur) ->
    console.log "Found #{res.length} primes with reduce in #{dur}s"

# Provides comparison of reducing against inplace array operations.
do test

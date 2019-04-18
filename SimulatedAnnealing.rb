def fungsi (x1,x2) #Method untuk mengembalikan nilai dari fungsi
  return -((Math.sin(x1) * Math.cos(x2)) + ((4.0/5.0) * Math.exp(1 - Math.sqrt((x1 ** 2) + (x2 ** 2)))))
end

#Method untuk menerima inputan X1,X2 dengan mengembalikan nilai dari fungsi(x1,x2)
def cost(state)
  return fungsi(state[0], state[1])
end

#Method untuk menerima inputan nC, cC, temp serta perhitungan probabilitas
#dengan mengembalikan nilai probabilita
def prob(nC,cC,temp)
  deltaE = nC - cC
  return Math.exp(-(deltaE)/temp)
end

def fungsiRandom() #Method untuk mengembalikan nilai random dengan range (-10,10)
  return rand(-10.0..10.0)
end

def fungsiRandom01() #Method untuk mengembalikan nilai random dengan range (0,1)
  return rand(0.0..1.0)
end

#Method untuk menerima inputan is, cS, cC, bSolution, bCost, temp, final_temp,
#alpha serta algortima Simulated Annealing dengan mengembalikan nilai solusiTemp,
#solusiBestSolution, solusiBestCost
def simulatedAnnealing(is,cS,cC,bSolution,bCost,temp,final_temp,alpha)
  #membuat array untuk menampung setiap solusi
  solusiTemp = {}
  solusiBestSolution = {}
  solusiBestCost= {}
  j=1 #insisialisasi
  while temp > final_temp do

    for i in 1..100
      #memunculkan bilangan random untuk perbandingan sekarang dengan yang baru
      x11 = fungsiRandom()
      x22 = fungsiRandom()
      nS = [x11,x22] #state baru
      nC = cost(nS) #perhitungan fungsi dari state baru
    end
    if nC < cC then #membandingkan costBaru dengan costSekarang
      cS = nS
      cC = nC
      if cC < bCost then #jika costBaru lebih kecil dari costSekarang maka bandingkan dengan bestCost
        bSolution = cS
        bCost = cC
      end
    else #jika tidak maka diliat nilai probab
      #ilitasnya lalu bandignkan dengan nilai random(0,1)
      if (prob(nC,cC,temp) > fungsiRandom01()) then
        cS = nS
        cC = nC
      end
      #menampung solusi
      solusiTemp[j] = temp
      solusiBestSolution[j] = bSolution
      solusiBestCost[j] = bCost
    end
    j = j+1
    temp = temp * alpha #Menghitung penentu iterasi temperatur
  end
  xx = solusiTemp[solusiTemp.length]
  y = bSolution
  z = bCost
  #mengembalikan nilai solusi
  return solusiTemp,solusiBestSolution,solusiBestCost,xx,y,z

end

def akurasi(numeric,exact)
  return - (1.0 - ( (numeric/exact) * 100.0 ))
end


if __FILE__ == $0


  xx1,xx2 = 0.0,0.0 #variabel untuk menghitung nilai exact
  temp = 100 #Suhu yang di set dengan nilai 100
  final_temp = 0.0000001 #Suhu yang di set dengan nilai 0,00001
  alpha = 0.9999 #Menghitung penentu Iterasi Temperature di set 0,9999

  #variable yang di set dengan Method fungsiRandom
  x1 = fungsiRandom()
  x2 = fungsiRandom()

  is = [x1,x2] #inisial state
  cS = is #kondisi state sekarang yang di isi state awal
  cC = cost(is) #perhitungan fungsi dengan state sekarang

  #Asumsikan inisial awal langsung menjadi bestSulotions dan bestCost
  bSolution = is
  bCost = cC

  #3 variabel untuk menampung Method simulatedAnnealing
  bestTemp,bestState,bestCost,x,y,z = simulatedAnnealing(is,cS,cC,bSolution,bCost,temp,final_temp,alpha)
  akurasi = akurasi(z,fungsi(xx1,xx2))
  j = 0
  while j != bestTemp.length do
    puts "  #{bestTemp[j]}\t#{bestState[j]}\t#{bestCost[j]}"
    j = j+1
  end

  i = 0
  while i != 4 do
    puts "              |                                       |                                 |"
    i = i+1
  end
  puts "              V                                       V                                 V"
  puts "         TEMPERATURE                                STATE                           F(X1,X2)     "
  puts "                          ITERASI DIATAS MERUPAKAN PENCARIAN NILAI MINIMUM                       "
  puts "\nTUGAS AI SIMULATED ANNEALING"
  puts "  Nama  : Alanu Dinasti Permana"
  puts "  NIM   : 130116-774"
  puts "  Kelas : IFIK - 40 - 03"
  puts "\nMenentukan nilai minimum dari sebuah fungsi"
  puts "menggunakan metode Simulated Annealing\n"

  puts "\nINISIALISASI AWAL"
  puts "  Temperature                   : #{temp}"
  puts "  Final Temperature             : #{final_temp}"
  puts "  Alpha                         : #{alpha}"
  puts "  X1 awal (Random)              : #{x1}"
  puts "  X2 awal (Random)              : #{x2}"
  puts "  Initial State                 : #{is}"
  puts "  State saat ini                : #{cS}"
  puts "  f(X1,X2) awal                 : #{cC}"
  puts "  State terbaik awal            : #{bSolution}"
  puts "  Fungsi Minimum f(X1,X2) awal  : #{bCost}"

  puts "\nSOLUSI NUMERIC"
  puts "  Temperature                   : #{x}" #solusi temperature
  puts "  State Minimum (X1,X2)         : #{y}" #solusi x1,x2
  puts "  Fungsi Minimum f(X1,X2)       : #{z}" #solusi fungsi minimum
  puts "\nSOLUSI EXACT f(0,0)             : #{fungsi(xx1,xx2)}" #nilai exact
  puts "\nAKURASI                         : #{akurasi} %"


end
